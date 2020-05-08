library(dplyr)
library(ggplot2)

#download file and unzip file
data_source <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
file <- "exploratory-final.zip"
download.file(data_source, destfile = file)
dataset <- unzip(file)

source <- readRDS("Source_Classification_Code.rds")
summary <- readRDS("summarySCC_PM25.rds")

#question 4

source_coal <- source %>%
        filter(grepl("coal", EI.Sector, ignore.case=TRUE)) %>%
        select(SCC)


coal_by_year <- summary %>%
        filter(SCC %in% source_coal$SCC) %>%
        group_by(year) %>%
        summarize(tot_em = sum(Emissions))


ggplot(coal_by_year, aes(x=year, y=tot_em/1000)) + 
        geom_bar(stat="identity",  fill = "#660000") + 
        labs(x="Year", y="PM2.5 Emissions (Tons*1000)") + 
        ggtitle("USA PM2.5 Emissions from Coal  Sources")



dev.copy(png, "plot4.png")
dev.off()
