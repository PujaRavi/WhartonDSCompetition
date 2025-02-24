######################################################## # nolint
## 2025 Wharton Data Science Competition
## Main.r
## This is the main program for processing the raw data games_2022 v2.csv
## and rank the teams with different attributes
##
## INPUT FILE: data/games_2022 v2.csv
## OUTPUT FILE: data/ELO Rankings.csv
##
## Programmer: Puja Ravi (International Academy)
######################################################## # nolint
print("2025 Wharton Data Science Competition")
Data_Preparation <- "Run" # nolint
EloModel_Wins <- "Run" # nolint
EloModel_HomeAway_adjustment <- "Run" # nolint
EloModel_3Point <- "Run" # nolint
EloModel_2Point <- "Run" # nolint
EloModel_FreeThrow <- "Run" # nolint
EloModel_REB <- "Run" # nolint
EloModel_TOV <- "Run" # nolint
EloModel_Margins <- "Run" # nolint
print("Program Started")
if (Data_Preparation == "Run") {
  # Cleaup the data and introduce calculated fields
  source("DataPrep.r")
}
if (EloModel_Wins == "Run") {
  # Rank by Wins only
  source("EloModel 1 Wins.r")
}
if (EloModel_HomeAway_adjustment == "Run") {
  # Rank after Home_Away adjustments - 3 Rounds
  source("EloModel 2 HomeAway Adj.r")
}
if (EloModel_3Point == "Run") {
  # Rank after 3Point adjustments - 3 Rounds
  source("EloModel 3 3Point Adj.r")
}
if (EloModel_2Point == "Run") {
  # Rank after 2Point adjustments - 3 Rounds
  source("EloModel 4 2Point Adj.r")
}
if (EloModel_FreeThrow == "Run") {
  # Rank after Free Throw adjustments - 3 Rounds
  source("EloModel 5 FreeThrow Adj.r")
}
if (EloModel_REB == "Run") {
  # Rank after REB adjustments - 3 Rounds
  source("EloModel 6 REB Adj.r")
}
if (EloModel_TOV == "Run") {
  # Rank after TOV adjustments - 3 Rounds
  source("EloModel 7 TOV Adj.r")
}
if (EloModel_Margins == "Run") {
  # Rank after TOV adjustments - 3 Rounds
  source("EloModel 8 Margin Adj.r")
}
print("Program Ended")