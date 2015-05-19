#!/usr/bin/R --verbose --quiet
# plot 2 - Global Active Power (kilowatts) by datetime

# get column classes from file
data <- read.table("household_power_consumption.txt", header = TRUE,
                   stringsAsFactors = FALSE, sep = ";", na.strings = "?", nrows = 2)
dataClasses <- sapply(data, class)

# read file
data <- read.table(pipe("grep '^[12]/2/2007\\|^Date;' household_power_consumption.txt"),
                   sep = ";", na.strings = "?", header = TRUE,
                   stringsAsFactors = FALSE, colClasses = dataClasses)

# create final datetime column
data$datetime <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S", tz = "C")

# plot 2 - Global Active Power (kilowatts) by datetime
png(filename = "plot2.png", width = 480, height = 480, units = "px")
with(data, plot(datetime, Global_active_power, type = "l", asp = "square",
                xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
