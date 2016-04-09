## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 

## My dir for this assignment
setwd("~/Coursera/DS Repo/EDAProject2/")

## We will use data tables for easy sum calculations
library(data.table)

## Read in data as a data table
emData <- data.table( readRDS("summarySCC_PM25.rds") )
mySCC <- data.table( readRDS("Source_Classification_Code.rds") )

## We want motor vehicle emitions for baltimore (fips 24510)
## All motor vehicles are listed as type ON-ROAD
emSums <- emData[ (type=="ON-ROAD" & fips=="24510"), list(sum=sum(Emissions)),by=year]

library(ggplot2)
## Simple plot with fit line
g <- ggplot(data=emSums, aes(year, sum)) +
      geom_point(size=4, colour='red', alpha=.6) +
      geom_smooth(method='lm') +
      labs(x='Year', y='Total Emissions', title='Total Motor Vehicle Emissions in Baltimore City') 

## Saving plot
ggsave("plot5.png", plot=g, width=6.7, height=6.7, dpi=75)