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

# STEP SIX: CREATE PLOT 2
# GLOBAL ACTIVE POWER, Hourly, line graph
# TITLE:  NONE
# Y axis label "Global Active Power (kilowatts)"
# x axis label by day
# Y axis range 0 - 6
# X axis range Thu, Fri, Sat
# no symbol, just line

library(ggplot2)

png(file="Plot2.png",width = 480, height = 480)
ggplot(data2, aes(x = DateTime2, y= Global_active_power)) +
  geom_line() + 
  scale_x_datetime(date_breaks = "1 day",
                   date_labels = "%a") +
  ylab("Global Active Power (kilowatts)") +
  xlab("") +
  theme(panel.border = element_rect(fill = "transparent", color = 1, size = 1))
dev.off()
