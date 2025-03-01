######################################################## # nolint
## 2025 Wharton Data Science Competition
## EloModel.r
## This is program which takes file ELO_Ranking.csv and
## generates a final rank list based on weightages
##
## INPUT FILE: data/ELO Rankings.csv
## OUTPUT FILE: data/ELO Final Rankings.csv
##
## Programmer: Puja Ravi (International Academy)
######################################################## # nolint
"2025 Wharton Data Science Competition"
print("MODULE START: ELO MODEL: RANK ANALYSIS")
library(dplyr)
ranking_data <- read.csv("data/ELO RANKINGS.csv", header = TRUE, sep = ",") # nolint
team_ranking_extract <- data.frame(
  team = ranking_data$team,
  region = ranking_data$region,
  RankWins = ranking_data$RankWins,
  RankHAAdj = ranking_data$RankHAAdj1,
  RankFG3Adj = ranking_data$RankFG3Adj1,
  RankFG2Adj = ranking_data$RankFG2Adj1,
  RankFTAdj = ranking_data$RankFTAdj2,
  RankREBAdj = ranking_data$RankREBAdj1,
  RankTOVAdj = ranking_data$RankTOVAdj1,
  RankMarginAdj = ranking_data$RankMarginAdj1
)
RAWWIN_WT <- 65 # nolint
HOMEAWAY_WT <- 10 # nolint
FG3_WT <- 1 # nolint
FG2_WT <- 15 # nolint
FT_WT <- 5 # nolint
REB_WT <- 1 # nolint
TOV_WT <- 1 # nolint
MAR_WT <- 2 # nolint
team_ranking_extract$RankWins <- team_ranking_extract$RankWins * RAWWIN_WT
team_ranking_extract$RankHAAdj <- team_ranking_extract$RankHAAdj * HOMEAWAY_WT
team_ranking_extract$RankFG3Adj <- team_ranking_extract$RankFG3Adj * FG3_WT
team_ranking_extract$RankFG2Adj <- team_ranking_extract$RankFG2Adj * FG2_WT
team_ranking_extract$RankFTAdj <- team_ranking_extract$RankFTAdj * FT_WT
team_ranking_extract$RankREBAdj <- team_ranking_extract$RankREBAdj * REB_WT
team_ranking_extract$RankTOVAdj <- team_ranking_extract$RankTOVAdj * TOV_WT
team_ranking_extract$RankMarginAdj <- team_ranking_extract$RankMarginAdj * MAR_WT # nolint
team_ranking_extract$TotRatings <- rowSums(team_ranking_extract[, c("RankWins","RankHAAdj", "RankFG3Adj", "RankFG2Adj","RankFTAdj","RankREBAdj", "RankTOVAdj", "RankMarginAdj")]) # nolint
team_ranking_extract$FinalRank <- rank(team_ranking_extract$TotRatings)
write.csv(team_ranking_extract, "data/ELO_FINAL_RANKINGS.csv")
print("MODULE END: ELO MODEL: RANK ANALYSIS")
