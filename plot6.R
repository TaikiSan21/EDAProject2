## Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (fips == "06037").
## Which city has seen greater changes over time in motor vehicle emissions?

## My dir for this assignment
setwd("~/Coursera/DS Repo/EDAProject2/")

## We will use data tables for easy sum calculations
library(data.table)

## Read in data as a data table
emData <- data.table( readRDS("summarySCC_PM25.rds") )
mySCC <- data.table( readRDS("Source_Classification_Code.rds") )

## fips 24510 is Baltimore, 06037 is LA
## All motor vehicles listed under type ON-ROAD
## We want the sums split by both year and location
emSums <- emData[ (type=="ON-ROAD" & fips %in% c("24510", "06037")), list(sum=sum(Emissions)),by=.(fips,year)]

## To show the change in emissions we create a new column normsums
## normsums is the percentage change from the first year (1999)
emSums <- emSums[, normsums := sum/sum[1] -1, by=fips]

## We make a new factor column fips factor with names Baltimore and Los Angeles
## so that the labels in the plot will make sense
emSums <- emSums[, fipsfact := factor(fips, levels=c("06037", "24510"), labels=c("Los Angeles", "Baltimore"))]

library(ggplot2)
## Plot the graph separating by location
g <- ggplot(emSums, aes(year, normsums)) +
      geom_point(size=4, colour='darkgreen', alpha=.7) +
      facet_wrap(~fipsfact) +
      geom_smooth(method='lm', se=FALSE) +
      labs(x='Year', y='Percentage Change from 1999',title='Percent Change in Motor Vehicle Emissions for Baltimore and LA')

## Save the plot, width/height is set so side by side graphs look nicer
ggsave(filename="plot6.png", width=13.4, height=6.7, units="in", dpi=75)
