######################################################## # nolint
## 2025 Wharton Data Science Competition
## EloModel.r
## This is program which takes file games_2022_D1_maste.csv and
## and the ELO Ranking.csv files and applies
## 2-Point Field Goals adjustments in 3 rounds
## Then it ranks the teams from four Regions
##
## INPUT FILE: data/games_2022_D1_master.csv
## INPUT FILE: data/ELO Rankings.csv
## OUTPUT FILE: data/ELO Rankings.csv
##
## Programmer: Puja Ravi (International Academy)
######################################################## # nolint
"2025 Wharton Data Science Competition"
print("MODULE START: ELO MODEL: RANK BY 2-POINT FIELD GOAL ADJUSTMENTS")
library(dplyr)
#############################################################
## ELO MODEL: RUN CONTROLLER USED TO MAKE CERTAIN MODULES RUN
#############################################################
## ELO MODEL STEP 1: ADJUSTMENTS - 2-POINT THROWS - ROUND 1
## ELO MODEL STEP 2: ADJUSTMENTS - 2-POINT THROWS - ROUND 2
## ELO MODEL STEP 3: ADJUSTMENTS - 2-POINT THROWS - ROUND 3
## ELO MODEL STEP 4: ADJUSTMENTS 2-POINT THROWS CHANGE FROOM RAW TO ROUND 3
#############################################################
step_1 <- "Run"
step_2 <- "Run"
step_3 <- "Run"
step_4 <- "Run"
##################################################################
## ELO MODEL: ADJUSTMENTS - 2-POINT THROWS - ROUND 1
##################################################################
if (step_1 == "Run") {
  # Calculate League Average from 2Point Free Throws
  games_data <- read.csv("data/games_2022_D1_master.csv", header = TRUE, sep = ",") # nolint
  team_ranking <- read.csv("data/ELO RANKINGS.csv", header = TRUE, sep = ",") # nolint
  # Calculating League Summary data
  FG2_Attempts <- sum(games_data$FGA_2) # nolint
  FG2_Made <- sum(games_data$FGM_2) # nolint
  FG2_Percentage <- round(as.numeric(FG2_Made) / as.numeric(FG2_Attempts) * 100, 2) # nolint
  FG2_Advantage <- FG2_Percentage - 50 # nolint
  # Update 2 Point Advantage for each game in games_data # nolint
  games_data$FG2AdvRnd1 <- NA
  games_data$FG2AdvRnd1 <- games_data$FGP_2 -  FG2_Advantage # nolint
  # Summarize the 2Point adjustment and Rank the teams
  # Calculate average FG2AdvRnd1 for each team in games_data # nolint
  team_avg_home_adv <- games_data %>%
    group_by(team) %>%
    summarize(FieldGoal2Adj1Percentage = mean(FG2AdvRnd1, na.rm = TRUE)) #na.rm to remove NA values from mean # nolint
  team_ranking <- merge(team_ranking, team_avg_home_adv, by = "team", all.x = TRUE) # nolint
  # Calculate Round 1 percentage for FG2AdvRnd1
  team_ranking$FG2Adj1Percentage <- NA
  team_ranking$FG2Adj1Percentage <- team_ranking$HomeAwayAdj3Percentage + team_ranking$FieldGoal2Adj1Percentage # nolint
  new_rank_column <- "RankFG2Adj1"
  team_ranking <- team_ranking %>%
    group_by(region) %>%
    mutate(!!new_rank_column := dense_rank(desc(`FG2Adj1Percentage`)))
  write.csv(games_data, "data/games_2022_D1_master.csv")
  write.csv(team_ranking, "data/ELO RANKINGS.csv")
}
##################################################################
## ELO MODEL: ADJUSTMENTS - 2-POINT THROWS - ROUND 2
##################################################################
if (step_2 == "Run") {
  # Calculate League Average from 3Point Free Throws
  games_data <- read.csv("data/games_2022_D1_master.csv", header = TRUE, sep = ",") # nolint
  team_ranking <- read.csv("data/ELO RANKINGS.csv", header = TRUE, sep = ",") # nolint
  # Calculating League Summary data
  FG2_Attempts <- sum(games_data$FGA_2) # nolint
  FG2_Made <- sum(games_data$FGM_2) # nolint
  FG2_Percentage <- round(as.numeric(FG2_Made) / as.numeric(FG2_Attempts) * 100, 2) # nolint
  FG2_Advantage <- FG2_Percentage - 50 # nolint
  # Update 3 Point Advantage for each game in games_data # nolint
  games_data$FG2AdvRnd2 <- NA
  games_data$FG2AdvRnd2 <- games_data$FG2AdvRnd1 -  FG2_Advantage # nolint
  # Summarize the 3Point adjustment and Rank the teams
  # Calculate average FG2AdvRnd2 for each team in games_data # nolint
  team_avg_home_adv <- games_data %>%
    group_by(team) %>%
    summarize(FieldGoal2Adj2Percentage = mean(FG2AdvRnd2, na.rm = TRUE)) #na.rm to remove NA values from mean # nolint
  team_ranking <- merge(team_ranking, team_avg_home_adv, by = "team", all.x = TRUE) # nolint
  # Calculate Round 2 percentage for FG2AdvRnd1
  team_ranking$FG2Adj2Percentage <- NA
  team_ranking$FG2Adj2Percentage <- team_ranking$FG2Adj1Percentage + team_ranking$FieldGoal2Adj2Percentage # nolint
  new_rank_column <- "RankFG2Adj2"
  team_ranking <- team_ranking %>%
    group_by(region) %>%
    mutate(!!new_rank_column := dense_rank(desc(`FG2Adj2Percentage`)))
  write.csv(games_data, "data/games_2022_D1_master.csv")
  write.csv(team_ranking, "data/ELO RANKINGS.csv")
}
##################################################################
## ELO MODEL: ADJUSTMENTS - 3-POINT THROWS - ROUND 3
##################################################################
if (step_3 == "Run") {
  # Calculate League Average from 3Point Free Throws
  games_data <- read.csv("data/games_2022_D1_master.csv", header = TRUE, sep = ",") # nolint
  team_ranking <- read.csv("data/ELO RANKINGS.csv", header = TRUE, sep = ",") # nolint
  # Calculating League Summary data
  FG2_Attempts <- sum(games_data$FGA_2) # nolint
  FG2_Made <- sum(games_data$FGM_2) # nolint
  FG2_Percentage <- round(as.numeric(FG2_Made) / as.numeric(FG2_Attempts) * 100, 2) # nolint
  FG2_Advantage <- FG2_Percentage - 50 # nolint
  # Update 3 Point Advantage for each game in games_data # nolint
  games_data$FG2AdvRnd3 <- NA
  games_data$FG2AdvRnd3 <- games_data$FG2AdvRnd2 -  FG2_Advantage # nolint
  # Summarize the 3Point adjustment and Rank the teams
  # Calculate average FG2AdvRnd3 for each team in games_data # nolint
  team_avg_home_adv <- games_data %>%
    group_by(team) %>%
    summarize(FieldGoal2Adj3Percentage = mean(FG2AdvRnd3, na.rm = TRUE)) #na.rm to remove NA values from mean # nolint
  team_ranking <- merge(team_ranking, team_avg_home_adv, by = "team", all.x = TRUE) # nolint
  # Calculate Round 2 percentage for FG2AdvRnd3
  team_ranking$FG2Adj3Percentage <- NA
  team_ranking$FG2Adj3Percentage <- team_ranking$FG2Adj2Percentage + team_ranking$FieldGoal2Adj3Percentage # nolint
  new_rank_column <- "RankFG2Adj3"
  team_ranking <- team_ranking %>%
    group_by(region) %>%
    mutate(!!new_rank_column := dense_rank(desc(`FG2Adj3Percentage`)))
  write.csv(games_data, "data/games_2022_D1_master.csv")
  write.csv(team_ranking, "data/ELO RANKINGS.csv")
}
##########################################################################
## ELO MODEL STEP 4: ADJUSTMENTS 3-POINT THROWS FROM RAW TO ROUND 3
##########################################################################
if (step_4 == "Run") {
  team_ranking <- read.csv("data/ELO RANKINGS.csv", header = TRUE, sep = ",") # nolint
  team_ranking$FG2AdjChangePercentage <- NA
  team_ranking$FG2AdjChangePercentage <- team_ranking$FG3Adj3Percentage - team_ranking$HomeAwayAdj3Percentage # nolint
  team_ranking$FG2AdjChangeRank <- NA
  team_ranking$FG2AdjChangeRank <- team_ranking$RankFG2Adj3 - team_ranking$RankHAAdj3 # nolint
  write.csv(team_ranking, "data/ELO RANKINGS.csv")
}
print("MODULE END: ELO MODEL: RANK BY 3-POINT FIELD GOAL ADJUSTMENTS")