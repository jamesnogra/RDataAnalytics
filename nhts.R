nhts <- read.csv("C:/Users/James/Desktop/DataMiningFinalExam/DataMiningFinalExam/nhts.csv", row.names=1, head=TRUE, sep=",")
nhts <- na.omit(nhts)
#View(nhts)

results <- kmeans(nhts, 4)
plot(nhts[c("single_house", "duplex", "apartment_or_condominiums_or_townhouses", "commercial_or_industrial_or_agricultural_building_or_house", "other_housing_cave_or_boat_or_under_a_bridge_etc.")], col=results$cluster)