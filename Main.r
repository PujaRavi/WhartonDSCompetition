########################################################
## 2025 Wharton Data Science Competition
## Main.r
## This is the main program
##
## Programmer: Puja Ravi (International Academy)
########################################################
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
########################################################

## FGP_2%: Create a new column to average the Field Throw 2 pointer # nolint
################################################################### # nolint
# Master_temp_Data <- Games_Data %>% mutate(win = case_when(team_score > opponent_team_score ~ 1, team_score > opponent_team_score ~ 0 ), loss = case_when(team_score > opponent_team_score ~ 0, team_score > opponent_team_score ~ 1 ), pts_dif = team_score - opponent_team_score) # nolint

## Region: Create a new Data Frame (Master_Data) to add Region column to GameData Frame # nolint
######################################################################################## # nolint

## Adding a New Blank Column 'Region' to the GameData Frame
# Games_Data["region"] <- NA # nolint

## Games_Data$Region <- Region_Data[Games_Data$team == Region_Data$team] # nolint

Master_Data <- merge(Games_Data, Region_Data, by="team", all = TRUE) # nolint

print(ncol(Master_Data))
# print number of rows
print(nrow(Master_Data))

write.csv(Master_Data, "data/master games data.csv")
"COMPLETED CSV file written Successfully..."




#############################################################
## ANALYZING EACH GAME
#############################################################

"Program Ended"
