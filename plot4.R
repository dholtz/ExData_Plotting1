
# Load the needed packages
packages <- c("data.table", "lubridate", "datasets")
sapply(packages, require, character.only=TRUE, quietly=TRUE)


df <- fread("household_power_consumption.txt", skip = "1/2/2007", nrows = 2880, 
            colClasses = c("DATE", "numeric", "numeric", "numeric", "numeric","numeric",
                           "numeric","numeric","numeric"), sep = ";", na.string = "?")

setnames(df, c("date", "time", "global_active_power", "global_reactive_power", "voltage", 
               "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3"))

df$DateTime <- dmy_hms(paste(df$date, df$time))

png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

with(df, plot(df$DateTime, df$global_active_power, type= "l",
              xlab = "",
              ylab = "Global Active Power"))

with(df, plot(df$DateTime, df$voltage, type= "l",
              xlab = "datetime",
              ylab = "Voltage"))

with(df, plot(df$DateTime, df$sub_metering_1, type= "l", 
              xlab = "",
              ylab = "Energy sub metering"))
lines(df$DateTime, df$sub_metering_2, col = "red", type = "l")
lines(df$DateTime, df$sub_metering_3, col = "blue", type = "l")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(df, plot(df$DateTime, df$global_reactive_power, type= "l",
              xlab = "datetime",
              ylab = "Global_reactive_power"))


dev.off()
