plot3 <- function (zipfile_plus_path) {

#subset the data file for the two days in February at load time.
#cast the Date and Time columns as characters for now (colClasses).
#na.strings argument is crucial!

feb1_feb2_2007_data <- subset(read.table(unz(zipfile_plus_path,"household_power_consumption.txt"),header=TRUE,sep=";",dec=".",na.strings = "?", colClasses = c(rep("character",2),rep("numeric",7))),Date == "1/2/2007" | Date == "2/2/2007")

#add a concatenated datetime field to the data.frame 
#feb1_feb2_2007_data$concat_datetime <- paste(as.Date(feb1_feb2_2007_data$Date, format="%d/%m/%Y"),feb1_feb2_2007_data$Time)
feb1_feb2_2007_data$concat_datetime <- strptime(paste(feb1_feb2_2007_data$Date, feb1_feb2_2007_data$Time, sep=" "),format="%d/%m/%Y %H:%M:%S")

png(file = "plot3.png",width=480,height=480,res=72)

with(feb1_feb2_2007_data,plot(concat_datetime, Sub_metering_1, type="n"))
with(feb1_feb2_2007_data,plot(concat_datetime, Sub_metering_1, type="l", xlab="", col = "black", ylab="Energy sub metering"))
with(feb1_feb2_2007_data,lines(concat_datetime, Sub_metering_2, col="red"))
with(feb1_feb2_2007_data,lines(concat_datetime, Sub_metering_3, col="blue"))
legend("topright", col = c("black","red","blue"), lty = 1, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off() 
}
