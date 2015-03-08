#Reading the data from the extracted txt file in the working directory

data <- read.table("./household_power_consumption.txt", header = T, sep = ";", nrows = 2075270)

# Subsetting the data to the specified two days in the assignment
sub_data <- data[(data$Date == "1/2/2007" | data$Date == "2/2/2007"),]

#Convertion of Date and Time columns to POSIXlt in a new column
sub_data$DateTime <- strptime(paste(sub_data$Date, sub_data$Time), "%d/%m/%Y %H:%M:%S")

#Convertion of factor variables to numeric 
sub_data$Global_active_power<- as.numeric(as.character(sub_data$Global_active_power))
sub_data$Global_reactive_power<- as.numeric(as.character(sub_data$Global_reactive_power))
sub_data$Voltage<- as.numeric(as.character(sub_data$Voltage))
sub_data$Sub_metering_1<- as.numeric(as.character(sub_data$Sub_metering_1))
sub_data$Sub_metering_2<- as.numeric(as.character(sub_data$Sub_metering_2))
sub_data$Sub_metering_3<- as.numeric(as.character(sub_data$Sub_metering_3))

# Openning a png graphic device with the specified dimensions
png(filename = "plot3.png", width = 480, height = 480, units = "px")

# Plotting an empty graph and the addition of line plots to it and finally the legend
plot(sub_data$DateTime, sub_data$Sub_metering_1, type = "n", xlab = "", 
        ylab = "Energy sub metering")
lines(sub_data$DateTime, sub_data$Sub_metering_1, type = "l")
lines(sub_data$DateTime, sub_data$Sub_metering_2, type = "l", col = "red")
lines(sub_data$DateTime, sub_data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2",
                              "Sub_metering_3"), col = c("black", "red","blue"),
       lty = 1)

# Closing the png graphic device
dev.off()