######################################################## # nolint
## 2025 Wharton Data Science Competition
## Main.r
## This is the main program
##
## Programmer: Puja Ravi (International Academy)
######################################################## # nolint
"2025 Wharton Data Science Competition"
## install.packages("tidyverse") # nolint
library(tidyverse)
format(Sys.Date(), "%c")
########################################################
## LOAD INPUT DATA INTO DATA FRAMES
########################################################
# load Regions data into data frame
"Loading Regions Data..."
Region_Data <- read.csv("data/Regions.csv", header = TRUE, sep = ",") # nolint
"COMPLETED Loading Regions Data..."
# load games_2022 data into data frame
"Loading Games Data..."
Games_Data <- read.csv("data/games_2022 v2.csv", header = TRUE, sep = ",") # nolint
"COMPLETED Loading Games Data..."
"Loading EastRegion Data..."
# load EastRegion data into data frame
EastRegion_Data <- read.csv("data/East Region.csv", header = TRUE, sep = ",") # nolint
"COMPLETED Loading EastRegion Data..."
# load DataDict data into data frame
"Loading Data Dictionary Data..."
Data_Dict <- read.csv("data/Data Dictionary.csv", header = TRUE, sep = ",") # nolint
"COMPLETED Loading Data Dictionary Data..."

## print the Region_Data frame
## print(Region_Data) # nolint
## print the Games_Data frame
## print(Games_Data) # nolint
## print the EastRegion_Data frame
## print(EastRegion_Data) # nolint
## print the Data_Dict frame
## print(Data_Dict) # nolint
# print number of columns
print(ncol(Games_Data))
# print number of rows
print(nrow(Games_Data))


########################################################
## STAGING THE DATA
##  # nolint
## win: 1 for win # nolint
## loss: 1 for loss # nolint
## pts_dif: No of points difference # nolint
## FGP_2: Create a new column to average the Field Throw 2 pointer # nolint
## FGP_3: Create a new column to average the Field Throw 3 pointer # nolint
## FTP: Free through percentage
########################################################

## FGP_2%: Create a new column to average the Field Throw 2 pointer # nolint
################################################################### # nolint
Master_temp_Data <- Games_Data %>% mutate(win = case_when(as.numeric(team_score) > as.numeric(opponent_team_score) ~ 1, # nolint
    as.numeric(team_score) > as.numeric(opponent_team_score) ~ 0),  # nolint
    loss = case_when(as.numeric(team_score) > as.numeric(opponent_team_score) ~ 0,  # nolint
    as.numeric(team_score) > as.numeric(opponent_team_score) ~ 1),  # nolint
    pts_dif = as.numeric(team_score) - as.numeric(opponent_team_score), # nolint
    FGP_2 = as.numeric(FGM_2)/as.numeric(FGA_2), # nolint
    FGP_3 = as.numeric(FGM_3)/as.numeric(FGA_3), # nolint
    FTP = as.numeric(FTM)/as.numeric(FTA)  ) # nolint

## Region: Create a new Data Frame (Master_Data) to add Region column to GameData Frame # nolint
######################################################################################## # nolint

## Adding a New Blank Column 'Region' to the GameData Frame
Master_Data <- merge(Master_temp_Data, Region_Data, by="team", all = TRUE) # nolint

print(ncol(Master_Data))
# print number of rows
print(nrow(Master_Data))

write.csv(Master_Data, "data/master games data.csv")
"COMPLETED CSV file written Successfully..."

#############################################################
## ANALYZING EACH GAME
##  # ASSIGN a Point from -10 to 10 for each team in the game
##  # nolint
##  # FGP_2 : 1 point # nolint
##  # FGP_3 : 1 point # nolint
##  # FTP : 1 point # nolint
##  # AST : 1 point # nolint
##  # BLK : 1 point # nolint
##  # STL : 1 point # nolint
##  # TOV : 1 point # nolint
##  # TOV_team : 0 point # nolint
##  # DREB : 1 point # nolint
##  # OREB : 1 point # nolint
##  # F_personal : 0 point # nolint
##  # F_tech : 0 point # nolint
##  # win : 1 point # nolint
##  # loss : -1 point # nolint
##  # largest_lead : 0 point # nolint
##  # OT_length : 0 point # nolint
##  # rest_days : 0 point # nolint
##  # attendance : 0 point # nolint
##  # home_away_NS : 1 or -1 point # nolint
##  # travel_distance : 0 point # nolint
##  # prev_game_dist : 0 point # nolint
##  # tz_dif_H_E : 0 #nilint
##  # nolint
#############################################################


Game_temp <- Master_Data[Master_Data$game_id == 'game_2022_3695',]

for (x in 1:length(Game_temp)) {
  print(Game_temp(x))
}





write.csv(Game_temp, "data/game_temp.csv")

#############################################################
## SPLIT DATA INTO REGIONAL CSV FILES
##  # nolint
##  # nolint
##  # nolint
##  # nolint
##  # nolint
##  # nolint
#############################################################

#############################################################
## SUMMARIZE BY INDIVIDUAL TEAMS
##  # nolint
##  # nolint
##  # nolint
##  # nolint
##  # nolint
##  # nolint
#############################################################


#############################################################
## ORDERB BY RANKINGS
##  # nolint
##  # nolint
##  # nolint
##  # nolint
##  # nolint
##  # nolint
#############################################################






"Program Ended"
