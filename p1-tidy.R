# p1-tidy.R
# Randall Bohn
# exdata-035
# download the data for exdata-035
# make it tidy, save for use in plot*.R.
# project 1

# download the source file, extract from the .zip
download_extract <- function(url) {
  datafile <- "household_power_consumption.zip"
  if (!file.exists(datafile)) {
    download.file(url=dataurl, destfile = datafile)
  }
  
  zipfiles <- unzip(datafile, list=TRUE)
  if (!file.exists(zipfiles$Name[1])) {
    unzip(datafile)
  }
}

# You should now have a file named "household_power_consumption.txt"
# in the current directory.

# Reading a subset of rows:
# http://stackoverflow.com/questions/25932628/how-to-read-a-subset-of-large-dataset-in-r

make_tidy <- function(input, output) {
  # first get the headers
  
  HEADERS <- fread(input, nrows=0, sep=";")
  
  # based on 
  # readLines(zipfiles$Name[1], n=5) ##etc
  # date format is d/m/yyy, where the date is not padded with zeros.
  
  # There are 24 * 60 = 1440 minutes in one day
  # Find the first row for the target days 1/2/2007 2/2/2007
  # 2007-02-01 and 2007-02-02
  # this will take some time
  #firstRow <- grep("1/2/2007", readLines(fname))[1]
  firstRow <- 66638L
  
  # but it makes this faster
  DT <- fread(input, sep=";", skip=firstRow-1, nrows=2*24*60)
  colnames(DT) <- colnames(HEADERS)
  rm(HEADERS)
  # make sure we got the target days with 1440 observations each
  #table(DT$Date)
  
  # Now force the numeric columns:
  # fread() won't assign NA values so we have to do it after.
  # str(DT)
  # never mind, we're good (no missing values in the subset)
  
  # Convert the dates
  #DT$day <- DT$Date
  #sapply(DT$Date, function(d) strptime(d, "%d/%m/%Y", tz="GMT"))
  DT[Date=="1/2/2007", date:=paste("2007-02-01", Time)]
  DT[Date=="2/2/2007", date:=paste("2007-02-02", Time)]
  
  # discard the Date and Time column as we no longer need them
  DT[, Date:=NULL]
  DT[, Time:=NULL]
  
  # use tidy column names in place of the originals
  colnames(DT) <- c("global_power","global_reactive_power", "voltage", "global_current", 
                       "zone1meter", "zone2meter", "zone3meter", "date")
  # save to the output file as CSV, no row names
  write.table(DT, file=output, sep=",", row.names = FALSE)
}

dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
rawfile <- "./household_power_consumption.txt"
tidyfile = "./tidy-households.txt"
if (!file.exists(tidyfile)) {
  download_extract(dataurl)
  make_tidy(rawfile, tidyfile)
}
