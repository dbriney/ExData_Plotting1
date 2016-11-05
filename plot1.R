plot1 <- function (full_path_to_file) {

#subset the data file for the two days in February at load time.
#cast the Date and Time columns as characters for now (colClasses).
#na.strings argument is crucial!

feb1_feb2_2007_data <- subset(read.table(unz(full_path_to_file,"household_power_consumption.txt"),header=TRUE,sep=";",dec=".",na.strings = "?", colClasses = c(rep("character",2),rep("numeric",7))),Date == "1/2/2007" | Date == "2/2/2007")

png(file = "plot1.png",width=480,height=480,res=72)

hist(feb1_feb2_2007_data$Global_active_power, col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

dev.off() }
