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
write.csv(formatted_data, "data/MC_games_data.csv")

# games_data_east <- formatted_data %>%
#   filter(region == "East")
# write.csv(games_data_east, "data/MC_games_data_east.csv")
# games_data_east <- formatted_data %>%
#   filter(region == "West")
# write.csv(games_data_east, "data/MC_games_data_west.csv")
# games_data_east <- formatted_data %>%
#   filter(region == "North")
# write.csv(games_data_east, "data/MC_games_data_north.csv")
# games_data_east <- formatted_data %>%
#   filter(region == "South")
# write.csv(games_data_east, "data/MC_games_data_south.csv")