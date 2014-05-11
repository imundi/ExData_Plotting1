# read the data first
# please see ReadData.R file for details on how the data is downloaded and loaded
source("ReadData.R")

# convert Date + Time to POSIX date-time format
hhpowerdata$DateTime <- as.POSIXct(paste(hhpowerdata$Date, hhpowerdata$Time, sep=" "))

# open png device
# this automatically sets the newly opened png device the active graphics device
png(filename="plot2.png", width=480, height=480)

# plot the chart
with(hhpowerdata, plot(x=DateTime, y=Global_active_power, type="l", 
                       ylab="Global Active Power (kilowatts)", xlab = ""))

# close png device
dev.off()