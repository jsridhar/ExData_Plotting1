

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

# create a histogram
png(filename = "plot1.png", width = 480, height = 480)
hist(plotData$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
