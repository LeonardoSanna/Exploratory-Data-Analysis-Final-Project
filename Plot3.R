library(dplyr)
library(ggplot2)

#download file and unzip file
data_source <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
file <- "exploratory-final.zip"
download.file(data_source, destfile = file)
dataset <- unzip(file)

summary <- readRDS("summarySCC_PM25.rds")


#question 3

em_types_baltimore <- summary %>% 
        group_by(year, type) %>%
        filter(fips=="24510")  %>%
        summarize(tot_em = sum(Emissions, na.rm = TRUE))


ggplot(data = em_types_baltimore, 
                               aes(year, tot_em)) + 
        geom_line(color = "blue", 
                  size = 1.5) + 
        facet_grid(. ~ type) +
        xlab("Year") +
        ylab("Total Emissions [Tons]") +
        ggtitle("Types of Annual Emissions in Baltimore by Year")


dev.copy(png, "plot3.png")
dev.off()
