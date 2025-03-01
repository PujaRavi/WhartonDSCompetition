library(dplyr)
# if (inputRegion == "East") {
#  games_data <- read.csv("data/MC_games_data_east.csv", header = TRUE, sep = ",") # nolint
# } else if (inputRegion == "West") {
#   games_data <- read.csv("data/MC_games_data_west.csv", header = TRUE, sep = ",") # nolint
# } else if (inputRegion == "North") {   
#   games_data <- read.csv("data/MC_games_data_north.csv", header = TRUE, sep = ",") # nolint
# } else if (inputRegion == "South") {
#   games_data <- read.csv("data/MC_games_data_south.csv", header = TRUE, sep = ",") # nolint
# } 

games_data <- read.csv("data/MC_games_data.csv", header = TRUE, sep = ",") # nolint
team <- unique(c(games_data$Wteam_name, games_data$Lteam_name))

# Initialize matrices and vectors
num_teams <- length(team)
M <- matrix(0, nrow = num_teams, ncol = num_teams)
p <- matrix(0, nrow = num_teams, ncol = 1)
b <- matrix(0, nrow = num_teams, ncol = 1)

m_row <- 1 # Current row in Massey matrix (R uses 1-based indexing)

for (k in team) {
  # Find all games team played, win or loss
  team_games <- games_data[games_data$Wteam_name == k | games_data$Lteam_name == k, ] # nolint
  n_team <- nrow(team_games) # Number of games team played, for diagonal # nolint


  times_played <- matrix(0, nrow = 1, ncol = num_teams) # Basically an array for given row in M # nolint

  # Counter for array indexing
  ctr <- 1 # R uses 1-based indexing
  for (j in team) {
    if (j == k) {
      # This is the team itself
      times_played[1, ctr] <- n_team
    } else {
      # Find all matches between team of interest (k) and opponent (j)
      matches <- team_games[(team_games$Wteam_name == j) | (team_games$Lteam_name == j), ] # nolint
      times_played[1, ctr] <- -nrow(matches)
    }
    ctr <- ctr + 1
  }

  # Now add current row to M
  M[m_row, ] <- times_played

  # Add cumulative points to p
  # p_wins is point differential in games won by team k
  p_wins <- sum(
    team_games[team_games$Wteam_name == k, "Wscore"] -
      team_games[team_games$Wteam_name == k, "Lscore"]
  )
  # p_losses is point differential in games lost by team k (will be negative)
  p_losses <- sum(
    team_games[team_games$Lteam_name == k, "Lscore"] -
      team_games[team_games$Lteam_name == k, "Wscore"]
  )
  p[m_row, 1] <- p_wins + p_losses

  # Now build Colley right-hand side vector b
  b[m_row, 1] <- 1 + (0.5) * (
    nrow(team_games[team_games$Wteam_name == k, ]) -
      nrow(team_games[team_games$Lteam_name == k, ])
  )

  # Iterate to next row in M
  m_row <- m_row + 1
}
# write.csv(M, "data/MC_Results_M.csv")
# write.csv(p, "data/MC_Results_p.csv")
# write.csv(b, "data/MC_Results_b.csv")
# Convert to numeric matrix
if (typeof(M) != "double" && typeof(M) != "integer") {
  M <- apply(M, 2, function(x) as.numeric(as.character(x)))
}

# 2. Solve the linear system (choose b or p)
# Using b:
ratings_b <- solve(M, b)

# Using p:
ratings_p <- solve(M, p)

# 3. Assign team names
massey_rankings_b <- data.frame(
  Team = team,
  Rating = ratings_b
)

colley_rankings_p <- data.frame(
  Team = team,
  Rating = ratings_p
)

# 4. Rank the teams (using b ratings)
massey_rankings_b <- massey_rankings_b %>%
  arrange(desc(Rating)) %>%
  mutate(FinalRank = row_number())

# Rank the teams (using p ratings)
colley_rankings_p <- colley_rankings_p %>%
  arrange(desc(Rating)) %>%
  mutate(FinalRank = row_number())

# Print the rankings (using b ratings)
# print("Colley Rankings (using b):")
# print(massey_rankings_b)

# Print the rankings (using p ratings)
# print("Massey Rankings (using p):")
# print(colley_rankings_p)
# massey_rankings_b$region <- NA
# massey_rankings_b$region <- inputRegion
# colley_rankings_p$region <- NA
# colley_rankings_p$region <- inputRegion

# file_path <- "data/MC_FinalMasseyRankings.csv"
# if (file.exists(file_path)) {
#   existMassey <- read.csv("data/MC_FinalMasseyRankings.csv", header = TRUE, sep = ",") # nolint
#   list_of_Massey = list(existMassey, massey_rankings_b)
#   existMassey <- bind_rows(list_of_Massey)
#   existColley <- read.csv("data/MC_FinalColleyRankings.csv", header = TRUE, sep = ",") # nolint
#   list_of_Colley = list(existColley, colley_rankings_p)
#   existColley <- bind_rows(list_of_Colley)
#   write.csv(existMassey, "data/MC_FinalMasseyRankings.csv")
#   write.csv(existColley, "data/MC_FinalColleyRankings.csv")
# } else {
  write.csv(massey_rankings_b, "data/MC_FinalMasseyRankings.csv")
  write.csv(colley_rankings_p, "data/MC_FinalColleyRankings.csv")
# }