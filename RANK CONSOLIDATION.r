library(dplyr)
print("2025 Wharton Data Science Competition")
ELO_east <- read.csv("data/ELO_EastRegionRanking.csv", header = TRUE, sep = ",") # nolint
Massey_east <- read.csv("data/MC_Massey_EastRegionRanking.csv", header = TRUE, sep = ",") # nolint
Colley_east <- read.csv("data/MC_Colley_EastRegionRanking.csv", header = TRUE, sep = ",") # nolint
combined_east <- merge(ELO_east, Massey_east, by.x = "team", by.y = "Team", all = TRUE) # nolint
combined_east <- combined_east[, (names(combined_east) %in% c("team", "elo_rank","massey_rank"))]
combined_east <- combined_east[!is.na(combined_east[["team"]]), ]
combined_east <- merge(combined_east, Colley_east, by.x = "team", by.y = "Team", all = TRUE) # nolint
combined_east <- combined_east[, (names(combined_east) %in% c("team", "elo_rank","massey_rank", "colley_rank"))]
combined_east <- combined_east[!is.na(combined_east[["team"]]), ]

ELO_west <- read.csv("data/ELO_WestRegionRanking.csv", header = TRUE, sep = ",") # nolint
Massey_west <- read.csv("data/MC_Massey_WestRegionRanking.csv", header = TRUE, sep = ",") # nolint
Colley_west <- read.csv("data/MC_Colley_WestRegionRanking.csv", header = TRUE, sep = ",") # nolint
combined_west <- merge(ELO_west, Massey_west, by.x = "team", by.y = "Team", all = TRUE) # nolint
combined_west <- combined_west[, (names(combined_west) %in% c("team", "elo_rank","massey_rank"))]
combined_west <- combined_west[!is.na(combined_west[["team"]]), ]
combined_west <- merge(combined_west, Colley_west, by.x = "team", by.y = "Team", all = TRUE) # nolint
combined_west <- combined_west[, (names(combined_west) %in% c("team", "elo_rank","massey_rank", "colley_rank"))]
combined_west <- combined_west[!is.na(combined_west[["team"]]), ]

ELO_north <- read.csv("data/ELO_NorthRegionRanking.csv", header = TRUE, sep = ",") # nolint
Massey_north <- read.csv("data/MC_Massey_NorthRegionRanking.csv", header = TRUE, sep = ",") # nolint
Colley_north <- read.csv("data/MC_Colley_NorthRegionRanking.csv", header = TRUE, sep = ",") # nolint
combined_north <- merge(ELO_north, Massey_north, by.x = "team", by.y = "Team", all = TRUE) # nolint
combined_north <- combined_north[, (names(combined_north) %in% c("team", "elo_rank","massey_rank"))]
combined_north <- combined_north[!is.na(combined_north[["team"]]), ]
combined_north <- merge(combined_north, Colley_north, by.x = "team", by.y = "Team", all = TRUE) # nolint
combined_north <- combined_north[, (names(combined_north) %in% c("team", "elo_rank","massey_rank", "colley_rank"))]
combined_north <- combined_north[!is.na(combined_north[["team"]]), ]

ELO_south <- read.csv("data/ELO_SouthRegionRanking.csv", header = TRUE, sep = ",") # nolint
Massey_south <- read.csv("data/MC_Massey_SouthRegionRanking.csv", header = TRUE, sep = ",") # nolint
Colley_south <- read.csv("data/MC_Colley_SouthRegionRanking.csv", header = TRUE, sep = ",") # nolint
combined_south <- merge(ELO_south, Massey_south, by.x = "team", by.y = "Team", all = TRUE) # nolint
combined_south <- combined_south[, (names(combined_south) %in% c("team", "elo_rank","massey_rank"))]
combined_south <- combined_south[!is.na(combined_south[["team"]]), ]
combined_south <- merge(combined_south, Colley_south, by.x = "team", by.y = "Team", all = TRUE) # nolint
combined_south <- combined_south[, (names(combined_south) %in% c("team", "elo_rank","massey_rank", "colley_rank"))]
combined_south <- combined_south[!is.na(combined_south[["team"]]), ]

write.csv(combined_east, "data/COMBINED_EAST_RANKINGS.csv")
write.csv(combined_west, "data/COMBINED_WEST_RANKINGS.csv")
write.csv(combined_north, "data/COMBINED_NORTH_RANKINGS.csv")
write.csv(combined_south, "data/COMBINED_SOUTH_RANKINGS.csv")


print("Program Ended")