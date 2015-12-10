# plot2.R
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

png(filename="plot2.png", width=480, height=480, units="px")
# http://stackoverflow.com/questions/28774111/creating-complicated-line-plots-in-r
# Dates and Times in "R Programming for Data Science" R. Peng 2015-11-30

# plot 2: global power
with(DT, plot(timestamp, global_power, xlab = "", 
              ylab = "Global Active Power (kilowatts)",
              type = "n"))
lines(DT$timestamp, DT$global_power, lwd=2)

dev.off()