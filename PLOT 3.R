#first I download the file and unzip.
link <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(link, destfile = "dataset.zip")
unzip("dataset.zip")
#Read the table and order rows and columns
div <- c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric')
t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = div)
t$Date <- as.Date(t$Date, "%d/%m/%Y")
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
t <- t[complete.cases(t),]
dateTime <- paste(t$Date, t$Time)
t$dateTime <- as.POSIXct(dateTime)
#Until I order the table, I can start to make the plots

#PLOT 3
with(t, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()