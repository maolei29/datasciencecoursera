# Coursera course - Exploratory-data-analysis
# Week 4, course project.

#Plot1: boxplot of total emissions from PM2.5 for years 1999 to 2008
# abline to show lm fit.

## Read in the two input files from wd:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#first a quick check with boxplot to see the trend:
#with(NEI, boxplot(Emissions ~ year, main="Total PM2.5 emission per year",
#         xlab="Year", ylab="PM2.5 [ton]", ylim=c(0, 1)))

# get total emision per year as vector with length of 4:
total_E_per_Year <- aggregate(Emissions ~ year, NEI, sum)

# do plot:
png("plot1.png")
barplot(height = total_E_per_Year$Emissions, 
        names.arg = total_E_per_Year$year, col="yellow", main="PM2.5 Emission per Year",
        xlab = "Year", ylab="PM2.5 [ton]")
dev.off()