######################################################## # nolint
## 2025 Wharton Data Science Competition
## EloModel.r
## This is program which takes file games_2022_D1_maste.csv and
## run it against the 20% raw data to match the accuracy
## of the ELO Model
##
## INPUT FILE: data/ELO Final Rankings.csv
## OUTPUT FILE: data/ELO Model verification.csv
##
## Programmer: Puja Ravi (International Academy)
######################################################## # nolint
"2025 Wharton Data Science Competition"
print("MODULE START: ELO MODEL: MODEL TESTING")
library(dplyr)
ranking_data <- read.csv("data/ELO_FINAL_RANKINGS.csv", header = TRUE, sep = ",") # nolint
game_data <- read.csv("data/games_2022_D1_master_20.csv", header = TRUE, sep = ",") # nolint
game_win_loss <- game_data %>%
  group_by(game_id) %>%
  summarise(
    team1 = first(team),
    team2 = nth(team, 2),
    team1win = first(Win),
    team2win = nth(Win, 2),
  ) %>%
  ungroup() #important to ungroup.
game_win_loss$team1Rank <- NA
game_win_loss$team1Rank <- ranking_data$FinalRank[match(game_win_loss$team1, ranking_data$team)] # nolint
game_win_loss$team2Rank <- NA
game_win_loss$team2Rank <- ranking_data$FinalRank[match(game_win_loss$team2, ranking_data$team)] # nolint
game_win_loss <- game_win_loss[!is.na(game_win_loss$team1Rank) & !is.na(game_win_loss$team2Rank), ] # nolint
game_win_loss$ActualTeam1Win <- ifelse(game_win_loss$team1win == 1, 1, 0)
game_win_loss$PredictTeam1Win <- ifelse(game_win_loss$team1Rank < game_win_loss$team2Rank, 1, 0) # nolint
game_win_loss$PredictMatch <- ifelse(game_win_loss$PredictTeam1Win == game_win_loss$ActualTeam1Win, 100, 0) # nolint
count_success <- sum(game_win_loss$PredictMatch == 100)
num_rows <- nrow(game_win_loss)
game_win_loss$AccuracyPercentage <- (count_success / num_rows) * 100
write.csv(game_win_loss, "data/ELO_TESTING_MODELS.csv")
print("MODULE END: ELO MODEL: MODEL TESTING")
