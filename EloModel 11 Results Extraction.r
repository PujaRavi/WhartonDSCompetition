######################################################## # nolint
## 2025 Wharton Data Science Competition
## EloModel 11 Results Extrction.r
## This is program which takes file ELO_FINAL_Rankings.csv and
## extracts results for the Wharton Competition
##
## INPUT FILE: data/ELO Final Rankings.csv
## OUTPUT FILE: data/ELO_NorthRegionRanking.csv
## OUTPUT FILE: data/ELO_SouthRegionRanking.csv
## OUTPUT FILE: data/ELO_WestRegionRanking.csv
## OUTPUT FILE: data/ELO_EastRegionRanking.csv
## OUTPUT FILE: data/ELO_EastRegionWinPercentages.csv
##
## Programmer: Puja Ravi (International Academy)
######################################################## # nolint
"2025 Wharton Data Science Competition"
print("MODULE START: ELO MODEL: RESULTS EXTRACTION")
library(dplyr)
ranking_data <- read.csv("data/ELO_FINAL_RANKINGS.csv", header = TRUE, sep = ",") # nolint
columns_to_select <- c("team", "region", "FinalRank")
ranking_data_North <- ranking_data[ranking_data$region == "North", columns_to_select ] # nolint
ranking_data_North <- ranking_data_North[order(ranking_data_North$"FinalRank"), ] # nolint
ranking_data_North$rankseq_number <- NA # nolint
ranking_data_North$rankseq_number <- 1:nrow(ranking_data_North) # nolint
ranking_data_South <- ranking_data[ranking_data$region == "South", columns_to_select ] # nolint
ranking_data_South <- ranking_data_South[order(ranking_data_South$"FinalRank"), ] # nolint
ranking_data_South$rankseq_number <- NA # nolint
ranking_data_South$rankseq_number <- 1:nrow(ranking_data_South) # nolint
ranking_data_West <- ranking_data[ranking_data$region == "West", columns_to_select ] # nolint
ranking_data_West <- ranking_data_West[order(ranking_data_West$"FinalRank"), ] # nolint
ranking_data_West$rankseq_number <- NA # nolint
ranking_data_West$rankseq_number <- 1:nrow(ranking_data_West) # nolint
ranking_data_East <- ranking_data[ranking_data$region == "East", columns_to_select ] # nolint
ranking_data_East <- ranking_data_East[order(ranking_data_East$"FinalRank"), ] # nolint
ranking_data_East$rankseq_number <- NA # nolint
ranking_data_East$rankseq_number <- 1:nrow(ranking_data_East) # nolint
write.csv(ranking_data_North, "data/ELO_NorthRegionRanking.csv")
write.csv(ranking_data_South, "data/ELO_SouthRegionRanking.csv")
write.csv(ranking_data_West, "data/ELO_WestRegionRanking.csv")
write.csv(ranking_data_East, "data/ELO_EastRegionRanking.csv")
eloranking <- read.csv("data/ELO RANKINGS.csv", header = TRUE, sep = ",") # nolint
eastRegion <- read.csv("data/East Region.csv", header = TRUE, sep = ",") # nolint
eastRegion <- eastRegion %>% # nolint
  left_join(ranking_data_East, by = c("team_home" = "team")) %>%
  mutate(team_home_rank = FinalRank) %>% # nolint
  select(-FinalRank) # Remove the extra finalrank column that was joined
eastRegion <- eastRegion %>% # nolint
  left_join(ranking_data_East, by = c("team_away" = "team")) %>%
  mutate(team_away_rank = FinalRank) %>% # nolint
  select(-FinalRank) # Remove the extra finalrank column that was joined
eastRegion <- eastRegion %>% # nolint
  left_join(eloranking, by = c("team_home" = "team")) %>%
  mutate(team_home_perc = HWAdj1Percentage) %>%
  select(-HWAdj1Percentage) # Remove the extra finalrank column that was joined
eastRegion <- eastRegion %>% # nolint
  left_join(eloranking, by = c("team_away" = "team")) %>%
  mutate(team_away_perc = HWAdj1Percentage) %>%
  select(-HWAdj1Percentage) # Remove the extra finalrank column that was joined
eastRegion$team_home_perc_diff <- NA # nolint
eastRegion$team_home_perc_diff <- eastRegion$team_home_perc - 50 # nolint
eastRegion$team_away_perc_diff <- NA # nolint
eastRegion$team_away_perc_diff <- eastRegion$team_away_perc - 50 # nolint
eastRegion$team_home_perc_diff_delta <- NA # nolint
eastRegion$team_home_perc_diff_delta <- (eastRegion$team_home_perc_diff - eastRegion$team_away_perc_diff) + 50 # nolint
eastRegion$team_away_perc_diff_delta <- NA # nolint
eastRegion$team_away_perc_diff_delta <- (eastRegion$team_away_perc_diff - eastRegion$team_home_perc_diff) + 50 # nolint
league_summary <- read.csv("data/ELO League Summary.csv", header = TRUE, sep = ",") # nolint
home_advantage <- league_summary$Advantage[league_summary$home_away == "home"] # nolint
away_advantage <- league_summary$Advantage[league_summary$home_away == "away"] # nolint
eastRegion$team_home_win_perc <- NA # nolint
eastRegion$team_home_win_perc <- eastRegion$team_home_perc_diff_delta  + home_advantage # nolint
eastRegion$team_away_win_perc <- NA # nolint
eastRegion$team_away_win_perc <- eastRegion$team_away_perc_diff_delta  + away_advantage # nolint
eastRegion$WINNING.. <- ifelse(eastRegion$team_home_win_perc > eastRegion$team_away_win_perc, eastRegion$team_home_win_perc, eastRegion$team_away_win_perc) # nolint
columns_to_select <- c("game_id", "description", "team_home", "team_away", "seed_home", "seed_away", "home_away_NS", # nolint
  "rest_days_Home", "rest_days_Away", "travel_dist_Home", "travel_dist_Away", "WINNING..", # nolint
  "team_home_rank", "team_home_perc", "team_home_win_perc", # nolint
  "team_away_rank", "team_away_perc", "team_away_win_perc") # nolint
eastRegionPrint <- eastRegion[startsWith(eastRegion$game_id, "G"), columns_to_select] # nolint
write.csv(eastRegionPrint, "data/ELO_EastRegionWinPercentages.csv")

print("MODULE END: ELO MODEL: RESULTS EXTRACTION")