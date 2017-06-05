# Coursera course - Exploratory-data-analysis
# Week 4, course project.

# Plot6:
# Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, 
# (fips == "06037")

## Read in the two input files from wd:
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset data from Baltimore City and for LA:
baltimore <- subset(NEI, fips==24510)
LA <- subset(NEI, as.character(fips)=="06037") #some how it works this way...

# Make a logical vector with True when "Motor" contained in type.
# Note that this is not equal to the Data.category=="Onroad"!!
log_vec <- grepl("Motor", SCC$Short.Name) #ok
motor_SCC <- SCC[log_vec,] #subset from SCC, where rows related to coal.

# get a unique list of SCC (5-digit number) that are coal-related:
motor_SCC_list <- unique(motor_SCC$SCC) # well, it seems that it were unique before...

#subset data:
motor_subset_bal <- baltimore[baltimore$SCC %in% motor_SCC_list,]
motor_subset_LA <- LA[LA$SCC %in% motor_SCC_list,]

# aggregate data for plots:
total_motor_per_Year_bal <- aggregate(Emissions ~ year, motor_subset_bal, sum)
total_motor_per_Year_LA <- aggregate(Emissions ~year, motor_subset_LA, sum)

#plotting:
png("plot6.png")
#op<-par(no.readonly=TRUE)
#par(oma=c(0,0,2,0))
par(mfrow=c(1,2))
#title(main="Motor-related PM2.5 Emission in USA",outer=T)
barplot(height = total_motor_per_Year_bal$Emissions, 
        names.arg = total_motor_per_Year_bal$year, col="blue", main="Baltimore city",
        xlab = "Year", ylab="PM2.5 [ton]", ylim=c(0, 90))
barplot(height = total_motor_per_Year_LA$Emissions, 
        names.arg = total_motor_per_Year_LA$year, col="blue", main="Los Angeles",
        xlab = "Year", ylab="PM2.5 [ton]", ylim=c(0, 90))
dev.off()
