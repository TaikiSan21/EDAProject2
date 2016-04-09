## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
## plot answering this question.

## My dir for this assignment
setwd("~/Coursera/DS Repo/EDAProject2/")

## We will use data tables for easy sum calculations
library(data.table)

## Read in data as a data table
emData <- data.table( readRDS("summarySCC_PM25.rds") )

## Calculate sums for only fips=="24510" grouping by year
emSums<- emData[fips=="24510", list(sum=sum(Emissions)), by=year]

png("plot2.png", width=504, height=504)

## Bar plot shows emissions by year
barplot(emSums$sum, names.arg=emSums$year, xlab='Year', ylab='Total Emissions', main='Total Emissions for Baltimore City')

dev.off()

