#!/usr/bin/R --verbose --quiet

if (!file.exists("household_power_consumption.txt")) {
    if (!file.exists("household_power_consumption.zip")) {
        print("Downloading data ...")
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "household_power_consumption.zip", method = "curl", quiet = TRUE)
    }
    # unzip data
    unzip("household_power_consumption.zip", overwrite = TRUE)
}
