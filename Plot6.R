library(dplyr)
library(ggplot2)

#download file and unzip file
data_source <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
file <- "exploratory-final.zip"
download.file(data_source, destfile = file)
dataset <- unzip(file)

summary <- readRDS("summarySCC_PM25.r")

#question 6
baltimore_and_LA <- summary %>%
        filter(fips %in% c("24510", "06037") & type == "ON-ROAD") %>%
        mutate(fips = factor(fips, levels = c("06037", "24510"), 
                             labels=c("Los Angeles County", "Baltimore City"))) %>%
        group_by(year, fips) %>%
        summarize(tot_em = sum(Emissions,na.rm = TRUE))

ggplot(baltimore_and_LA, aes(x=year, y=tot_em)) + 
        geom_bar(stat="identity", aes(fill=fips), position = "dodge") +
        guides(fill=guide_legend(title=NULL)) +
        labs(x="Year", y="Total Emissions (tons)") +
        ggtitle("Vehicle Emissions: Baltimore City vs LA County") +
        theme(legend.position="bottom")

dev.copy(png, "plot6.png")
dev.off()
