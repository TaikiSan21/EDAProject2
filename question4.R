## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

## My dir for this assignment
setwd("~/Coursera/DS Repo/EDAProject2/")

## We will use data tables for easy sum calculations
library(data.table)

## Read in data as a data table
emData <- data.table( readRDS("summarySCC_PM25.rds") )
mySCC <- data.table( readRDS("Source_Classification_Code.rds") )

## Coal combustion sector tags are: Fuel Comb - Electric Generation - Coal,
## Fuel Comb - Industrial Boilers, ICEs - Coal,
## Fuel Comb - Comm/Institutional - Coal in EI.Sector
## We save these names in a vector

coalVect <- c("Fuel Comb - Electric Generation - Coal",
              "Fuel Comb - Industrial Boilers, ICEs - Coal",
              "Fuel Comb - Comm/Institutional - Coal in EI.Sector")

## and then use them to get the SCC id for every coal combustion entry
coalID <- mySCC[EI.Sector %in% coalVect, SCC]

## and then sum the emissions over those SCC ids
coalSums <- emData[SCC %in% coalID, list(sum=sum(Emissions)), by=year]

library(ggplot2)
## Simple plot with fit line
g <- ggplot(data=coalSums, aes(year, sum)) +
      geom_point(size=4, colour='red', alpha=.6) +
      geom_smooth(method='lm') +
      labs(x='Year',y='Total Emissions', title='Total Emissions for Coal Combustion Sources') +
      coord_cartesian(ylim=c(0,900000))

## Saving plot
ggsave("plot4.png", plot=g, width=6.7, height=6.7, dpi=75)


      