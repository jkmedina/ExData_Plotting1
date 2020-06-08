## A function used to draw a histgraph of global active power
plot1 <- function(file.dir = "household_power_consumption.txt", data = NULL) {
  print("-->Retrieving data...")
  ## Read data
  if(is.null(data)) {
    data <- read.table(file.dir, na.strings = "?", sep = ";", header = TRUE,
                       colClasses = c(rep("character", times = 2),
                                      rep("numeric", times = 7)))
    ## Transform and filter data
    data <- transform(data, Date = as.Date(Date, format = "%d/%m/%Y"))
    data <- subset(data, Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02")))
  }
  print("-->Drawing graph...")
  ## draw histgraph
  png("plot1.png", width = 480, height= 480)
  hist(data$Global_active_power, col = "red",
       xlab = "Global Active Power (kilowatts)",
       main = "Global Active Power")
  rm(data)
  dev.off()
  print("-->Finish")
}
