library(dplyr)
library(stringr)
library(xgboost)

# Load up data files (downloaded from Kaggle)
m_TourneySeeds = read.csv('data/MNCAATourneySeeds.csv')
m_Teams = read.csv('data/MTeams.csv')
m_RegCompact = read.csv('data/MRegularSeasonCompactResults.csv')
m_RegDetailed = read.csv('data/MRegularSeasonDetailedResults.csv')
submission_df = read.csv('data/SampleSubmissionStage1.csv')
m_Seasons = read.csv('data/MSeasons.csv')
m_Conferences = read.csv('data/MTeamConferences.csv')
m_TourneyCompact = read.csv('data/MNCAATourneyCompactResults.csv')

# Grab the unique teamID values
uni_m_teams = unique(m_Teams$TeamID)

# For every unique team, I want to grab specific stats and group them by year
# This loop looks complex, but broken down is actually just grabbing specific metrics
# for every team.
for(i in 1:length(uni_m_teams)){
  m_team = m_RegDetailed %>%
    filter(WTeamID == uni_m_teams[i] | LTeamID == uni_m_teams[i]) %>%
    mutate(Win = ifelse(WTeamID == uni_m_teams[i], 1, 0)) %>%
    group_by(Season) %>%
    summarize(win_sum = sum(Win),
              loss_sum = sum(Win == 0),
              three_point_att = sum(WFGA3[Win == 1], LFGA3[Win == 0]),
              three_point_made = sum(WFGM3[Win == 1], LFGM3[Win == 0]),
              points_for = sum(WScore[Win == 1], LScore[Win == 0]),
              points_against = sum(WScore[Win == 0], LScore[Win == 1])) %>%
    mutate(TeamID = uni_m_teams[i]) %>%
    left_join(m_TourneySeeds, by = c("Season","TeamID")) %>%
    left_join(m_Conferences, by = c("Season", "TeamID"))
  
  # Combine all teams data into one dataframe
  if(i == 1){
    comb_team_records = m_team
  }else{
    comb_team_records = rbind(comb_team_records, m_team)
  }
}

# Convert seed values to numeric values and remove regions
comb_team_records$Seed = as.numeric(str_match(comb_team_records$Seed, pattern = "(\\d+)")[,2])

# Map conferences to numeric strength values
comb_team_records$ConfRank = NA
comb_team_records$ConfRank[comb_team_records$ConfAbbrev == "big_ten" |
                             comb_team_records$ConfAbbrev == "sec" |
                             comb_team_records$ConfAbbrev == "acc" |
                             comb_team_records$ConfAbbrev == "big_twelve" |
                             comb_team_records$ConfAbbrev == "pac_twelve" |
                             comb_team_records$ConfAbbrev == "pac_ten" |
                             comb_team_records$ConfAbbrev == "big_east"] = 1
comb_team_records$ConfRank[comb_team_records$ConfAbbrev == "aac" |
                             comb_team_records$ConfAbbrev == "mwc" |
                             comb_team_records$ConfAbbrev == "mvc" |
                             comb_team_records$ConfAbbrev == "wcc" |
                             comb_team_records$ConfAbbrev == "a_ten" |
                             comb_team_records$ConfAbbrev == "cusa"] = 2
comb_team_records$ConfRank[comb_team_records$ConfAbbrev == "caa" |
                             comb_team_records$ConfAbbrev == "aec" |
                             comb_team_records$ConfAbbrev == "southern" |
                             comb_team_records$ConfAbbrev == "sun_belt" |
                             comb_team_records$ConfAbbrev == "horizon" |
                             comb_team_records$ConfAbbrev == "maac" |
                             comb_team_records$ConfAbbrev == "big_west" |
                             comb_team_records$ConfAbbrev == "mac" |
                             comb_team_records$ConfAbbrev == "mid_cont" |
                             comb_team_records$ConfAbbrev == "summit" |
                             comb_team_records$ConfAbbrev == "big_sky" |
                             comb_team_records$ConfAbbrev == "big_south" |
                             comb_team_records$ConfAbbrev == "patriot"] = 3
