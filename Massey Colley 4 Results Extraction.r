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
print("MODULE START: MC MODEL: RESULTS EXTRACTION")
library(dplyr)
regions <- read.csv("data/Regions.csv", header = TRUE, sep = ",") # nolint
ranking_data <- read.csv("data/MC_FinalMasseyRankings.csv", header = TRUE, sep = ",") # nolint
ranking_data <- merge(ranking_data, regions, by.x = "Team", by.y = "team", all = TRUE) # nolint
columns_to_select <- c("Team", "region", "FinalRank")
ranking_data_North <- ranking_data[ranking_data$region == "North", columns_to_select ] # nolint
ranking_data_North <- ranking_data_North[order(ranking_data_North$"FinalRank"), ] # nolint
ranking_data_North$massey_rank <- NA # nolint
ranking_data_North$massey_rank <- 1:nrow(ranking_data_North) # nolint
ranking_data_South <- ranking_data[ranking_data$region == "South", columns_to_select ] # nolint
ranking_data_South <- ranking_data_South[order(ranking_data_South$"FinalRank"), ] # nolint
ranking_data_South$massey_rank <- NA # nolint
ranking_data_South$massey_rank <- 1:nrow(ranking_data_South) # nolint
ranking_data_West <- ranking_data[ranking_data$region == "West", columns_to_select ] # nolint
ranking_data_West <- ranking_data_West[order(ranking_data_West$"FinalRank"), ] # nolint
ranking_data_West$massey_rank <- NA # nolint
ranking_data_West$massey_rank <- 1:nrow(ranking_data_West) # nolint
ranking_data_East <- ranking_data[ranking_data$region == "East", columns_to_select ] # nolint
ranking_data_East <- ranking_data_East[order(ranking_data_East$"FinalRank"), ] # nolint
ranking_data_East$massey_rank <- NA # nolint
ranking_data_East$massey_rank <- 1:nrow(ranking_data_East) # nolint
write.csv(ranking_data_North, "data/MC_Massey_NorthRegionRanking.csv")
write.csv(ranking_data_South, "data/MC_Massey_SouthRegionRanking.csv")
write.csv(ranking_data_West, "data/MC_Massey_WestRegionRanking.csv")
write.csv(ranking_data_East, "data/MC_Massey_EastRegionRanking.csv")

ranking_data <- read.csv("data/MC_FinalColleyRankings.csv", header = TRUE, sep = ",") # nolint
ranking_data <- merge(ranking_data, regions, by.x = "Team", by.y = "team", all = TRUE) # nolint
columns_to_select <- c("Team", "region", "FinalRank")
ranking_data_North <- ranking_data[ranking_data$region == "North", columns_to_select ] # nolint
ranking_data_North <- ranking_data_North[order(ranking_data_North$"FinalRank"), ] # nolint
ranking_data_North$colley_rank <- NA # nolint
ranking_data_North$colley_rank <- 1:nrow(ranking_data_North) # nolint
ranking_data_South <- ranking_data[ranking_data$region == "South", columns_to_select ] # nolint
ranking_data_South <- ranking_data_South[order(ranking_data_South$"FinalRank"), ] # nolint
ranking_data_South$colley_rank <- NA # nolint
ranking_data_South$colley_rank <- 1:nrow(ranking_data_South) # nolint
ranking_data_West <- ranking_data[ranking_data$region == "West", columns_to_select ] # nolint
ranking_data_West <- ranking_data_West[order(ranking_data_West$"FinalRank"), ] # nolint
ranking_data_West$colley_rank <- NA # nolint
ranking_data_West$colley_rank <- 1:nrow(ranking_data_West) # nolint
ranking_data_East <- ranking_data[ranking_data$region == "East", columns_to_select ] # nolint
ranking_data_East <- ranking_data_East[order(ranking_data_East$"FinalRank"), ] # nolint
ranking_data_East$colley_rank <- NA # nolint
ranking_data_East$colley_rank <- 1:nrow(ranking_data_East) # nolint
write.csv(ranking_data_North, "data/MC_Colley_NorthRegionRanking.csv")
write.csv(ranking_data_South, "data/MC_Colley_SouthRegionRanking.csv")
write.csv(ranking_data_West, "data/MC_Colley_WestRegionRanking.csv")
write.csv(ranking_data_East, "data/MC_Colley_EastRegionRanking.csv")




print("MODULE END: MC MODEL: RESULTS EXTRACTION")