######################################################## # nolint
## 2025 Wharton Data Science Competition
## EloModel.r
## This is program which takes file games_2022_D1_maste.csv and
## and the ELO Ranking.csv files and applies
## Rebound adjustments in 3 rounds
## BLK - Block: Deflecting or stopping an opponent's shot attempt.
## AST - A pass leading directly to a made basket.
## STL - Steals: Gaining possession by intercepting or taking the ball from an opponent. # nolint
## Then it ranks the teams from four Regions
##
## INPUT FILE: data/games_2022_D1_master.csv
## INPUT FILE: data/ELO Rankings.csv
## OUTPUT FILE: data/ELO Rankings.csv
##
## Programmer: Puja Ravi (International Academy)
######################################################## # nolint
"2025 Wharton Data Science Competition"
print("MODULE START: ELO MODEL: RANK BY REBOUND ADJUSTMENTS")
library(dplyr)
#############################################################
## ELO MODEL: RUN CONTROLLER USED TO MAKE CERTAIN MODULES RUN
#############################################################
## ELO MODEL STEP 1: ADJUSTMENTS - REBOUND - ROUND 1
## ELO MODEL STEP 2: ADJUSTMENTS REBOUND CHANGE FROM RAW TO ROUND 1
#############################################################
step_1 <- "Run"
step_2 <- "Run"
##################################################################
## ELO MODEL: ADJUSTMENTS - REBOUND - ROUND 1
##################################################################
if (step_1 == "Run") {
  # Summarize the REBOUND adjustment and Rank the teams
  # Calculate average FTAdvRnd1 for each team in games_data # nolint
  team_avg_home_adv <- games_data %>%
    group_by(team) %>%
    summarize(DBAdj1Percentage = mean(REBP, na.rm = TRUE)) #na.rm to remove NA values from mean # nolint
  team_ranking <- merge(team_ranking, team_avg_home_adv, by = "team", all.x = TRUE) # nolint
  # Calculate Round 1 percentage for FTAdvRnd1
  team_ranking$REBAdj1Percentage <- NA
  team_ranking$REBAdj1Percentage <- team_ranking$HomeAwayAdj3Percentage + team_ranking$DBAdj1Percentage # nolint
  new_rank_column <- "RankREBAdj1"
  team_ranking <- team_ranking %>%
    group_by(region) %>%
    mutate(!!new_rank_column := dense_rank(desc(`REBAdj1Percentage`)))
  write.csv(games_data, "data/games_2022_D1_master.csv")
  write.csv(team_ranking, "data/ELO RANKINGS.csv")
}
##########################################################################
## ELO MODEL STEP 2: ADJUSTMENTS REBOUND FROM RAW TO ROUND 1
##########################################################################
if (step_2 == "Run") {
  team_ranking <- read.csv("data/ELO RANKINGS.csv", header = TRUE, sep = ",") # nolint
  team_ranking$REBAdjChangePercentage <- NA
  team_ranking$REBAdjChangePercentage <- team_ranking$REBAdj1Percentage - team_ranking$HomeAwayAdj3Percentage # nolint
  team_ranking$REBAdjChangeRank <- NA
  team_ranking$REBAdjChangeRank <- team_ranking$RankREBAdj1 - team_ranking$RankHAAdj3 # nolint
  write.csv(team_ranking, "data/ELO RANKINGS.csv")
}
print("MODULE END: ELO MODEL: RANK BY REBOUND ADJUSTMENTS")