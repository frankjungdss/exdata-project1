#!/usr/bin/R --verbose --quiet
# plot 4 - multiplot

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

# plot 4 - multiplot
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2), mar = c(4, 6, 4, 0.5))

# row 1 col 1 - global_active_power by time
with(data, plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l"))

# row 1 col 2 - voltage by time
with(data, plot(datetime, Voltage, ylab = "Voltage", type = "l"))

# row 2 col 1 - sub metering by time
with(data, plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
with(data, lines(datetime, Sub_metering_1, type = "l", col = "black"))
with(data, lines(datetime, Sub_metering_2, type = "l", col = "red"))
with(data, lines(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = c(1,1), col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# row 2 col 2 - Global_reactive_power
with(data, plot(datetime, Global_reactive_power, type="l"))
dev.off()
