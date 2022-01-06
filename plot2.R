library("data.table")

# Read data
powerDT <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Exclude Scientific Notation
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date format and Filter Dates
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Set the graph width and height
png("plot2.png", width=480, height=480)

# Plot 2 Global Active Power_2
plot(x = powerDT[, dateTime]
     , y = powerDT[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()