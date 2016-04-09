## Creating plot for question 1

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from 
## all sources for each of the years 1999, 2002, 2005, and 2008.

## My dir for this assignment
setwd("~/Coursera/DS Repo/EDAProject2/")

## We will use data tables for easy sum calculations
library(data.table)

## Read in data as a data table
emData <- data.table( readRDS("summarySCC_PM25.rds") )

## Get the sum of emissions grouped by year
emSums <- emData[, list(sum=sum(Emissions)), by=year]

png("plot1.png",width=504, height=504)

## Bar plot shows the total emissions for each year
barplot( emSums$sum, names.arg=emSums$year, 
         ylab="Total Emissions", xlab="Year", main="Total Emissions for US")

dev.off()



