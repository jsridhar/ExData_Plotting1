

# load dependent libraries
library(dplyr)


# load data, create cache for faster execution of various plots
if (file.exists("plot.csv")) {
    
    plotData <- read.csv("plot.csv")
    
} else {
    
    plotData <- read.table("power.txt", sep = ";", header = TRUE) %>%
        mutate(Date = as.Date(Date, '%d/%m/%Y')) %>%
        filter(Date == "2007-02-01" | Date == "2007-02-02")
    
    write.csv(plotData, "plot.csv")
}

# create 4 plots
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

# global active power
plot(as.POSIXct(strptime(paste(plotData$Date, ' ', plotData$Time), '%Y-%m-%d %H:%M:%S')),
     plotData$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# Voltage
plot(as.POSIXct(strptime(paste(plotData$Date, ' ', plotData$Time), '%Y-%m-%d %H:%M:%S')),
     plotData$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Global Active Power (kilowatts)")

# Energy sub metering
plot(as.POSIXct(strptime(paste(plotData$Date, ' ', plotData$Time), '%Y-%m-%d %H:%M:%S')),
     plotData$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(as.POSIXct(strptime(paste(plotData$Date, ' ', plotData$Time), '%Y-%m-%d %H:%M:%S')),
      plotData$Sub_metering_2,
      col = "red")
lines(as.POSIXct(strptime(paste(plotData$Date, ' ', plotData$Time), '%Y-%m-%d %H:%M:%S')),
      plotData$Sub_metering_3,
      col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = c(1, 1, 1))

# Global reactive power
plot(as.POSIXct(strptime(paste(plotData$Date, ' ', plotData$Time), '%Y-%m-%d %H:%M:%S')),
     plotData$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()
