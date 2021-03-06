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
#Make de histogram (plot1)
hist(t$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()