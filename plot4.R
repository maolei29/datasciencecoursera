### plot4.R
# read in data:
power <- read.table("household_power_consumption.txt", 
                    sep= ";", dec = ".", header = TRUE)

# subset two days:
sub_dat <- subset(power, Date=="1/2/2007" | Date=="2/2/2007")

# add column for kilowatts:
library(dplyr)
sub_dat2 <- mutate(sub_dat, Gap_kw = as.numeric(sub_dat$Global_active_power)/1000)

# extract time as weekday:
#install.packages("lubridate")
library(lubridate)
#sub_dat3 <- mutate(sub_dat2, weekdays = wday(as.Date(sub_dat$Date,'%d/%m/%Y'), label=TRUE))

# extract date and time:
datetime <- strptime(paste(sub_dat2$Date, sub_dat2$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

## plot4:
#plot datetime as x, kilowatts as y:
png("plot4.png")
par(mfrow = c(2, 2)) 
#plot upper left:
plot(datetime, as.numeric(sub_dat2$Global_active_power), type="l", xlab="", ylab="Global Active Power", cex=0.2)
#plot upper right:
plot(datetime, as.numeric(sub_dat$Voltage), type="l", xlab="datetime", ylab="Voltage")
#plot lower left:
plot(datetime, as.numeric(sub_dat2$Sub_metering_1), type="l", ylab="Energy Submetering", xlab="")
lines(datetime, as.numeric(sub_dat2$Sub_metering_2), type="l", col="red")
lines(datetime, as.numeric(sub_dat2$Sub_metering_3), type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
#plot lower right:
plot(datetime, as.numeric(sub_dat2$Global_reactive_power), type="l", xlab="", ylab="Global Active Power", cex=0.2)

dev.off()