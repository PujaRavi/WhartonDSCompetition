library(dplyr)

games_data <- read.csv("data/games_2022_D1_master.csv", header = TRUE, sep = ",") # nolint
# Count the number of rows
unique_values <- unique(games_data$game_id)

formatted_data <- games_data %>%
  group_by(game_id) %>%
  summarise(
    Wteam_name = team[which.max(team_score)],
    Lteam_name = team[which.min(opponent_team_score)],
    Wscore = max(team_score),
    Lscore = min(opponent_team_score),
    region = first(region)
  ) %>%
  ungroup()

print(nrow(games_data))
print(nrow(formatted_data))



write.csv(formatted_data, "data/Massey games_data_formatted.csv")
