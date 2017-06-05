# Coursera course - Exploratory-data-analysis
# Week 4, course project.

# Plot3:
# which type (point, nonpoint, onroad, nonroad) have seen increases 
# or decrease in emissions from 1999-2008 forBaltimore City? 
# Use ggplot2.

## Read in the two input files from wd:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset data from Baltimore City
baltimore <- subset(NEI, fips==24510)

#than aggregate for years, and in addition, by type:
b_total_E_per_Year_type <- aggregate(Emissions ~ year + type, baltimore, sum)

#make plot3:
png("Plot3.png")
    library(ggplot2)
    g <- ggplot(b_total_E_per_Year_type, aes(year, Emissions, color = type)) 
    g <- g + geom_line() + ggtitle("PM2.5 Emission in Baltimore City")
    print(g)
dev.off()
