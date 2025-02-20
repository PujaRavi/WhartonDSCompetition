######################################################## # nolint
## 2025 Wharton Data Science Competition
## Main.r
## This is the DataPrep program
##
## Programmer: Puja Ravi (International Academy)
######################################################## # nolint
"2025 Wharton Data Science Competition"
########################################################
## LOAD INPUT DATA INTO DATA FRAMES
########################################################
# load games_2022 data into data frame
"Loading Games Data..."
Games_Data <- read.csv("data/games_2022 v2.csv", header = TRUE, sep = ",") # nolint
"COMPLETED Loading Games Data..."
## print(Games_Data) # nolint
if ("notD1_incomplete" %in% colnames(Games_Data)) {
  # Extract rows where D2 is TRUE
  filtered_data <- Games_Data[Games_Data$notD1_incomplete == TRUE, ]
  "Row Count of D2 teams in games_2022"
  nrow(filtered_data)
}
if ("game_id" %in% colnames(Games_Data) && "game_id" %in% colnames(filtered_data)) {
  # Extract game_ids from filtered_data (D2 games)
  d2_game_ids <- filtered_data$game_id
  # Create D2games: rows from games_data where game_id is in d2_game_ids
  D2games <- Games_Data[Games_Data$game_id %in% d2_game_ids, ]
  # Create D1games: rows from games_data where game_id is NOT in d2_game_ids
  D1games <- Games_Data[!Games_Data$game_id %in% d2_game_ids, ]
  # Print or use D1games and D2games as needed
  # print("D1games:")
  # print(head(D1games)) # Print first few rows
  # print("D2games:")
  # print(head(D2games)) # Print first few rows
} else {
  print("Error: 'game_id' column not found in one or both data frames.")
}
"Row Count of D1 games file: "
nrow(D1games)
write.csv(D1games, "data/games_2022_D1.csv")
"COMPLETED Loading D1 Games Data..."
"Row Count of D2 games file: "
nrow(D2games)
write.csv(D2games, "data/games_2022_D2.csv")
"COMPLETED Loading D2 Games Data..."
