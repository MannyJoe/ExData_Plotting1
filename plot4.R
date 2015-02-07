###############################
## Exploratory Data Analysis ##
##      Course Project 1     ##
##          plot4.R          ##
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


#########################################
### Create Multiple Base Plot (plot4) ###
#########################################

# Prepare png device and set parameters, units in pixels (480 by 480) with a 
# white background

png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")

# setting up a 2 by 2 multiple base plot, margins set to: bottom 5, left 5, 
# top 5, right 2; text and symbols set to 0.75 zoom

par(mfrow = c(2, 2), mar = c(5, 5, 5, 2), cex=.75)


#################################################
## Place previously designed plot2 in top left ##
#################################################

# plot Global Active Power over two days, as first plot in a 2 by 2 multiple
# base plot, type line ("l") plot with DateTime as the x axis (independent
# variable), no X axis label, Y axis label "Global Active Power"

plot(datasubset$Global_active_power~datasubset$DateTime, xlab ="",
     ylab="Global Active Power", type="l")


###################################
## Place New_Plot_A in top right ##
###################################

# plot Voltage over two days, as second plot in a 2 by 2 multiple base plot
# line ("l") plot with DateTime as the x axis (independent variable)
# no X axis needed (NULL xaxt), Y axis label "Voltage"

plot(datasubset$Voltage~datasubset$DateTime, xaxt=NULL, xlab = "datetime",
     ylab = "Voltage", type="l")


#####################################################################
## Place plot similiar to previously prepared Plot3 in bottom left ##
#####################################################################

# Base Plot with Annotation, tracking three variables over two days
# as third plot in a 2 by 2 multiple base plot, line ("l") plot with DateTime
# as the x axis (independent variable), no X axis label, Y axis label "Global
# Active Power (kilowatts)"

with(datasubset, {
      
      plot(Sub_metering_1~DateTime, type="l",
           
           ylab="Global Active Power (kilowatts)", xlab="")
      
# Add additional line plots for Sub metering 2 (red) and 3 (blue)
      
      lines(Sub_metering_2~DateTime, col='Red')
      lines(Sub_metering_3~DateTime, col='Blue')
      
})

# add top right legend, setting legend lines with a '1' thickness for the three
# variables with corresponding colors, ***no box in this plot3 version***

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")


######################################
## Place New_Plot_B in bottom right ##
######################################

# plot Global_reactive_power over two days, last plot in a 2 by 2 multiple base
# plot, line ("l") plot with DateTime as the x axis (independent variable)
# no X axis needed (NULL xaxt)

plot(datasubset$Global_reactive_power~datasubset$DateTime, xaxt=NULL,
     xlab = "datetime", ylab = "Global_reactive_power", type="l")


## Turn graphics device off ##

dev.off()
