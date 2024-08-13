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

# STEP SIX: CREATE PLOT 4
# http://www.sthda.com/english/articles/24-ggpubr-publication-ready-plots/81-ggplot2-easy-way-to-mix-multiple-graphs-on-the-same-page/
# TITLE:  NONE
# 4 plots, 2 of which were created before

library(ggplot2)

# First plot goes in upper left corner
# Same as plot 2 with a small change to Y axis label, remove units
# remove box around Legend
# Save the plot as an object (UL)

UL <- ggplot(data2, aes(x = DateTime2, y= Global_active_power)) +
  geom_line() + 
  scale_x_datetime(date_breaks = "1 day",
                   date_labels = "%a") +
  ylab("Global Active Power") +
  xlab("") +
  theme(panel.border = element_rect(fill = "transparent", color = 1, size = 1))

# Second plot goes in lower left corner
# Same as plot 3 
# Save the plot as an object (LL)


LL <- ggplot(data2, aes(x = DateTime2)) +
  geom_line(aes(y=Sub_metering_1, color = "Sub_metering_1")) + 
  geom_line(aes(y=Sub_metering_2, color = "Sub_metering_2")) + 
  geom_line(aes(y=Sub_metering_3, color = "Sub_metering_3")) + 
  scale_color_manual(name = "", values = c("Sub_metering_1" = "black", "Sub_metering_2" = "red", 
                                                   "Sub_metering_3" = "blue")) +
  scale_x_datetime(date_breaks = "1 day",
                   date_labels = "%a") +
  ylab("Energy sub metering") +
  xlab("") +
  theme(panel.border = element_rect(fill = "transparent", color = 1, size = 1)) +
  theme(legend.justification = c(1.05, 1.05), legend.position = c(1, 1), 
        legend.box.margin = margin(t = 1, l = 1), legend.title = element_blank())

# Third plot goes in upper right corner
# Same as upper left but with different y and x axis label
# save the plot as object (UR)
# need to change default y axis scale and add minor ticks
# https://stackoverflow.com/questions/14490071/adding-minor-tick-marks-to-the-x-axis-in-ggplot2-with-no-labels

UR <- ggplot(data2, aes(x = DateTime2, y= Voltage)) +
  geom_line() + 
  scale_x_datetime(date_breaks = "1 day",
                   date_labels = "%a") +
  ylab("Voltage") +
  xlab("datetime") +
  theme(panel.border = element_rect(fill = "transparent", color = 1, size = 1)) +
  scale_y_continuous(
    limits = c(234, 246), 
    minor_breaks = seq(234, 246, by=2), 
    breaks = seq(234, 246 , by=4),
    guide = guide_axis(minor.ticks = TRUE))

  #scale_y_continuous(limits = c(234, 246), breaks = seq(234, 246 , 4))
                  

# Third plot goes in upper right corner
# Same as upper left but with different y and x axis label
# save the plot as object (LR)

LR <- ggplot(data2, aes(x = DateTime2, y= Global_reactive_power)) +
  geom_line() + 
  scale_x_datetime(date_breaks = "1 day",
                   date_labels = "%a") +
  ylab("Global_reactive_power") +
  xlab("datetime") +
  theme(panel.border = element_rect(fill = "transparent", color = 1, size = 1))

# Now we need to combine all 4 objects created above
#install.packages("ggpubr")

library(ggpubr)

png(file="Plot4.png", width = 480, height = 480)
ggarrange(UL, UR, LL, LR, 
          ncol = 2, nrow = 2)
dev.off()

# ggsave(filename = "plot4.png", plot = last_plot())
# prefer to use the png() combo with dev.off()
