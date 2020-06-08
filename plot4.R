plot4 <- function(file.dir = "household_power_consumption.txt", data = NULL) {
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
  png("plot4.png", width = 480, height= 480)
  par(mfrow = c(2, 2))
  ## Draw the topleft graph
  with(data, plot(DateTime, Global_active_power, type = "l",
                  xlab = "", ylab = "Global Active Power"))
  ## Draw the topright graph
  with(data, plot(DateTime, Voltage, type = "l",
                  xlab = "datetime", ylab = "Voltage"))
  ## Draw the bottomleft graph
  with(data, plot(DateTime, Sub_metering_1, type = "l",
                  xlab = "", ylab = "Energy sub metering"))
  with(data, lines(DateTime, Sub_metering_2, col = "red"))
  with(data, lines(DateTime, Sub_metering_3, col = "blue"))
  legend("topright", legend = paste("Sub_metering_", 1:3, sep = ""), lwd = 1,
         col = c("black", "red", "blue"), bty = "n")
  ## Draw the bottomright graph
  with(data, plot(DateTime, Global_reactive_power, type = "l",
                  xlab = "datetime"))
  rm(data)
  dev.off()
  par(mfrow = c(1, 1))
  print("-->Finish")
}
