###############################
## Exploratory Data Analysis ##
##      Course Project 1     ##
##          plot3.R          ##
###############################

### Clear existing vectors ###

ls()

rm(list=ls())


### Install necessary packages ###

# Check to see if you have 'data.table' installed:

# note package names are case sensitive:

library("data.table")

## install.packages("data.table")


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


### Create Plot 3 ###

# Base Plot with Annotation, tracking three variables over two days
# line ("l") plot with DateTime as the x axis (independent variable)
# no X axis label, Y axis label "Global Active Power (kilowatts)"

with(datasubset, {
      
      plot(Sub_metering_1~DateTime, type="l",

           ylab="Global Active Power (kilowatts)", xlab="")
      
# Add additional line plots for Sub metering 2 (red) and 3 (blue)

      lines(Sub_metering_2~DateTime, col='Red')
      lines(Sub_metering_3~DateTime, col='Blue')

})

# add top right legend, setting solid line with '2' thickness for the three
# lines with corresponding colors

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# Save to file

dev.copy(png, file="plot3.png", height=480, width=480)

# Turn graphic device off

dev.off()
