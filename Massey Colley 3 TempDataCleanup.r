######################################################## # nolint
## 2025 Wharton Data Science Competition
## DATAPREP.r
## This is the DataPrep program which takes file games_2022 v2.csv and
## generates file games_2022_D1_master.csv afer cleaning it up and
## introducing calculated fields
##
## INPUT DATA FRAME: data/games_2022 v2_80.csv
## INPUT DATA FRAME: data/Regions.csv (which includes East teams)
## OUTPUT DATA FRAME: data/games_2022_D1_master.csv
## OUTPUT DATA FRAME: data/games_2022_D1.csv
## OUTPUT DATA FRAME: data/games_2022_D2.csv
##
## Programmer: Puja Ravi (International Academy)
######################################################## # nolint
"2025 Wharton Data Science Competition"
print("MODULE START: DATA PREPARATION")
library(dplyr)
#############################################################
## DATA PREP: RUN CONTROLLER USED TO MAKE CERTAIN MODULES RUN
#############################################################
## DATA PREP STEP 1: CLEAN OLD DATA FILES 
#############################################################
step_1 <- "Run"
########################################################
## DATA PREP STEP 0: REMOVE D2 GAMES
########################################################
if (step_1 == "Run") {
  file_path <- "data/MC_games_data_east.csv" # Replace with the actual file path
  if (file.exists(file_path)) {
    file.remove(file_path)
  }
  file_path <- "data/MC_games_data_west.csv" # Replace with the actual file path
  if (file.exists(file_path)) {
    file.remove(file_path)
  }
  file_path <- "data/MC_games_data_north.csv" # Replace with the actual file path
  if (file.exists(file_path)) {
    file.remove(file_path)
  }
  file_path <- "data/MC_games_data_south.csv" # Replace with the actual file path
  if (file.exists(file_path)) {
    file.remove(file_path)
  }  
  file_path <- "data/MC_games_data.csv" # Replace with the actual file path
  if (file.exists(file_path)) {
    file.remove(file_path)
  }
  file_path <- "data/MC_Results_M.csv" # Replace with the actual file path
  if (file.exists(file_path)) {
    file.remove(file_path)
  }
  file_path <- "data/MC_Results_b.csv" # Replace with the actual file path
  if (file.exists(file_path)) {
    file.remove(file_path)
  }
  file_path <- "data/MC_Results_p.csv" # Replace with the actual file path
  if (file.exists(file_path)) {
    file.remove(file_path)
  }
}
