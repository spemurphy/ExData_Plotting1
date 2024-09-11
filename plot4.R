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
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

#plot 1
plot(lec$datetime, lec$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", cex.lab=0.7)
#plot 2
plot(lec$datetime, lec$Voltage, type="l", ylab="Voltage", xlab="datetime", cex.lab=0.7)
#plot 3
plot(lec$datetime, lec$Sub_metering_1,type="l", ylab="Energy sub metering", xlab="", cex.lab=0.7)
lines(lec$datetime, lec$Sub_metering_2, col="red")
lines(lec$datetime, lec$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, cex=0.5)
#plot 4
plot(lec$datetime, lec$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime", cex.lab=0.7)


##----------------------------Create PNG----------------------------------------------------
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
