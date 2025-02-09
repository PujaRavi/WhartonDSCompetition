########################################################
## 2025 Wharton Data Science Competition
## Main.r
## This is the main program
##
## Programmer: Puja Ravi (International Academy)
########################################################
"2025 Wharton Data Science Competition"
format(Sys.Date(), "%c") 


########################################################
## LOAD INPUT DATA INTO DATA FRAMES
########################################################
# load Regions data into data frame
"Loading Regions Data..."
RegionData <- read.csv("data/Regions.csv", header = TRUE, sep = ",")
"COMPLETED Loading Regions Data..."
# load games_2022 data into data frame
"Loading Games Data..."
GamesData <- read.csv("data/games_2022 v2.csv", header = TRUE, sep = ",")
"COMPLETED Loading Games Data..."
"Loading EastRegion Data..."
# load EastRegion data into data frame
EastRegionData <- read.csv("data/East Region.csv", header = TRUE, sep = ",")
"COMPLETED Loading EastRegion Data..."
# load DataDict data into data frame
"Loading Data Dictionary Data..."
DataDict <- read.csv("data/Data Dictionary.csv", header = TRUE, sep = ",")
"COMPLETED Loading Data Dictionary Data..."

# print the RegionData frame
# print(RegionData)
# print the GamesData frame
# print(GamesData)
# print the EastRegionData frame
# print(EastRegionData)
# print the DataDict frame
# print(DataDict)


#############################################################
## Create a new Data Frame to add Regions to GameData Frame
#############################################################

# print number of columns
print(ncol(GamesData))
# print number of rows
print(nrow(GamesData))

## Adding a New Blank Column 'Region' to the GameData Frame
GamesData['Region'] <- NA

# print number of columns
print(ncol(GamesData))
# print number of rows
print(nrow(GamesData))

# GamesData$Region <- RegionData[GamesData$team == RegionData$team]




write.csv(GamesData,"data/master games data.csv")
"COMPLETED CSV file written Successfully..."

"Program Ended"
