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

#Plot 1
png("plot1.png", width=480, height=480)
hist(df$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylim = c(0,1200), 
     xlim = c(0,6), breaks = 12)
dev.off()