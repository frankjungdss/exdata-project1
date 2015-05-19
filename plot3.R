#!/usr/bin/R --verbose --quiet
# plot 3 - Energy sub metering by datetime

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

# plot 3 - Energy sub metering by datetime
png(filename = "plot3.png", width = 480, height = 480, units = "px")
with(data, plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n", asp = "square"))
with(data, lines(datetime, Sub_metering_1, type = "l", col = "black"))
with(data, lines(datetime, Sub_metering_2, type = "l", col = "red"))
with(data, lines(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = c(1,1), col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
