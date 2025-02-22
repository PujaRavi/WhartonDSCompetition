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
print("Program Started")
# Cleaup the data and introduce calculated fields
source("DataPrep.r")
# Rank by Wins only
source("EloModel 1 Wins.r")
# Rank after Home_Away adjustments - 3 Rounds
source("EloModel 2 HomeAway Adj.r")
print("Program Ended")