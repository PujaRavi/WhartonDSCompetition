########################################################
## 2025 Wharton Data Science Competition
## Massey Rating Model for NCAA Women's Basketball
##
## Programmer: Puja Ravi (International Academy)
########################################################


# Load necessary libraries
library(dplyr)


# Set the working directory to the location of your CSV file
setwd("/Users/pujaravi/Documents/VisualStudio/WhartonDSCompetition")


# Load the games data
games_data <- read.csv("/Users/pujaravi/Documents/VisualStudio/WhartonDSCompetition/data/games_2022 v2.csv", header = TRUE) # nolint


# Ensure that any rows where 'team' is a header (e.g., "team_id") are skipped
games_data <- games_data %>% # nolint
filter(team != "team") # Assuming 'team' is a common header


# Convert relevant columns to numeric
games_data$team_score <- as.numeric(games_data$team_score)
games_data$opponent_team_score <- as.numeric(games_data$opponent_team_score)


# Check for missing data in crucial columns
missing_data <- games_data %>%
filter(is.na(team_score) | is.na(opponent_team_score) | is.na(team) | is.na(opponent_team_score)) # nolint


if (nrow(missing_data) > 0) {
cat("Rows with missing data:\n")
print(missing_data)
}


# Remove any rows with missing or NA values for key fields (team, score)
games_data_clean <- games_data %>%
filter(!is.na(team_score) & !is.na(opponent_team_score) & !is.na(team) & !is.na(opponent_team_score)) # nolint


# Remove duplicated games (we only need one row per game with home and away team) # nolint
games_data_unique <- games_data_clean %>%
group_by(game_id) %>%
filter(row_number() == 1) %>%
ungroup()


# Initialize Massey matrix and point differential vector
n_teams <- length(unique(c(games_data_unique$team, games_data_unique$opponent_team_score))) # nolint
M <- matrix(0, n_teams, n_teams) # nolint
p <- rep(0, n_teams)


# Get unique teams and create mappings for indexing
teams <- unique(c(games_data_unique$team, games_data_unique$opponent_team_score)) # nolint
team_index <- setNames(1:length(teams), teams) # Create a named vector for team index lookup # nolint


# Process each game
for (i in 1:nrow(games_data_unique)) { # nolint
game <- games_data_unique[i, ]
# nolint
# Assign home and away teams using home_away column
if (game$home_away == "home") {
home <- team_index[game$team]
away <- team_index[game$opponent_team_score]
} else {
home <- team_index[game$opponent_team_score]
away <- team_index[game$team]
}
# nolint
# Ensure that team scores are numeric and not NA
if (is.na(game$team_score) || is.na(game$opponent_team_score)) {
cat(sprintf("Non-numeric score for game %s (home: %s, away: %s)\n", # nolint
game$game_id, game$team, game$opponent_team_score))
next # Skip this game
}
# nolint
# Calculate point differential for home and away teams
margin <- game$team_score - game$opponent_team_score
M[home, home] <- M[home, home] + 1 # nolint
M[away, away] <- M[away, away] + 1 # nolint
M[home, away] <- M[home, away] - 1 # nolint
M[away, home] <- M[away, home] - 1 # nolint
p[home] <- p[home] + margin
p[away] <- p[away] - margin
# nolint
cat(sprintf("Game %s Home: %s Away: %s Margin: %d\n", game$game_id, game$team, game$opponent_team_score, margin)) # nolint
}


# Check for singular matrix before solving
if (det(M) == 0) {
cat("Matrix is singular, cannot solve.\n")
} else {
# Solve the system of equations to get the team rankings
rankings <- solve(M, p)
print("Team Rankings:")
print(rankings)
}


# Additional checks for problematic games (Optional)
problematic_game <- games_data[games_data$game_id == "game_2022_5219", ]
cat("Problematic game data:\n")
print(problematic_game)


