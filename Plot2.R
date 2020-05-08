library(dplyr)
library(ggplot2)

#download file and unzip file
data_source <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
file <- "exploratory-final.zip"
download.file(data_source, destfile = file)
dataset <- unzip(file)

summary <- readRDS("summarySCC_PM25.rds")


#question 2

emissions_baltimore <- summary %>% 
        group_by(year) %>%
        filter(fips=="24510")  %>%
        summarize(tot_em = sum(Emissions, na.rm = TRUE))


with(emissions_baltimore, 
     plot(x = year, 
          y = tot_em, 
          type = "l",
          ylab = "Annual Emissions [Tons]", 
          xlab = "Year",
          main = " Baltimore Annual Emissions 1999-2008",
          lwd = 3,
          col = "blue"))

dev.copy(png, "plot2.png")
dev.off()