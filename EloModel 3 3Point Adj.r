######################################################## # nolint
## 2025 Wharton Data Science Competition
## EloModel.r
## This is program which takes file games_2022_D1_maste.csv and
## and the ELO Ranking.csv files and applies
## HomeAway adjustments in 3 rounds
## Then it ranks the teams from four Regions
##
## INPUT FILE: data/games_2022_D1_master.csv
## INPUT FILE: data/ELO Rankings.csv
## OUTPUT FILE: data/ELO Rankings.csv
##
## Programmer: Puja Ravi (International Academy)
######################################################## # nolint
"2025 Wharton Data Science Competition"
print("MODULE START: ELO MODEL: RANK BY HOME AWAY ADJUSTMENTS")
library(dplyr)
#############################################################
## ELO MODEL: RUN CONTROLLER USED TO MAKE CERTAIN MODULES RUN
#############################################################
## ELO MODEL STEP 1: ADJUSTMENTS - HOME_AWAY AND RANKING - ROUND 1
## ELO MODEL STEP 2: ADJUSTMENTS - HOME_AWAY AND RANKING - ROUND 2
## ELO MODEL STEP 3: ADJUSTMENTS - HOME_AWAY AND RANKING - ROUND 3
## ELO MODEL STEP 4: ADJUSTMENTS HOME AWAY CHANGE FROOM RAW TO ROUND 3
#############################################################
step_1 <- "Run"
step_2 <- "Run"
step_3 <- "Run"
step_4 <- "Run"
##################################################################
## ELO MODEL STEP 1: ADJUSTMENTS - HOME_AWAY AND RANKING - ROUND 1
##################################################################
if (step_1 == "Run") {
  # Calculate League Average from Home Wins and Away Wins
  games_data <- read.csv("data/games_2022_D1_master.csv", header = TRUE, sep = ",") # nolint
  team_ranking <- read.csv("data/ELO RANKINGS.csv", header = TRUE, sep = ",") # nolint
  # exclude Games played at NEUTRAL locations
  games_data_without_neutral_games <- games_data[games_data$home_away != "neutral", ]
  # Calculating League Summary data
  league_summary <- aggregate(cbind(Wins = Win, Losses = Loss, Games = Win + Loss) ~ home_away, data = games_data_without_neutral_games, sum)
  league_summary$WinPercentage <- round(as.numeric(league_summary$Wins) / as.numeric(league_summary$Games) * 100, 2)
  home_win_percentage <- league_summary$WinPercentage[league_summary$home_away == "home"] # nolint
  away_win_percentage <- league_summary$WinPercentage[league_summary$home_away == "away"]
  league_avg <- (home_win_percentage + away_win_percentage) / 2
  league_summary$Advantage <- NA
  league_summary$Advantage <- league_summary$WinPercentage - league_avg
  home_advantage <- league_summary$Advantage[league_summary$home_away == "home"]
  away_advantage <- league_summary$Advantage[league_summary$home_away == "away"]
  # Update home_advantage and away_advantage to each game in games_data_without_neutral_games
  games_data_without_neutral_games$HomeAdvRnd1 <- NA
  games_data_without_neutral_games$HomeAdvRnd1[games_data_without_neutral_games$home_away == "home"] <- home_advantage
  games_data_without_neutral_games$HomeAdvRnd1[games_data_without_neutral_games$home_away == "away"] <- away_advantage
  # Summarize the Home Away adjustment and Rank the teams
  # Calculate average HomeAdvRnd1 for each team in game_data_without_neutral_games
  team_avg_home_adv <- games_data_without_neutral_games %>%
    group_by(team) %>%
    summarize(HomeAwayAdj1Percentage = mean(HomeAdvRnd1, na.rm = TRUE)) #na.rm to remove NA values from mean
  team_ranking <- merge(team_ranking, team_avg_home_adv, by = "team", all.x = TRUE)
    # Calculate Round 1 percentage for HomeAdvRnd1
  team_ranking$HWAdj1Percentage <- NA
  team_ranking$HWAdj1Percentage <- team_ranking$RawWinPercentage + team_ranking$HomeAwayAdj1Percentage
  team_ranking <- team_ranking %>%
    group_by(region) %>%
    mutate(WinRank2 = dense_rank(desc(`HomeAwayAdj1Percentage`)))
  write.csv(league_summary, "data/ELO League Summary.csv")
  write.csv(games_data_without_neutral_games, "data/games_data_without_neutral_games.csv")
  write.csv(team_ranking, "data/ELO RANKINGS.csv")
  rm(league_summary)
  rm(team_avg_home_adv)
}
##################################################################
## ELO MODEL STEP 2: ADJUSTMENTS - HOME_AWAY AND RANKING - ROUND 2
##################################################################
if (step_2 == "Run") {
  games_data_without_neutral_games <- read.csv("data/games_data_without_neutral_games.csv", header = TRUE, sep = ",") # nolint
  team_ranking <- read.csv("data/ELO RANKINGS.csv", header = TRUE, sep = ",") # nolint
  league_summary <- read.csv("data/ELO League Summary.csv", header = TRUE, sep = ",") # nolint
  # Calculating League Summary data
  home_advantage <- league_summary$Advantage[league_summary$home_away == "home"]
  away_advantage <- league_summary$Advantage[league_summary$home_away == "away"]
  # Update home_advantage and away_advantage to each game in games_data_without_neutral_games
  games_data_without_neutral_games$HomeAdvRnd2 <- NA
  games_data_without_neutral_games$HomeAdvRnd2[games_data_without_neutral_games$home_away == "home"] <- home_advantage
  games_data_without_neutral_games$HomeAdvRnd2[games_data_without_neutral_games$home_away == "away"] <- away_advantage
  # Summarize the Home Away adjustment and Rank the teams
  # Calculate average HomeAdvRnd2 for each team in game_data_without_neutral_games
  team_avg_home_adv <- games_data_without_neutral_games %>%
    group_by(team) %>%
    summarize(HomeAwayAdj2Percentage = mean(HomeAdvRnd2, na.rm = TRUE)) #na.rm to remove NA values from mean
  team_ranking <- merge(team_ranking, team_avg_home_adv, by = "team", all.x = TRUE)
    # Calculate Round 2 percentage for HomeAdvRnd2
  team_ranking$HWAdj2Percentage <- NA
  team_ranking$HWAdj2Percentage <- team_ranking$HWAdj1Percentage + team_ranking$HomeAwayAdj2Percentage
  team_ranking <- team_ranking %>%
    group_by(region) %>%
    mutate(WinRank3 = dense_rank(desc(`HomeAwayAdj2Percentage`)))
  rm(team_avg_home_adv)
  rm(league_summary)
  write.csv(games_data_without_neutral_games, "data/games_data_without_neutral_games.csv")
  write.csv(team_ranking, "data/ELO RANKINGS.csv")
}
##################################################################
## ELO MODEL STEP 3: ADJUSTMENTS - HOME_AWAY AND RANKING - ROUND 3
##################################################################
if (step_3 == "Run") {
  games_data_without_neutral_games <- read.csv("data/games_data_without_neutral_games.csv", header = TRUE, sep = ",") # nolint
  team_ranking <- read.csv("data/ELO RANKINGS.csv", header = TRUE, sep = ",") # nolint
  league_summary <- read.csv("data/ELO League Summary.csv", header = TRUE, sep = ",") # nolint
  # Calculating League Summary data
  home_advantage <- league_summary$Advantage[league_summary$home_away == "home"]
  away_advantage <- league_summary$Advantage[league_summary$home_away == "away"]
  # Update home_advantage and away_advantage to each game in games_data_without_neutral_games
  games_data_without_neutral_games$HomeAdvRnd3 <- NA
  games_data_without_neutral_games$HomeAdvRnd3[games_data_without_neutral_games$home_away == "home"] <- home_advantage
  games_data_without_neutral_games$HomeAdvRnd3[games_data_without_neutral_games$home_away == "away"] <- away_advantage
  # Summarize the Home Away adjustment and Rank the teams
  # Calculate average HomeAdvRnd3 for each team in game_data_without_neutral_games
  team_avg_home_adv <- games_data_without_neutral_games %>%
    group_by(team) %>%
    summarize(HomeAwayAdj3Percentage = mean(HomeAdvRnd3, na.rm = TRUE)) #na.rm to remove NA values from mean
  team_ranking <- merge(team_ranking, team_avg_home_adv, by = "team", all.x = TRUE)
    # Calculate Round 1 percentage for HomeAdvRnd3
  team_ranking$HWAdj3Percentage <- NA
  team_ranking$HWAdj3Percentage <- team_ranking$HWAdj2Percentage + team_ranking$HomeAwayAdj3Percentage
  team_ranking <- team_ranking %>%
    group_by(region) %>%
    mutate(WinRank4 = dense_rank(desc(`HomeAwayAdj3Percentage`)))
  rm(team_avg_home_adv)
  rm(league_summary)
  write.csv(games_data_without_neutral_games, "data/games_data_without_neutral_games.csv")
  write.csv(team_ranking, "data/ELO RANKINGS.csv")
  file.remove("data/games_data_without_neutral_games.csv")
  file.remove("data/ELO League Summary.csv")

}
##########################################################################
## ELO MODEL STEP 4: ADJUSTMENTS HOME AWAY CHANGE FROOM RAW TO ROUND 3
##########################################################################
if (step_4 == "Run") {
  team_ranking <- read.csv("data/ELO RANKINGS.csv", header = TRUE, sep = ",") # nolint
  team_ranking$HWAdjChangePercentage <- NA
  team_ranking$HWAdjChangePercentage <- team_ranking$HWAdj3Percentage - team_ranking$RawWinPercentage
  team_ranking$HWAdjChangeRank <- NA
  team_ranking$HWAdjChangeRank <- team_ranking$WinRank4 - team_ranking$WinRank1
  write.csv(team_ranking, "data/ELO RANKINGS.csv")
}
print("MODULE END: ELO MODEL: RANK BY HOME AWAY ADJUSTMENTS")