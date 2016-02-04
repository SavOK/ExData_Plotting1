
require(lubridate)

work_dir <- "~/Coursera/DataScience/Part4/week1/ExData_Plotting1/"
setwd(work_dir)
url_data <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download.file(url=url_data, destfile="household_power_consumption.zip", method="curl")
#dateDownloaded <- date()
#unzip(zipfile="household_power_consumption.zip", list=F)

read_dataCache <- function(file=character()) {
    D.F <- NULL
    set <- function(y) {
        file <<- y
        D.F <<- NULL
    }
    get <- function() {
        file
    }
    set_df <- function(df) {
        D.F <<- df
    }
    get_df <- function() {
        D.F
    }
    return (list (set=set, 
                  get=get, 
                  set_df=set_df, 
                  get_df=get_df))
}

cacheData <- function(x, ...) {
    D.F <- x$get_df()
    if(!is.null(D.F)) {
        #    message("getting cached data")
        return(D.F)
    }
    data <- x$get()
    D.F <- get_data_helper(File=data,  ...)
    x$set_df(D.F)
    return(D.F)
}

# little help function reads input data
#only work with initial uncleaned data
# date interval in %Y-%d-%m format
get_data_helper <- function(File, from="2007-02=01", to="2007-02-02") {
    Data <- read.table(file=File,header=T, sep=c(';'), 
                       colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric",
                                    "numeric", "numeric", "numeric"), na.strings=c('?', "NA", ""))
    Data$DateAndTime <- as.POSIXct(
                                   strptime(paste(Data$Date, Data$Time, " "), "%d/%m/%Y %H:%M:%S"))
    Data$Date <- dmy(Data$Date)
    Data$Time <- hms(Data$Time) 
    date_range <- interval(ymd(from), ymd(to))
    Data <- Data[Data$Date %within% date_range,] 
    return (Data)
}

working_file <- "./household_power_consumption.txt" 

DataCache <- read_dataCache(working_file)
Data <- cacheData(DataCache)

#Prepare data for plot 1
G.A.P <- Data$Global_active_power[!is.na(Data$Global_active_power)]
#plot plot1
png("./plot1.png", 
    width = 480, height = 480, units = "px", pointsize = 12)
hist(x=G.A.P, xlab="Global Active Power (kilowatts)", 
     main="Global Active Power", col="red")
dev.off()
