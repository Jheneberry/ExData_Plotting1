# Exploratory Data Analysis:  Course Project
# Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007

# Data Notes:
# The dataset has 2,075,259 rows and 9 columns.
# We will only be using data from the dates 2007-02-01 and 2007-02-02.
# Note that in this dataset missing values are coded as ?

# Coding Notes:
# you may find it useful to convert the Date and Time variables to Date/Time classes in R using the 
# strptime() and as.Date() functions.

# Plot 1:  final files will be Plot1.R and Plot1.png

# STEP ONE:
# download and unzip source file and save to Working directory (WD): 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip


temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.delim(unz(temp, "household_power_consumption.txt"), sep = ";", na.strings = "?")
unlink(temp)

# Step TWO
# Combine date and time into new variable

library(tidyr)
library(dplyr)

data <- transform(data, DateTime = paste(Date, Time, sep= " ")) # WORKS!


# STEP THREE:
# Convert Date to Date class from character
# instructions propose to use as.Date() function
  
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")  # WORKS!

# STEP FOUR:
# Select date range to use ie. 2007-02-01 and 2007-02-02

data2 <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",] #WORks!


# STEP FIVE:
# Convert time to time class 
# instructions suggest to use strptime()
# USE COMBINED DATE TIME CREATED IN STEP 2
# Works! Class indicated as "POSIXct" and "POSIXt"

data2$DateTime2 <- data2$DateTime
data2$DateTime2 <- as.POSIXct(data2$DateTime2, format = "%d/%m/%Y %T", tz = "GMT")

# STEP SIX: CREATE PLOT 3
# Energy sub metering hourly, line graph
# Uses 3 columns, Sub_metering 1 - Sub_metering_3
# TITLE:  NONE
# Y axis label "Energy sub metering"
# x axis label by day
# Y axis range 0 - 30
# X axis range Thu, Fri, Sat
# no symbol, just line
# legend inside plot box, upper right corner

library(ggplot2)

png(file="Plot3.png", width = 480, height = 480 )
ggplot(data2, aes(x = DateTime2)) +
  geom_line(aes(y=Sub_metering_1, color = "Sub_metering_1")) + 
  geom_line(aes(y=Sub_metering_2, color = "Sub_metering_2")) + 
  geom_line(aes(y=Sub_metering_3, color = "Sub_metering_3")) + 
  scale_color_manual(values = c("Sub_metering_1" = "black", "Sub_metering_2" = "red", 
                                                   "Sub_metering_3" = "blue")) +
  scale_x_datetime(date_breaks = "1 day",
                   date_labels = "%a") +
  ylab("Energy sub metering") +
  xlab("") +
  theme(panel.border = element_rect(fill = "transparent", color = 1, size = 1)) +
  theme(legend.justification = c(1.01, 1.01), legend.position = c(1, 1), 
        legend.box.background = element_rect(color="black"), 
        legend.box.margin = margin(t = 1, l = 1), legend.title = element_blank())
dev.off()


