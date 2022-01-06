library("data.table")

# Read data 
powerDT <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Exclude Scientific Notation
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date Column to Date Type and filter the Dates for 2007-02-01 and 2007-02-02
powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# Set the graph width and height
png("plot1.png", width=480, height=480)

# Plot 1 Global Active Power
hist(powerDT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()