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


#alternative (by another work on coursera)
baltcitymary.emissions.byyear<-summarise(group_by(filter(NEI, fips == "24510"), year,type), Emissions=sum(Emissions))
clrs <- c("red", "green", "blue", "yellow")
ggplot(baltcitymary.emissions.byyear, aes(x=factor(year), y=Emissions, fill=type,label = round(Emissions,2))) +
        geom_bar(stat="identity") +
        #geom_bar(position = 'dodge')+
        facet_grid(. ~ type) +
        xlab("year") +
        ylab(expression("total PM"[2.5]*" emission in tons")) +
        ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                           "City by various source types", sep="")))+
        geom_label(aes(fill = type), colour = "white", fontface = "bold")
png(filename = "plot1.png", width = 1200, height = 793, units = "px")
