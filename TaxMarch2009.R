tax_march_2009 <- read.csv("C:/Users/James/Desktop/DataMiningFinalExam/DataMiningFinalExam/TaxMarch2009.csv", row.names=1, head=TRUE, sep=",")
tax_march_2009 <- na.omit(tax_march_2009)
#is.data.frame(tax_march_2009)
#View(tax_march_2009)

tax_march_2009_clean <- tax_march_2009
tax_march_2009_clean$Income.group <- NULL
tax_march_2009_clean$Legal.origin <- NULL
tax_march_2009_clean <- na.omit(tax_march_2009_clean)
#is.na(tax_march_2009_clean)
#View(tax_march_2009_clean[,1])

results <- kmeans(tax_march_2009_clean, 4)
#table(tax_march_2009$Income.group, results$cluster)
#View(results$cluster)
#View(rownames(tax_march_2009_clean))

#plot(tax_march_2009[c("GDP.pc.2003", "Statutory.Corporate.Tax.Rate")], col=results$cluster)

#install.packages("ggplot2")
library(ggplot2)
#install.packages("dplyr")
library(dplyr)
#install.packages("maps")
library(maps)
#install.packages("mapproj")

WorldData <- ggplot2::map_data('world')
WorldData %>% filter(region != "Antarctica") -> WorldData
WorldData <- fortify(WorldData)

df <- data.frame(region=rownames(tax_march_2009), value=results$cluster, stringsAsFactors=FALSE)

p <- ggplot()
p <- p + geom_map(data=WorldData, map=WorldData, aes(x=long, y=lat, group=group, map_id=region), fill="white", colour="#7f7f7f", size=0.5)
p <- p + geom_map(data=df, map=WorldData, aes(fill=value, map_id=region), colour="#7f7f7f", size=0.5)
p <- p + coord_map("rectangular", lat0=0, xlim=c(-180,180), ylim=c(-60, 90))
p <- p + scale_fill_continuous(low="thistle2", high="darkred", guide="colorbar")
p <- p + scale_y_continuous(breaks=c())
p <- p + scale_x_continuous(breaks=c())
p <- p + labs(fill="legend", title="Tax March 2009 Clustering", x="", y="")
p <- p + theme_bw()
p <- p + theme(panel.border = element_blank())
p
