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
RAWWIN_WT <- 65 # nolint
HOMEAWAY_WT <- 10 # nolint
FG3_WT <- 5 # nolint
FG2_WT <- 5 # nolint
REB_WT <- 5 # nolint
TOV_WT <- 5 # nolint
MAR_WT <- 5 # nolint
team_ranking_extract$RankWins <- team_ranking_extract$RankWins * RAWWIN_WT
team_ranking_extract$RankHAAdj3 <- team_ranking_extract$RankHAAdj3 * HOMEAWAY_WT
team_ranking_extract$RankFG3Adj1 <- team_ranking_extract$RankFG3Adj1 * FG3_WT
team_ranking_extract$RankFG2Adj3 <- team_ranking_extract$RankFG2Adj3 * FG2_WT
team_ranking_extract$RankREBAdj1 <- team_ranking_extract$RankREBAdj1 * REB_WT
team_ranking_extract$RankTOVAdj1 <- team_ranking_extract$RankTOVAdj1 * TOV_WT
team_ranking_extract$RankMarginAdj1 <- team_ranking_extract$RankMarginAdj1 * MAR_WT # nolint
team_ranking_extract$TotRatings <- rowSums(team_ranking_extract[, c("RankWins","RankHAAdj3", "RankFG3Adj1", "RankFG2Adj3","RankREBAdj1", "RankTOVAdj1", "RankMarginAdj1")]) # nolint
team_ranking_extract$FinalRank <- rank(team_ranking_extract$TotRatings)
write.csv(team_ranking_extract, "data/ELO_FINAL_RANKINGS.csv")
print("MODULE END: ELO MODEL: RANK ANALYSIS")