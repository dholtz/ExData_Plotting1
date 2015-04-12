
# Load the needed packages
packages <- c("data.table", "lubridate", "datasets")
sapply(packages, require, character.only=TRUE, quietly=TRUE)


df <- fread("household_power_consumption.txt", skip = "1/2/2007", nrows = 2880, 
            colClasses = c("DATE", "numeric", "numeric", "numeric", "numeric","numeric",
                           "numeric","numeric","numeric"), sep = ";", na.string = "?")

setnames(df, c("date", "time", "global_active_power", "global_reactive_power", "voltage", 
               "global_intensity", "sub_metering_1", "sub_metering_2", "sub_metering_3"))

df$DateTime <- dmy_hms(paste(df$date, df$time))

png(file = "plot1.png")
hist(df$global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main = "Global Active Power")
dev.off()



