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

# STEP TWO:
# Convert Date to Date class from character
# instructions propose to use as.Date() function
  
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# STEP THREE:
# Convert time to time class 
# instructions suggest to use strptime()
# Don't need time for now?

# STEP FOUR:
# Select date range to use ie. 2007-02-01 and 2007-02-02

data2 <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]


# STEP FOUR: CREATE PLOT 1, HISTOGRAM
# GLOBAL ACTIVE POWER, FREQUENCY, BINS AT 0.5 INTERVALS, 0 TO 6
# TITLE "Global Active Power"
# X axis label "Global Active Power (kilowatts)"
# Y axis label "Frequency"
# Y axis range 0 - 1200

png(file="Plot1.png", width = 480, height = 480 )
hist(data2$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()



