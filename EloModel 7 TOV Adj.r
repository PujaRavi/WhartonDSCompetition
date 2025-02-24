######################################################## # nolint
## 2025 Wharton Data Science Competition
## EloModel.r
## This is program which takes file games_2022_D1_maste.csv and
## and the ELO Ranking.csv files and applies
## Turnover adjustments
## Then it ranks the teams from four Regions
##
## INPUT FILE: data/games_2022_D1_master.csv
## INPUT FILE: data/ELO Rankings.csv
## OUTPUT FILE: data/ELO Rankings.csv
##
## Programmer: Puja Ravi (International Academy)
######################################################## # nolint
"2025 Wharton Data Science Competition"
print("MODULE START: ELO MODEL: RANK BY TURNOVER ADJUSTMENTS")
library(dplyr)
#############################################################
## ELO MODEL: RUN CONTROLLER USED TO MAKE CERTAIN MODULES RUN
#############################################################
## ELO MODEL STEP 1: ADJUSTMENTS - TURNOVER - ROUND 1
## ELO MODEL STEP 2: ADJUSTMENTS TURNOVER CHANGE FROM RAW TO ROUND 1
#############################################################
step_1 <- "Run"
step_2 <- "Run"
##################################################################
## ELO MODEL: ADJUSTMENTS - TURNOVER - ROUND 1
##################################################################
if (step_1 == "Run") {
  # Summarize the TURNOVERadjustment and Rank the teams
  # Calculate average FTAdvRnd1 for each team in games_data # nolint
  team_avg_home_adv <- games_data %>%
    group_by(team) %>%
    summarize(TVAdj1Percentage = mean(TOVP, na.rm = TRUE)) #na.rm to remove NA values from mean # nolint
  team_ranking <- merge(team_ranking, team_avg_home_adv, by = "team", all.x = TRUE) # nolint
  # Calculate Round 1 percentage for FTAdvRnd1
  team_ranking$TOVAdj1Percentage <- NA
  team_ranking$TOVAdj1Percentage <- team_ranking$HomeAwayAdj3Percentage + team_ranking$TVAdj1Percentage # nolint
  new_rank_column <- "RankTOVAdj1"
  team_ranking <- team_ranking %>%
    group_by(region) %>%
    mutate(!!new_rank_column := dense_rank(desc(`TOVAdj1Percentage`)))
  write.csv(games_data, "data/games_2022_D1_master.csv")
  write.csv(team_ranking, "data/ELO RANKINGS.csv")
}
##########################################################################
## ELO MODEL STEP 2: ADJUSTMENTS TURNOVER FROM RAW TO ROUND 1
##########################################################################
if (step_2 == "Run") {
  team_ranking <- read.csv("data/ELO RANKINGS.csv", header = TRUE, sep = ",") # nolint
  team_ranking$TOVAdjChangePercentage <- NA
  team_ranking$TOVAdjChangePercentage <- team_ranking$TOVAdj1Percentage - team_ranking$HomeAwayAdj3Percentage # nolint
  team_ranking$TOVAdjChangeRank <- NA
  team_ranking$TOVAdjChangeRank <- team_ranking$RankTOVAdj1 - team_ranking$RankHAAdj3 # nolint
  write.csv(team_ranking, "data/ELO RANKINGS.csv")
}
print("MODULE END: ELO MODEL: RANK BY TURNOVER ADJUSTMENTS")