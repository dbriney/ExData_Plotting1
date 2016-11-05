plot4 <- function (zipfile_plus_path) {

#subset the data file for the two days in February at load time.
#cast the Date and Time columns as characters for now (colClasses).
#na.strings argument is crucial!

feb1_feb2_2007_data <- subset(read.table(unz(zipfile_plus_path,"household_power_consumption.txt"),header=TRUE,sep=";",dec=".",na.strings = "?", colClasses = c(rep("character",2),rep("numeric",7))),Date == "1/2/2007" | Date == "2/2/2007")

#add a concatenated datetime field to the data.frame 
#feb1_feb2_2007_data$concat_datetime <- paste(as.Date(feb1_feb2_2007_data$Date, format="%d/%m/%Y"),feb1_feb2_2007_data$Time)
feb1_feb2_2007_data$concat_datetime <- strptime(paste(feb1_feb2_2007_data$Date, feb1_feb2_2007_data$Time, sep=" "),format="%d/%m/%Y %H:%M:%S")

png(file = "plot4.png",width=480,height=480,res=72)

par(mfrow = c(2,2), mar = c(5,4,2,1))

with(feb1_feb2_2007_data, {
  #Note: no "(kilowatts)" in the target picture
  plot(concat_datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power")
  #I have no idea how par(new=) works, but the proof is in the pudding...
  par(new=F)
  plot(concat_datetime, Voltage, type="l", xlab="datetime", ylab="Voltage")
  par(new=F)
  plot(concat_datetime, Sub_metering_1, type="n",xlab = "",ylab="")
  par(new=T)
  plot(concat_datetime, Sub_metering_1, type="l", xlab="", col = "black", ylab="Energy sub metering")
  lines(concat_datetime, Sub_metering_2, col="red")
  lines(concat_datetime, Sub_metering_3, col="blue")
  #Note bty= argument to match the target picture, which has no box to enclose the legend. 
  legend("topright", col = c("black","red","blue"), lty = 1, bty = "n", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  par(new=F)
  #Note ylab= argument not specified, to match the target picture. Take that, ya BEE-OTCH!
  plot(concat_datetime, Global_reactive_power, type="l", xlab="datetime")
  par(new=F)
})

dev.off() 
}