comb_team_records$ConfRank[comb_team_records$ConfAbbrev == "wac" |
                             comb_team_records$ConfAbbrev == "southland" |
                             comb_team_records$ConfAbbrev == "ovc" |
                             comb_team_records$ConfAbbrev == "ivy" |
                             comb_team_records$ConfAbbrev == "nec" |
                             comb_team_records$ConfAbbrev == "meac" |
                             comb_team_records$ConfAbbrev == "swac" |
                             comb_team_records$ConfAbbrev == "a_sun" |
                             comb_team_records$ConfAbbrev == "gwc" |
                             comb_team_records$ConfAbbrev == "ind"] = 4

# Assign teams with no tournament seed a seed of 20 (this is just an arbitrary value larger than 16).
# In this example, the seed of non-tournament teams doesn't matter anyways
comb_team_records$Seed[is.na(comb_team_records$Seed)] = 20

# Remove the conference abbreviation, we need all numeric values for xgboost
comb_team_records = comb_team_records %>%
  select(-ConfAbbrev)

#### some QC
# check if there are 64 (68 for play-ins) teams per season with tournament seeds
# 2020 will be 0 because of covid
season_seeding = comb_team_records %>%
  filter(Season == 2024)

length(which(!is.na(season_seeding$Seed)))


# I'm just duplicating the combined team dataframe with different column names.
# I'm doing this because I need their column names to be different when I join
# them in the code chunk below this one.
comb_team = comb_team_records %>%
  rename_with(~ paste0(.,"_team"), c(-TeamID, -Season))
comb_opponent = comb_team_records %>%
  rename_with(~ paste0(.,"_opponent"), c(-TeamID, -Season))

# I want to build my model based on past tournament matchups.
# To do this, I need to duplicate the m_TourneyCompact dataset
# since right now, only WTeamID wins every match.
# I need the data from both perspectives
df = data.frame(
  Season = rep(m_TourneyCompact$Season, 2),
  TeamID = c(m_TourneyCompact$WTeamID, m_TourneyCompact$LTeamID),  # First batch is winners, second is losers
  OpponentID = c(m_TourneyCompact$LTeamID, m_TourneyCompact$WTeamID),  # First batch is losers, second is winners
  Win = c(rep(1, nrow(m_TourneyCompact)), rep(0, nrow(m_TourneyCompact)))  # Winner gets 1, loser gets 0
) %>%
  filter(Season >= 2003) %>%
  left_join(comb_team, join_by("TeamID" == "TeamID", "Season" == "Season")) %>%
  left_join(comb_opponent, join_by("OpponentID" == "TeamID", "Season" == "Season"))


## Build xgboosted model

# Define my training data as all tournaments before 2020
train_data = df %>%
  filter(Season >= 2003 & Season < 2020)

# Extract the label
train_label = train_data$Win

# Remove the label from training data
train_data = train_data %>% select(-Win)

# Convert training data to matrix. This is necessary for xgboost to work
train.m = as.matrix(train_data)

# Creat boosted model. The values chosen here are random, we will tune later
bst = xgboost(data = train.m,
              label = train_label,
              objective = "binary:logistic",
              nrounds = 200,
              max_depth = 4)

# Plot importance matrix of features
importance_matrix = xgb.importance(bst$feature_names, bst)
xgb.plot.importance(importance_matrix)

# Define our test data as all tournaments after 2020
test_data = df %>%
  filter(Season > 2020)

# Extract label
test_label = test_data$Win

# Remove label from test data
test_data = test_data %>%
  select(-Win)

# Convert to matrix
test.m = as.matrix(test_data)

# Use our xgboost model to predict on our test matrix
predictions = predict(bst, test.m)

# Build a dataframe to examine our predictions vs ground truth
examine = data.frame(
  test_label = test_label,
  predictions = predictions
) %>%
  mutate(BinaryPred = ifelse(predictions >= 0.5, 1, 0))

# Simple measure of how often our model was correct
n_correct = length(which(examine$test_label == examine$BinaryPred))
n_correct / nrow(test_data) * 100