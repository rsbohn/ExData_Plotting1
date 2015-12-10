# plot1.R
# Randall Bohn
# 2015-12-08
# exdata-035

source("./p1-tidy.R")

DT=fread(tidyfile)

hist(DT$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")

dev.copy(png, file="plot1.png")
dev.off()