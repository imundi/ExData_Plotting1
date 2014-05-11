# read the data first
# please see ReadData.R file for details on how the data is downloaded and loaded
source("ReadData.R")

# convert Date + Time to POSIX date-time format
hhpowerdata$DateTime <- as.POSIXct(paste(hhpowerdata$Date, hhpowerdata$Time, sep=" "))

# open png device
# this automatically sets the newly opened png device the active graphics device
png(filename="plot4.png", width=480, height=480)

# plot the chart

# set the plot area to a 2x2 matrix
par(mfrow=c(2,2))

# plot (1, 1)
with(hhpowerdata, plot(x=DateTime, y=Global_active_power, type="l", ylab="Global Active Power", xlab = ""))

# plot (1, 2)
with(hhpowerdata, plot(x=DateTime, y=Voltage, type="l", ylab="Voltage", xlab = "datetime"))

#plot (2, 1)
with(hhpowerdata, plot(x=DateTime, y=Sub_metering_1, type="l", ylab="Energy sub metering", xlab = ""))
with(hhpowerdata, lines(x=DateTime, y=Sub_metering_2, type="l", col="Red"))
with(hhpowerdata, lines(x=DateTime, y=Sub_metering_3, type="l", col="Blue"))
legend("topright", lty=1, bty="n", col=c("Black", "Red", "Blue"), legend=colnames(hhpowerdata)[7:9])

# plot (2, 2)
with(hhpowerdata, plot(x=DateTime, y=Global_reactive_power, type="l", ylab="Global_reactive_power", xlab = "datetime"))

# close png device
dev.off()