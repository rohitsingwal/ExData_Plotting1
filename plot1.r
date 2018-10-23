##Creating working directory, if non-existent
if(!file.exists("exploratory_data_analysis_project_1")){
	dir.create("exploratory_data_analysis_project_1")
}

##Sets working directory
setwd(".\\exploratory_data_analysis_project_1")

##Downloads data set from the given URL, stores it as data.zip, saves the download date and unzips the dataset
if(!file.exists("household_power_consumption.txt")){
	fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
	download.file(fileUrl, destfile = "data.zip")
	dateDownloaded <- date()
	unzip("data.zip")
}

##Reads the household_power_consumption dataset
data <- read.table(".\\household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

##Cleans the data
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
data <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"),]
data <- cbind(data,datetime = mapply(function(x,y) paste(x, y, sep = " ",collapse = ""),data$Date,data$Time))
data$datetime <- as.character(data$datetime)
data$datetime <- strptime(data$datetime,format = "%Y-%m-%d %H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)

##Plots plot1.png
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.copy(png, file="plot1.png",width = 480, height = 480)
dev.off()