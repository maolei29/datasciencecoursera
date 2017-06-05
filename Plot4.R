# Coursera course - Exploratory-data-analysis
# Week 4, course project.

# Plot4:
#Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?

## Read in the two input files from wd:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Make a logical vector with True when "Coal" contained in type:
log_vec <- grepl("Coal", SCC$Short.Name) #ok
coal_SCC <- SCC[log_vec,] #subset from SCC, where rows related to coal.
# get a unique list of SCC (5-digit number) that are coal-related:
coal_SCC_list <- unique(coal_SCC$SCC) # well, it seems that it were unique before...

# subset coal data for plot:
coal_subset <- NEI[NEI$SCC %in% coal_SCC_list,]

#plotting:
total_CE_per_Year <- aggregate(Emissions ~ year, coal_subset, sum)
png("plot4.png")
barplot(height = total_CE_per_Year$Emissions, 
        names.arg = total_CE_per_Year$year, col="green", main="Coal-related PM2.5 Emission",
        xlab = "Year", ylab="PM2.5 [ton]")
dev.off()
