library(dplyr)
library(ggplot2)

#download file and unzip file
data_source <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
file <- "exploratory-final.zip"
download.file(data_source, destfile = file)
dataset <- unzip(file)

summary <- readRDS("summarySCC_PM25.rds")


#question 5

em_road_baltimore <- summary %>% 
        filter(fips=="24510" & type =="ON-ROAD")%>%
        group_by(year) %>%
        summarize(tot_em = sum(Emissions, na.rm = TRUE))

with(em_road_baltimore, 
     plot(x = year, 
          y = tot_em, 
          type = "l",
          ylab = "Annual Emissions [Tons]", 
          xlab = "Year",
          main = " Baltimore Annual Vehicles Emissions 1999-2008",
          lwd = 3,
          col = "blue"))

dev.copy(png, "plot5.png")
dev.off()