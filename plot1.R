# read the data first
# please see ReadData.R file for details on how the data is downloaded and loaded
source("ReadData.R")

# open png device
# this automatically sets the newly opened png device the active graphics device
png(filename="plot1.png", width=480, height=480)

# plot the histogram
hist(hhpowerdata$Global_active_power, col="Red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

# close png device
dev.off()