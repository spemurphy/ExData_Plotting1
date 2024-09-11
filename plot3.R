## ---------------------------------Load Data------------------------------------------------
library(tidyverse)
library(lubridate)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "electrical_power_consumtpion.zip"

download.file(url, destfile, mode="wb")

unzip(destfile, exdir="electrical_power_consumption")

list.files("electrical_power_consumption", recursive=TRUE)

getwd()

file_path_as_absolute("electrical_power_consumption")


lec <- read_delim("/Users/seanmurphy/Desktop/DS_coursera/electrical_power_consumption/electrical_power_consumption/household_power_consumption.txt", 
                  delim = ";",
                  na = c("?"),
                  col_types = cols
                  (Date = col_date(format = "%d/%m/%Y"),
                    Time = col_time(format = "")
                  )) %>%
  filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))
head(lec)

##---------------------------Create Plots--------------------------------------------------
lec$datetime <- with(lec, ymd(lec$Date) + hms(lec$Time))

plot(lec$datetime, lec$Sub_metering_1,type="l", ylab="Energy sub metering", xlab="")
lines(lec$datetime, lec$Sub_metering_2, col="red")
lines(lec$datetime, lec$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)

##----------------------------Create PNG----------------------------------------------------
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
