plot3 <- function(file.dir = "household_power_consumption.txt", data = NULL) {
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
  ## Draw histgraph
  png("plot3.png", width = 480, height= 480)
  ## Draw the black line of sub_metering_1
  with(data, plot(DateTime, Sub_metering_1, type = "l",
       xlab = "", ylab = "Energy sub metering"))
  ## Draw the red line of sub_metering_2
  with(data, lines(DateTime, Sub_metering_2, col = "red"))
  ## Draw the blue line of sub_metering_3
  with(data, lines(DateTime, Sub_metering_3, col = "blue"))
  ## Add legend
  legend("topright", legend = paste("Sub_metering_", 1:3, sep = ""), lwd = 1,
         col = c("black", "red", "blue"))
  rm(data)
  dev.off()
  print("-->Finish")
}
