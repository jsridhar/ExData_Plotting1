

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

# create the plot
png(filename = "plot3.png", width = 480, height = 480)

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

dev.off()
