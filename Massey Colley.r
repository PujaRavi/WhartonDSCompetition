# Assuming reg2011_df is your data frame and team_name_list is a vector of team names # nolint
games_data <- read.csv("data/games_data_formatted.csv", header = TRUE, sep = ",") # nolint


# team <- unique(games_data$team)
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

# Print the resulting matrices and vectors (optional)
# print(M)
# print(p)
# print(b)
write.csv(M, "data/MASSEY COLLEY M.csv")
write.csv(p, "data/MASSEY COLLEY p.csv")
write.csv(b, "data/MASSEY COLLEY b.csv")

