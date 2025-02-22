######################################################## # nolint
## 2025 Wharton Data Science Competition
## EloModel.r
## This is program which takes file games_2022_D1_maste.csv and
## generates Team Wins and ranks them based on Wins/Games only 
## using on ELO Model.
##
## INPUT FILE: data/games_2022_D1_master.csv
## OUTPUT FILE: data/ELO Rankings.csv
##
## Programmer: Puja Ravi (International Academy)
######################################################## # nolint
"2025 Wharton Data Science Competition"
print("MODULE START: ELO MODEL: RANK BY WINS ONLY")
library(dplyr)
#############################################################
## ELO MODEL: RUN CONTROLLER USED TO MAKE CERTAIN MODULES RUN
#############################################################
## ELO MODEL STEP 1: CREATE RANKING SHEET
## ELO MODEL STEP 1: RAW ADJUSTMENTS - WINNINGS AND RANKING
## ELO MODEL STEP 2: ADJUSTMENTS - HOME_AWAY AND RANKING - ROUND 1
## ELO MODEL STEP 3: ADJUSTMENTS - HOME_AWAY AND RANKING - ROUND 2
## ELO MODEL STEP 4: ADJUSTMENTS - HOME_AWAY AND RANKING - ROUND 3
## ELO MODEL STEP 5: ADJUSTMENTS HOME AWAY CHANGE FROOM RAW TO ROUND 3
## ELO MODEL STEP 6: ADJUSTMENTS - FREE THROW AND RANKING - ROUND 1
## ELO MODEL STEP 6: ROUND 4 ADJUSTMENT - 3POINT THROW AND RANKING
#############################################################
step_1 <- "Run"
########################################################
## ELO MODEL STEP 1: CREATE RANKING SHEET
## INPUT DATA FRAME: data/games_2022_D1_master.csv
## OUTPUT DATA FRAME: data/ELO Rankings.csv
########################################################
if (step_1 == "Run") {
  games_data <- read.csv("data/games_2022_D1_master.csv", header = TRUE, sep = ",") # nolint
  team_ranking <- aggregate(cbind(Wins = Win, Losses = Loss, Games = Win + Loss) ~ team + region, data = games_data, sum)
  team_ranking$RawWinPercentage <- NA
  team_ranking$RawWinPercentage <- round(as.numeric(team_ranking$Wins) / as.numeric(team_ranking$Games) * 100, 2)
  team_ranking <- team_ranking %>%
    group_by(region) %>%
    mutate(WinRank1 = dense_rank(desc(`RawWinPercentage`)))
    write.csv(team_ranking, "data/ELO RANKINGS.csv")
}
print("MODULE END: ELO MODEL: RANK BY WINS ONLY")
