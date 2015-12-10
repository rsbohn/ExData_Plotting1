# plot4.R
# Randall Bohn
# 2015-12-10
# exdata-035

library(data.table)
source("./p1-tidy.R")

DT=fread(tidyfile)
# note: column names are changed in "tidy-households.txt"
DT[,timestamp := as.POSIXct(date)]

# use the EN_us locale
Sys.setlocale(locale = "en_US.UTF-8")

png(filename="plot4.png", width=480, height=480, units="px")
par(mfrow = c(2,2))
# first plot: Global Active Power
plot(DT$timestamp, DT$global_power, type = "l", xlab = "",
     ylab = "Global Active Power")

# second plot: Voltage
plot(DT$timestamp, DT$voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# third pot: Energy sub metering
plot(DT$timestamp, DT$zone1meter, type = "l", xlab = "", 
     ylab = "Energy sub metering")
lines(DT$timestamp, DT$zone2meter, lwd=1, col="red")
lines(DT$timestamp, DT$zone3meter, lwd=1, col="blue")

legend("topright", bty = "n", lwd = 2, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# fourth plot: Global reactive power
# Note that the original column name reappears as the y axis label.
plot(DT$timestamp, DT$global_reactive_power, type="l", xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()