######################################################## # nolint
## 2025 Wharton Data Science Competition
## DATAPREP.r
## This is the DataPrep program which takes file games_2022 v2.csv and
## generates file games_2022_D1_master.csv afer cleaning it up and
## introducing calculated fields
##
## INPUT DATA FRAME: data/games_2022 v2.csv
## INPUT DATA FRAME: data/Regions.csv (which includes East teams)
## OUTPUT DATA FRAME: data/games_2022_D1_master.csv
##
## Programmer: Puja Ravi (International Academy)
######################################################## # nolint
"2025 Wharton Data Science Competition"
print("MODULE START: DATA PREPARATION")
library(dplyr)
#############################################################
## DATA PREP: RUN CONTROLLER USED TO MAKE CERTAIN MODULES RUN
#############################################################
## DATA PREP STEP 1: REMOVE D2 GAMES
## DATA PREP STEP 2: UPDATE HOME_AWAY COLUMN
## DATA PREP STEP 3: ADD AND UPDATE REGIONS COLUMN
## DATA PREP STEP 4: ADD NEW CALCULATED COLUMNS
#############################################################
step_1 <- "Run"
step_2 <- "Run"
step_3 <- "Run"
step_4 <- "Run"
########################################################
## DATA PREP STEP 1: REMOVE D2 GAMES
########################################################
if (step_1 == "Run") {
  ########################################################
  ## LOAD INPUT DATA INTO DATA FRAMES
  ## INPUT DATA FRAME: data/games_2022 v2.csv
  ## OUTPUT DATA FRAME: data/games_2022_D1.csv
  ## OUTPUT DATA FRAME: data/games_2022_D2.csv
  ########################################################
  # load games_2022 data into data frame
  print("START: Step_1 - SEPARATE TO D1 AND D2 GAMES")
  games_data <- read.csv("data/games_2022 v2_80.csv", header = TRUE, sep = ",") # nolint
  ## print(Games_Data) # nolint
  if ("notD1_incomplete" %in% colnames(games_data)) {
    # Extract rows where D2 is TRUE
    filtered_data <- games_data[games_data$notD1_incomplete == TRUE, ]
    "Row Count of D2 teams in games_2022"
    nrow(filtered_data)
  }
  if ("game_id" %in% colnames(games_data) && "game_id" %in% colnames(filtered_data)) { # nolint
    # Extract game_ids from filtered_data (D2 games)
    d2_game_ids <- filtered_data$game_id
    # Create D2games: rows from games_data where game_id is in d2_game_ids
    d2_games <- games_data[games_data$game_id %in% d2_game_ids, ]
    # Create D1games: rows from games_data where game_id is NOT in d2_game_ids
    d1_games <- games_data[!games_data$game_id %in% d2_game_ids, ]
  } else {
    print("Error: 'game_id' column not found in one or both data frames.")
  }
  write.csv(d1_games, "data/games_2022_D1.csv")
  write.csv(d2_games, "data/games_2022_D2.csv")
  print("END: Step_1")
}
########################################################
## DATA PREP STEP 2: UPDATE HOME_AWAY COLUMN
## INPUT DATA FRAME: data/games_2022_D1.csv
## OUTPUT DATA FRAME: data/games_2022_D1_master.csv
########################################################
if (step_2 == "Run") {
  # load games_2022_D1 data into data frame
  print("START: Step_2 - UPDATE HOME_AWAY COLUMN")
  d1_games <- read.csv("data/games_2022_D1.csv", header = TRUE, sep = ",") # nolint
  # Replace NA values in 'home_away'
  d1_games$home_away[is.na(d1_games$home_away)] <- ""
  # Update 'home_away' to "home" where 'home_away_NS' is 1
  d1_games$home_away[d1_games$home_away_NS == 1] <- "home"
  # Update 'home_away' to "away" where 'home_away_NS' is -1
  d1_games$home_away[d1_games$home_away_NS == -1] <- "away"
  # Update 'home_away' to "neutral" where 'home_away_NS' is 0 and 'travel_dist' > 0 # nolint
  d1_games$home_away[d1_games$home_away_NS == 0 & d1_games$travel_dist > 0] <- "neutral" # nolint
  # Update 'home_away' to "home" where 'home_away_NS' is 0 and 'travel_dist' is 0 # nolint
  d1_games$home_away[d1_games$home_away_NS == 0 & d1_games$travel_dist == 0] <- "home" # nolint
  write.csv(d1_games, "data/games_2022_D1_master.csv")
  print("END: Step_2")
}
########################################################
## DATA PREP STEP 3: ADD AND UPDATE REGIONS COLUMN
## INPUT DATA FRAME: data/games_2022_D1_master.csv
## OUTPUT DATA FRAME: data/games_2022_D1_master.csv
########################################################
if (step_3 == "Run") {
  # load games_2022_D1 data into data frame
  print("START: Step_3 - ADD AND UPDATE REGIONS COLUMN")
  d1_games <- read.csv("data/games_2022_D1_master.csv", header = TRUE, sep = ",") # nolint
  # load Regions data into data frame
  Region_Data <- read.csv("data/Regions.csv", header = TRUE, sep = ",") # nolint
  ## Adding a New Blank Column 'Region' to the GameData Frame
  d1_games <- merge(d1_games, Region_Data, by="team", all = TRUE) # nolint
  ## Remove rows where Game_ID = NA
  d1_games <- d1_games[!is.na(d1_games$game_id), ]
  write.csv(d1_games, "data/games_2022_D1_master.csv")
  print("END: Step_3")
}
########################################################
## DATA PREP STEP 4: ADD NEW CALCULATED COLUMNS
## INPUT DATA FRAME: data/games_2022_D1_master.csv
## win: 1 for win # nolint
## loss: 1 for loss # nolint
## pts_dif: No of points difference # nolint
## FGP_2: Create a new column to percentage the Field Throw 2 pointer # nolint
## FGP_3: Create a new column to percentage the Field Throw 3 pointer # nolint
## FTP: Free through percentage
## DREB: Create new column for DREB percentage
## OUTPUT DATA FRAME: data/games_2022_D1_master.csv
########################################################
if (step_4 == "Run") {
  # load games_2022_D1 data into data frame
  print("START: Step_4 - ADD NEW CALCULATED COLUMNS")
  d1_games <- read.csv("data/games_2022_D1_master.csv", header = TRUE, sep = ",") # nolint
  # Add "Win" and "Loss" columns, initializing them to NA
  d1_games$Win <- NA
  d1_games$Loss <- NA
  d1_games$Win[d1_games$team_score > d1_games$opponent_team_score] <- 1
  d1_games$Win[d1_games$team_score < d1_games$opponent_team_score] <- 0
  d1_games$Loss[d1_games$team_score < d1_games$opponent_team_score] <- 1
  d1_games$Loss[d1_games$team_score > d1_games$opponent_team_score] <- 0
  d1_games$Win[d1_games$team_score == d1_games$opponent_team_score] <- 0.5
  d1_games$Loss[d1_games$team_score == d1_games$opponent_team_score] <- 0.5
  d1_games$Pts_dif <- NA
  d1_games$Pts_dif <- abs(as.numeric(d1_games$team_score) - as.numeric(d1_games$opponent_team_score)) # nolint
  d1_games$FGP_2 <- NA
  d1_games$FGP_2 <- as.numeric(d1_games$FGM_2) / as.numeric(d1_games$FGA_2)
  d1_games$FGP_3 <- NA
  d1_games$FGP_3 <- as.numeric(d1_games$FGM_3) / as.numeric(d1_games$FGA_3)
  d1_games$FTP <- NA
  d1_games$FTP <- as.numeric(d1_games$FTM) / as.numeric(d1_games$FTA)
  d1_games$FTP[is.na(d1_games$FTP)] <- 0
  d1_games$REBT <- NA
  d1_games$REBT <- suppressWarnings(as.numeric(as.character(d1_games$DREB))) + suppressWarnings(as.numeric(as.character(d1_games$OREB))) + suppressWarnings(as.numeric(as.character(d1_games$BLK))) + suppressWarnings(as.numeric(as.character(d1_games$AST))) + suppressWarnings(as.numeric(as.character(d1_games$STL)))# nolint
  d1_games <- d1_games %>%
    mutate(REBT = suppressWarnings(as.numeric(as.character(REBT)))) %>%
    filter(!is.na(REBT)) %>%
    mutate(REBP = (REBT / sum(REBT)) * 100)
  d1_games$TOVT <- NA
  d1_games$TOVT <- suppressWarnings(as.numeric(as.character(d1_games$TOV))) + suppressWarnings(as.numeric(as.character(d1_games$TOV_team))) # nolint
  d1_games <- d1_games %>%
    mutate(TOVT = suppressWarnings(as.numeric(as.character(TOVT)))) %>%
    filter(!is.na(TOVT)) %>%
    mutate(TOVP = (TOVT / sum(TOVT)) * 100)
  d1_games$largest_leadT <- NA
  d1_games$largest_leadT <- suppressWarnings(as.numeric(as.character(d1_games$largest_lead))) # nolint
  d1_games <- d1_games %>%
    mutate(largest_leadT = suppressWarnings(as.numeric(as.character(largest_leadT)))) %>% # nolint
    filter(!is.na(largest_leadT)) %>%
    mutate(largest_leadP = (largest_leadT / sum(largest_leadT)) * 100)
  d1_games <- d1_games[d1_games$home_away != "home_away", ]
  write.csv(d1_games, "data/games_2022_D1_master.csv")
  print("END: Step_4")
}
print("MODULE END: DATA PREPARATION")