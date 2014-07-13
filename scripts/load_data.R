dir.create("data/raw")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data/raw/data.zip", "curl")
unzip("data/raw/data.zip", exdir="data/raw")
household_power_consumption <- read.csv("~/margarette/exdata_project_1/data/raw/household_power_consumption.txt", sep=";")
household_power_consumption$Date <- as.Date(household_power_consumption$Date, "%d/%m/%Y")
hpc <- household_power_consumption[ household_power_consumption$Date >= "2007-02-01" & household_power_consumption$Date <= "2007-02-02" , ]
hpc_date_time <- paste(hpc$Date, hpc$Time)
hpc_date_time <- strptime( hpc_date_time, "%Y-%m-%d %H:%M:%S")
hpc$Date <- hpc_date_time
hpc <- hpc[, c(1, 3:9)]
names(hpc)[1] <- "Date_Time"
hpc[, 2:7] <- apply(hpc[, 2:7], 2, function(x) as.numeric(as.character(x)))
write.csv(hpc, file = "data/hpc.csv", row.names = F)
rm(household_power_consumption)
rm(hpc_date_time)
