# plot1.R
# Randall Bohn
# 2015-12-08
# exdata-035

source("./p1-tidy.R")

DT=fread(tidyfile)
# note: the column names are changed in the tidy file "tidy-households.txt"

png(filename="plot1.png", width=480, height=480, units="px")

# plot 1: Histogram of Global Active Power
hist(DT$global_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")


dev.off()