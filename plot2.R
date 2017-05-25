# read in data:
power <- read.table("household_power_consumption.txt", 
                    sep= ";", dec = ".", header = TRUE)

# subset two days:
sub_dat <- subset(power, Date=="1/2/2007" | Date=="2/2/2007")

# add column for kilowatts:
library(dplyr)
sub_dat2 <- mutate(sub_dat, Gap_kw = as.numeric(sub_dat$Global_active_power)/1000)

### for plot2:
# extract time as weekday:
#install.packages("lubridate")
library(lubridate)

# extract datetime:
datetime <- strptime(paste(sub_dat2$Date, sub_dat2$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#plot datetime as x, kilowatts as y:
png("plot2.png")
plot(datetime, as.numeric(sub_dat2$Global_active_power), type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()