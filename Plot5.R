# Coursera course - Exploratory-data-analysis
# Week 4, course project.

# Plot5:
# How have emissions from motor vehicle sources changed 
# from 1999-2008 in Baltimore City?

## Read in the two input files from wd:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset data from Baltimore City
baltimore <- subset(NEI, fips==24510)

# Make a logical vector with True when "Motor" contained in type.
# Note that this is not equal to the Data.category=="Onroad"!!

# get a unique list of SCC (5-digit number) that are coal-related:
log_vec <- grepl("Motor", SCC$Short.Name) #ok
motor_SCC <- SCC[log_vec,] #subset from SCC, where rows related to coal.
motor_SCC_list <- unique(motor_SCC$SCC) # well, it seems that it were unique before...

# subset data set for plots:
motor_subset_all <- baltimore[baltimore$SCC %in% motor_SCC_list,]

#plotting:
total_CE_per_Year_all <- aggregate(Emissions ~ year, motor_subset_all, sum)
png("plot5.png")
#barplot(height = total_CE_per_Year_all$Emissions, 
        #names.arg = total_CE_per_Year_all$year, col="blue", main="Coal-related PM2.5 Emission in USA",
        #xlab = "Year", ylab="PM2.5 [ton]")

g <- ggplot(total_CE_per_Year_all, aes(factor(year), Emissions))
g <- g+geom_bar(stat="identity", fill="orange") 
print(g)
dev.off()
