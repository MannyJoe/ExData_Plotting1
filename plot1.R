###############################
## Exploratory Data Analysis ##
##      Course Project 1     ##
##          plot1.R          ##
###############################

### Clear existing vectors ###

ls()

rm(list=ls())


### Install necessary packages ###

# Check to see if you have 'data.table' installed:

# note package names are case sensitive:

library("data.table")

## install.packages("data.table") # if needed


### Download Zip file ###

# Download the file to load performed via Coursera page saved to
# ./EDAdata/household_power_consumption.txt


### Read the data in ###

# Load .csv flat file [file, header, sep, missing data, nrows, check.names off, 
# comments off, factor conversion off]

hpc_data <- read.csv("./EDAdata/household_power_consumption.txt", header=T,
                        sep=';', na.strings="?", nrows=2075259, check.names=F,
                        comment.char="", stringsAsFactors=F,  quote='\"')


### Clean the data ###

# Convert the date character class to 'Date' class

class(hpc_data$Date)

# Fix the date format and check class again

hpc_data$Date <- as.Date(hpc_data$Date, format="%d/%m/%Y")

class(hpc_data$Date)

# Subset data in data frame for the two dates needed

datasubset <- subset(hpc_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

class(datasubset)
str(datasubset)

# Paste Date and time 

datetime <- paste(as.Date(datasubset$Date), datasubset$Time)

class (datetime)
str(datetime)

# Convert to Date-time variable and check new class

datasubset$DateTime <- as.POSIXct(datetime)

class(datasubset$DateTime)


### Create Plot 1 ###

# Histograph Title "Global Active Power"
# X axis label "Global Active Power (kilowatts)", Y axis label "Frequency"

hist(datasubset$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Save to file

dev.copy(png, file="plot1.png", height=480, width=480)

# Turn device off

dev.off()
