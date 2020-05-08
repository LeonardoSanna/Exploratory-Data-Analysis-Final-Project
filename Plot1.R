library(dplyr)
library(ggplot2)

#download file and unzip file
data_source <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
file <- "exploratory-final.zip"
download.file(data_source, destfile = file)
dataset <- unzip(file)

summary <- readRDS("summarySCC_PM25.rds")



#question 1 

emissions_year <- summary %>% 
        group_by(year) %>%
        summarize(tot_em = sum(Emissions, na.rm = TRUE))

barplot(height=emissions_year$tot_em/1000, 
        names.arg= emissions_year$year,
        ylab = "Annual Emissions [Tons*1000]", 
        xlab = "Year",
        main = " USA Annual Emissions by year",
        col = c("red", "orange", "yellow", "green"))

dev.copy(png,'plot1.png')
dev.off()
