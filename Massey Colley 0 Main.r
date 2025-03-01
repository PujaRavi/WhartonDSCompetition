######################################################## # nolint
## 2025 Wharton Data Science Competition
## Main.r
## This is the main program for processing the raw data games_2022 v2.csv
## and rank the teams with different attributes
##
## INPUT FILE: data/games_2022_D1_master.csv
## OUTPUT FILE: data/MC_MasseyRankings.csv
## OUTPUT FILE: data/MC_ColleyRankings.csv
##
## Programmer: Puja Ravi (International Academy)
######################################################## # nolint
print("2025 Wharton Data Science Competition")
Data_Preparation <- "Run" # nolint
MCModel_Ranking <- "Run" # nolint
MCModel_TempDataCleanup <- "Run" # nolint
MCModel_ResultsExtraction <- "Run"
print("Program Started")
if (Data_Preparation == "Run") {
  # Cleaup the data and introduce calculated fields
  source("Massey Colley 1 DataPrep.r")
}
if (MCModel_Ranking == "Run") {
  # Rank after TOV adjustments - 3 Rounds
  # inputRegion <- "East"
  # source("Massey Colley 2 Rankings.r")
  # inputRegion <- "West"
  # source("Massey Colley 2 Rankings.r")
  # inputRegion <- "North"
  # source("Massey Colley 2 Rankings.r")
  # inputRegion <- "South"
   #source("Massey Colley 2 Rankings.r")
   source("Massey Colley 2 Rankings.r")
   
}
if (MCModel_TempDataCleanup == "Run") {
  # Rank after TOV adjustments - 3 Rounds
  source("Massey Colley 3 TempDataCleanup.r")
}
if (MCModel_ResultsExtraction == "Run") {
  # Rank after TOV adjustments - 3 Rounds
  source("Massey Colley 4 Results Extraction.r")
}
print("Program Ended")