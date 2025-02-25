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
team_ranking_extract <- ranking_data[, c("team", "region", "RankWins","RankHAAdj3", "RankFG3Adj1", "RankFG2Adj3","RankREBAdj1", "RankTOVAdj1", "RankMarginAdj1")] # nolint
create_filtered_dataframe <- function(df, column_name, target_value) {
  filtered_df <- df[df[[column_name]] == target_value, ]
  return(filtered_df)
}
east_teams = create_filtered_dataframe(team_ranking_extract, "region", "East")
RAWWIN_WT <- 30
HOMEAWAY_WT <- 15
FG3_WT <- 15
FG2_WT <- 10
REB_WT <- 10
TOV_WT <- 5
MAR_WT <- 15
east_teams$RankWins <- east_teams$RankWins * RAWWIN_WT
east_teams$RankHAAdj3 <- east_teams$RankHAAdj3 * HOMEAWAY_WT
east_teams$RankFG3Adj1 <- east_teams$RankFG3Adj1 * FG3_WT
east_teams$RankFG2Adj3 <- east_teams$RankFG2Adj3 * FG2_WT
east_teams$RankREBAdj1 <- east_teams$RankREBAdj1 * REB_WT
east_teams$RankTOVAdj1 <- east_teams$RankTOVAdj1 * TOV_WT
east_teams$RankMarginAdj1 <- east_teams$RankMarginAdj1 * MAR_WT
east_teams$TotRatings <- rowSums(east_teams[, c("RankWins","RankHAAdj3", "RankFG3Adj1", "RankFG2Adj3","RankREBAdj1", "RankTOVAdj1", "RankMarginAdj1")]) # nolint
east_teams$FinalRank <- rank(east_teams$TotRatings)
write.csv(east_teams, "data/ELO EAST_RANKINGS.csv")
print("MODULE END: ELO MODEL: RANK ANALYSIS")
