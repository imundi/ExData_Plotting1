# download data
# -----------------
print("Downloading data file...")
tmpdir <- tempdir()
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
file <- basename(url)
download.file(url=url, destfile=file)
print("Download complete.")
print("Unzipping data file...")
unzip(file, exdir=tmpdir)
hhpowerdatafile <- list.files(tmpdir, pattern="household_power_consumption.txt")
print("Unzip complete.")
#hhpowerdatafile <- list.files("C:/Users/Imran/SkyDrive/Learning/Coursera/Exploratory Data Analysis/projects",
#                              pattern="household_power_consumption.txt")

# open file to read data
# -----------------
print("Reading required data...")
print(hhpowerdatafile[1])
# set working directory to tmpdir
# so we can reset at the end
currentwd <- getwd()
setwd(tmpdir)

filecon <- file(description=hhpowerdatafile[1], open="r")

count <- 1
hhpowerdata <- NULL

# get the header first for column names
# to be appended later
header <- read.table(hhpowerdatafile[1], sep=";", nrows=1, header=TRUE, stringsAsFactors=FALSE)
print(header)

repeat {
  
  #print(count)
  tmpdata <- read.table(filecon, sep=";", skip=0, nrows=10000, header=FALSE, stringsAsFactors=FALSE)
  #tmpdata <- read.table(filecon, sep=";", skip=count, nrows=10000, header=FALSE)
  
#   col = c("Date", "Time", "Global_active_power", 
#             "Global_reacive_power", "Voltage", "Global_intensity", 
#             "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

# transform the date to allow for comparision
  tmpdata <- transform(tmpdata, V1 = as.Date(V1, format="%d/%m/%Y"))

#   print(head(tmpdata))

  tmpdata2 <- subset(tmpdata, V1 == "2007-02-01" | V1 == "2007-02-02")

#   print(head(tmpdata2))

  if (is.null(hhpowerdata)) {
    hhpowerdata <- tmpdata2
  } else {
    hhpowerdata <- rbind(hhpowerdata, tmpdata2) 
  }
  
  if (nrow(tmpdata) < 10000) {
    close(filecon)
    break
  }
  
#   print(head(hhpowerdata))
#   count <- count + 10000
}

# reset working directory
setwd(currentwd)

# transform the character data to numeric
hhpowerdata <- transform(hhpowerdata, V3 = as.numeric(V3), V4 = as.numeric(V4), 
                         V5 = as.numeric(V5), V6 = as.numeric(V6),
                        V7 = as.numeric(V7), V8 = as.numeric(V8))

# add proper column names (header)
colnames(hhpowerdata) <- colnames(header)

# reset row numbers
rownames(hhpowerdata) <- NULL

#print(getwd())
print(nrow(hhpowerdata))
print(head(hhpowerdata))
print("Data read complete.")