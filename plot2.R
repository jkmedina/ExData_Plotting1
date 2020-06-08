plot2 <- function(file.dir = "household_power_consumption.txt", data = NULL) {
  print("-->Retrieving data...")
  ## Read data
  if(is.null(data)) {
    data <- read.table(file.dir, na.strings = "?", sep = ";", header = TRUE,
                       colClasses = c(rep("character", times = 2),
                                      rep("numeric", times = 7)))
    ## Transform and filter data
    data <- transform(data, Date = as.Date(Date, format = "%d/%m/%Y"))
    data <- subset(data, Date %in% c(as.Date("2007-02-01"),
                                     as.Date("2007-02-02")))
  }
  ## Add new Data & Time feature
  data$DateTime <- paste(data$Date, data$Time)
  data <- transform(data, DateTime = as.POSIXct(DateTime,
                                                format = "%Y-%m-%d %H:%M:%S"))
  print("-->Drawing graph...")
  ## draw histgraph
  png("plot2.png", width = 480, height= 480)
  with(data, plot(DateTime, Global_active_power, type = "l",
                  xlab = "", ylab = "Global Active Power (kilowatts)"))
  rm(data)
  dev.off()
  print("-->Finish")
}
