#
# overall goal here is simply to examine how household energy usage varies over a 2-day 
# period in February, 2007. 
#
# Construct the plot and save it to a PNG file with a width of 480 pixels and a 
# height of 480 pixels.
# 

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
