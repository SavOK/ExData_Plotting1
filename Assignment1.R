
work_dir <- "~/Coursera/DataScience/Part4/week1/ExData_Plotting1/"
setwd(work_dir)
url_data <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url=url_data, destfile="household_power_consumption.zip", method="curl")
dateDownloaded <- date()
