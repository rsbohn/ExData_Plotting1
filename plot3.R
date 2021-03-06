# plot3.R
# Randall Bohn
# 2015-12-10
# exdata-035

source("./p1-tidy.R")
library(data.table)
DT=fread(tidyfile)
# note: column names are changed in "tidy-households.txt"

DT[,timestamp := as.POSIXct(date)]
# use the EN_us locale
Sys.setlocale(locale = "en_US.UTF-8")

png(filename="plot3.png", width=480, height=480, units="px")
# http://stackoverflow.com/questions/28774111/creating-complicated-line-plots-in-r
# Dates and Times in "R Programming for Data Science" R. Peng 2015-11-30

# plot 3: sub metering
with(DT, plot(timestamp, zone1meter, xlab = "", 
              ylab = "Energy sub metering",
              type = "n"))
lines(DT$timestamp, DT$zone1meter, lwd=1)
lines(DT$timestamp, DT$zone2meter, lwd=1, col="red")
lines(DT$timestamp, DT$zone3meter, lwd=1, col="blue")

legend("topright", bty = "o", lwd = 2, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()