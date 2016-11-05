plot2 <- function (full_path_to_file) {

#subset the data file for the two days in February at load time.
#cast the Date and Time columns as characters for now (colClasses).
#na.strings argument is crucial!

feb1_feb2_2007_data <- subset(read.table(unz(full_path_to_file,"household_power_consumption.txt"),header=TRUE,sep=";",dec=".",na.strings = "?", colClasses = c(rep("character",2),rep("numeric",7))),Date == "1/2/2007" | Date == "2/2/2007")

#add a concatenated datetime field to the data.frame 
#feb1_feb2_2007_data$concat_datetime <- paste(as.Date(feb1_feb2_2007_data$Date, format="%d/%m/%Y"),feb1_feb2_2007_data$Time)
feb1_feb2_2007_data$concat_datetime <- strptime(paste(feb1_feb2_2007_data$Date, feb1_feb2_2007_data$Time, sep=" "),format="%d/%m/%Y %H:%M:%S")

#obtain the day of the week for the x-axis label, add it as column to data.frame
#this took an UNBELIEVABLE amount of time to figure out!! ARGH!!
#feb1_feb2_2007_data$dow <- weekdays(as.Date(feb1_feb2_2007_data$concat_datetime),abbreviate = T)

png(file = "plot2.png",width=480,height=480,res=72)

with(feb1_feb2_2007_data,plot(concat_datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

#This gets pretty close, just need the Thu-Fri-Sat scale on x axis:
#with(feb1_feb2_2007_data, plot(Global_active_power,type="l",xaxt = "n",xlab=dow,ylab="Global Active Power (kilowatts)"))

#NOPE
#feb1_feb2_2007_data$Date <- as.Date(feb1_feb2_2007_data$Date, "%d/%m/%Y")
#plot(feb1_feb2_2007_data$Global_active_power ~ feb1_feb2_2007_data$Date, feb1_feb2_2007_data, xaxt = "n", type = "l")
#axis(1, feb1_feb2_2007_data$dow, cex.axis = .7)

dev.off() 
}
