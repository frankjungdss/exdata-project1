#!/usr/bin/R --verbose --quiet
# plot 1 - histogram Frequency ~ Global Active Power (kilowatts)

if (!file.exists("subsetfile")) {
    # get column classes from file
    data <- read.table("household_power_consumption.txt", header = TRUE,
                       stringsAsFactors = FALSE, sep = ";", na.strings = "?", nrows = 2)
    dataClasses <- sapply(data, class)

    # read file
    data <- read.table(pipe("grep '^[12]/2/2007\\|^Date;' household_power_consumption.txt"),
                       sep = ";", na.strings = "?", header = TRUE,
                       stringsAsFactors = FALSE, colClasses = dataClasses)
    rm(dataClasses)

    # slower but all "R"
    # data <- read.table("household_power_consumption.txt",
    #                    sep=";", header = TRUE, stringsAsFactors=FALSE,
    #                    na.strings = "?", colClasses = dataClasses)
    # data <- data[data$Date %in% c("1/2/2007","2/2/2007"), ]
    save(data, file = "subsetfile")
} else {
    load("subsetfile")
}

# plot 1 - histogram Frequency ~ Global Active Power (kilowatts)
png(filename = "plot1.png", width=480, height=480, units="px")
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)",
     col = "red", freq=TRUE, main="Global Active Power")
dev.off()
