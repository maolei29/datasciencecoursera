# read in data:
power <- read.table("household_power_consumption.txt", 
                    sep= ";", dec = ".", header = TRUE)
# subset the two days:
sub_dat <- subset(power, Date=="1/2/2007" | Date=="2/2/2007")

# add column for kilowatts:
library(dplyr)
sub_dat2 <- mutate(sub_dat, Gap_kw = as.numeric(sub_dat$Global_active_power)/1000)

# open png as graphic device:
png("plot1.png")

# plot histogram:
hist(sub_dat2$Gap_kw, xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power", col="red")

# add rug:
rug(sub_dat2$Gap_kw)

#close graphic device:
dev.off()

