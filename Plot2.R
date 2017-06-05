# Coursera course - Exploratory-data-analysis
# Week 4, course project.

#Plot2:
# Have total emissions from PM2.5 decreased in the
# Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use base plotting system.

## Read in the two input files from wd:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset data from Baltimore City:
baltimore <- subset(NEI, fips==24510)

#than aggregate for years, as in plot1:
b_total_E_per_Year <- aggregate(Emissions ~ year, baltimore, sum)

#make plot:
png("Plot2.png")
barplot(height= b_total_E_per_Year$Emissions, col="red", 
        names.arg = b_total_E_per_Year$year, main = 
            "Total PM2.5 in Baltimore city", xlab = "Year", 
            ylab="PM2.5[ton]")
dev.off()