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
EloModel_FreeThrow <- "DontRun" # nolint
EloModel_Rebounds <- "DontRun" # nolint
EloModel_Margins <- "DontRun" # nolint
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
  # Rank after Home_Away adjustments - 3 Rounds
  source("EloModel 3 3Point Adj.r")
}
if (EloModel_2Point == "Run") {
  # Rank after Home_Away adjustments - 3 Rounds
  source("EloModel 4 2Point Adj.r")
}
print("Program Ended")