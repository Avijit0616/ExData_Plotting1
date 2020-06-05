setwd("D:/R working directory")
getwd()
if(!file.exists("./PowerConsumption_RawData")){
  dir.create("./PowerConsumption_RawData")
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                ,destfile = "./PowerConsumption_RawData/PC_zip.zip")
}
if(!file.exists("./PowerConsumption")){
  dir.create("./PowerConsumption")
  unzip(zipfile = "./PowerConsumption_RawData/PC_zip.zip", exdir = "./PowerConsumption")
}

data_full <- fread(paste(getwd(),"/PowerConsumption/household_power_consumption.txt",
                         sep = ""), stringsAsFactors = F, na.strings = "?")
data_req <- subset(data_full, Date %in% c("1/2/2007","2/2/2007"))
data_req$Date<- as.Date(data_req$Date, format = "%d/%m/%Y")
date_time <- paste(as.Date(data_req$Date),data_req$Time)
data_req$date_time <- as.POSIXct(date_time)

with(data_req,
     plot(Global_active_power~date_time, type="l",
          ylab="Global Active Power (kilowatts)", xlab="")
)

dev.copy(png, file = "./PowerConsumption/plot2.png", width = 480, height = 480)
dev.off()
