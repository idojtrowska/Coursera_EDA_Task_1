library(dplyr)
library(tools)

getwd()
setwd("C:/Users/Izabela/Desktop/exdata_data_household_power_consumption")

#read txt as a table and create a new table with the date and time
tbl <- read.table("household_power_consumption.txt", dec = ".", stringsAsFactors = FALSE,
                  colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), 
                  header = TRUE, sep = ";", na.strings = "?")

#subset data
df <- filter(tbl, Date %in% c("1/2/2007", "2/2/2007"))

# new column date_time (x axis)
df$Date <- as.Date(df$Date, "%d/%m/%Y")

df <- 
  mutate(df, date_time = as.POSIXct(paste(df$Date, df$Time, sep=" "), 
                                    template = "%d/%m/%Y %H:%M:%S", tz = "Sys.timezone"()))
#Plot 4
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))


plot(x = df$date_time, y = df$Global_active_power, type="l", col = "black", xlab="", ylab="Global active power")

plot(x=df$date_time, y = df$Voltage, type="l", col = "black", ylab="Voltage", xlab = "datetime")


with(df, 
     { plot(x=date_time, y = Sub_metering_1, type="l", col = "black", xlab="", ylab="Energy sub metering")
       lines(x=date_time, y = Sub_metering_2, type="l", col = "red")
       lines(x=date_time, y = Sub_metering_3, type="l", col = "blue")
       legend("topright", lty = "solid", col = c("black", "red", "blue"), 
              legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
     })


plot(x=df$date_time, y = df$Global_reactive_power, type="l", col = "black", ylab="Global_reactive_power", xlab = "datetime")
dev.off()