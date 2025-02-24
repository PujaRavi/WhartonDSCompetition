######################################################## # nolint
## 2025 Wharton Data Science Competition
## EloModel.r
## This is program which takes file games_2022_D1_maste.csv and
## and the ELO Ranking.csv files and applies
## Free Throw adjustments in 3 rounds
## Then it ranks the teams from four Regions
##
## INPUT FILE: data/games_2022_D1_master.csv
## INPUT FILE: data/ELO Rankings.csv
## OUTPUT FILE: data/ELO Rankings.csv
##
## Programmer: Puja Ravi (International Academy)
######################################################## # nolint
"2025 Wharton Data Science Competition"
print("MODULE START: ELO MODEL: RANK BY FREE THROW ADJUSTMENTS")
library(dplyr)
#############################################################
## ELO MODEL: RUN CONTROLLER USED TO MAKE CERTAIN MODULES RUN
#############################################################
## ELO MODEL STEP 1: ADJUSTMENTS - FREE THROWS - ROUND 1
## ELO MODEL STEP 2: ADJUSTMENTS - FREE THROWS - ROUND 2
## ELO MODEL STEP 3: ADJUSTMENTS - FREE THROWS - ROUND 3
## ELO MODEL STEP 4: ADJUSTMENTS FREE THROWS CHANGE FROOM RAW TO ROUND 3
#############################################################
step_1 <- "Run"
step_2 <- "Run"
step_3 <- "Run"
step_4 <- "Run"
##################################################################
## ELO MODEL: ADJUSTMENTS - FREE THROWS - ROUND 1
##################################################################
if (step_1 == "Run") {
  # Calculate League Average from Free Throws
  games_data <- read.csv("data/games_2022_D1_master.csv", header = TRUE, sep = ",") # nolint
  team_ranking <- read.csv("data/ELO RANKINGS.csv", header = TRUE, sep = ",") # nolint
  # Calculating League Summary data
  FT_Attempts <- sum(games_data$FTA) # nolint
  FT_Made <- sum(games_data$FTM) # nolint
  FT_Percentage <- round(as.numeric(FT_Made) / as.numeric(FT_Attempts) * 100, 2) # nolint
  FT_Advantage <- FT_Percentage - 50 # nolint
  # Update Free Throw Advantage for each game in games_data # nolint
  games_data$FTAdvRnd1 <- NA
  games_data$FTAdvRnd1 <- games_data$FTP -  FT_Advantage # nolint
  # Summarize the Free Throw adjustment and Rank the teams
  # Calculate average FTAdvRnd1 for each team in games_data # nolint
  team_avg_home_adv <- games_data %>%
    group_by(team) %>%
    summarize(FreeThrowAdj1Percentage = mean(FTAdvRnd1, na.rm = TRUE)) #na.rm to remove NA values from mean # nolint
  team_ranking <- merge(team_ranking, team_avg_home_adv, by = "team", all.x = TRUE) # nolint
  # Calculate Round 1 percentage for FTAdvRnd1
  team_ranking$FTAdj1Percentage <- NA
  team_ranking$FTAdj1Percentage <- team_ranking$HomeAwayAdj3Percentage + team_ranking$FreeThrowAdj1Percentage # nolint
  new_rank_column <- "RankFTAdj1"
  team_ranking <- team_ranking %>%
    group_by(region) %>%
    mutate(!!new_rank_column := dense_rank(desc(`FTAdj1Percentage`)))
  write.csv(games_data, "data/games_2022_D1_master.csv")
  write.csv(team_ranking, "data/ELO RANKINGS.csv")
}
##################################################################
## ELO MODEL: ADJUSTMENTS - 2-POINT THROWS - ROUND 2
##################################################################
if (step_2 == "Run") {
  # Calculate League Average from Free Throws
  games_data <- read.csv("data/games_2022_D1_master.csv", header = TRUE, sep = ",") # nolint
  team_ranking <- read.csv("data/ELO RANKINGS.csv", header = TRUE, sep = ",") # nolint
  # Calculating League Summary data
  FT_Attempts <- sum(games_data$FTA) # nolint
  FT_Made <- sum(games_data$FTM) # nolint
  FT_Percentage <- round(as.numeric(FT_Made) / as.numeric(FT_Attempts) * 100, 2) # nolint
  FT_Advantage <- FT_Percentage - 50 # nolint
  # Update Free Throw Advantage for each game in games_data # nolint
  games_data$FTAdvRnd2 <- NA
  games_data$FTAdvRnd2 <- games_data$FTAdvRnd1 -  FT_Advantage # nolint
  # Summarize the Free Throw adjustment and Rank the teams
  # Calculate average FTAdvRnd2 for each team in games_data # nolint
  team_avg_home_adv <- games_data %>%
    group_by(team) %>%
    summarize(FreeThrowAdj2Percentage = mean(FTAdvRnd2, na.rm = TRUE)) #na.rm to remove NA values from mean # nolint
  team_ranking <- merge(team_ranking, team_avg_home_adv, by = "team", all.x = TRUE) # nolint
  # Calculate Round 2 percentage for FTAdvRnd2
  team_ranking$FTAdj2Percentage <- NA
  team_ranking$FTAdj2Percentage <- team_ranking$FTAdj1Percentage + team_ranking$FreeThrowAdj2Percentage # nolint
  new_rank_column <- "RankFTAdj2"
  team_ranking <- team_ranking %>%
    group_by(region) %>%
    mutate(!!new_rank_column := dense_rank(desc(`FTAdj2Percentage`)))
  write.csv(games_data, "data/games_2022_D1_master.csv")
  write.csv(team_ranking, "data/ELO RANKINGS.csv")
}
##################################################################
## ELO MODEL: ADJUSTMENTS - 3-POINT THROWS - ROUND 3
##################################################################
if (step_3 == "Run") {
  # Calculate League Average from Free Throws
  games_data <- read.csv("data/games_2022_D1_master.csv", header = TRUE, sep = ",") # nolint
  team_ranking <- read.csv("data/ELO RANKINGS.csv", header = TRUE, sep = ",") # nolint
  # Calculating League Summary data
  FT_Attempts <- sum(games_data$FTA) # nolint
  FT_Made <- sum(games_data$FTM) # nolint
  FT_Percentage <- round(as.numeric(FT_Made) / as.numeric(FT_Attempts) * 100, 2) # nolint
  FT_Advantage <- FT_Percentage - 50 # nolint
  # Update Free Throw Advantage for each game in games_data # nolint
  games_data$FTAdvRnd3 <- NA
  games_data$FTAdvRnd3 <- games_data$FTAdvRnd2 -  FT_Advantage # nolint
  # Summarize the Free Throw adjustment and Rank the teams
  # Calculate average FTAdvRnd3 for each team in games_data # nolint
  team_avg_home_adv <- games_data %>%
    group_by(team) %>%
    summarize(FreeThrowAdj3Percentage = mean(FTAdvRnd3, na.rm = TRUE)) #na.rm to remove NA values from mean # nolint
  team_ranking <- merge(team_ranking, team_avg_home_adv, by = "team", all.x = TRUE) # nolint
  # Calculate Round 2 percentage for FTAdvRnd3
  team_ranking$FTAdj3Percentage <- NA
  team_ranking$FTAdj3Percentage <- team_ranking$FTAdj2Percentage + team_ranking$FreeThrowAdj3Percentage # nolint
  new_rank_column <- "RankFTAdj3"
  team_ranking <- team_ranking %>%
    group_by(region) %>%
    mutate(!!new_rank_column := dense_rank(desc(`FTAdj3Percentage`)))
  write.csv(games_data, "data/games_2022_D1_master.csv")
  write.csv(team_ranking, "data/ELO RANKINGS.csv")
}
##########################################################################
## ELO MODEL STEP 4: ADJUSTMENTS 3-POINT THROWS FROM RAW TO ROUND 3
##########################################################################
if (step_4 == "Run") {
  team_ranking <- read.csv("data/ELO RANKINGS.csv", header = TRUE, sep = ",") # nolint
  team_ranking$FTAdjChangePercentage <- NA
  team_ranking$FTAdjChangePercentage <- team_ranking$FTAdj3Percentage - team_ranking$HomeAwayAdj3Percentage # nolint
  team_ranking$FTAdjChangeRank <- NA
  team_ranking$FTAdjChangeRank <- team_ranking$RankFTAdj3 - team_ranking$RankHAAdj3 # nolint
  write.csv(team_ranking, "data/ELO RANKINGS.csv")
}
print("MODULE END: ELO MODEL: RANK BY FREE THROW ADJUSTMENTS")