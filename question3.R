## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
## variable, which of these four sources have seen decreases in emissions from 1999–2008 
## for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2
## plotting system to make a plot answer this question.

## My dir for this assignment
setwd("~/Coursera/DS Repo/EDAProject2/")

## We will use data tables for easy sum calculations
library(data.table)

## Read in data as a data table
emData <- data.table( readRDS("summarySCC_PM25.rds") )

## We want the sums broken up by both year and by the type
emSums <- emData[fips=="24510", list(sum=sum(Emissions)), by=list(year, type)]

## We will use ggplot2
library(ggplot2)

## Break up the graphs by type and graph with a fit line
g<- ggplot(data=emSums, aes(year, sum)) +
      geom_point(size=4, colour="red", alpha=.6) + 
      facet_wrap(~type, nrow=2, ncol=2, scales='free_y') + 
      geom_smooth(method="lm") +
      labs(x='Year', y='Total Emissions (note: scale different for each graph)', 
           title='Emissions for different types by year') 

## Saving plot
ggsave(filename="plot3.png", width=6.7, height=6.7, dpi=75)


