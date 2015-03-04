## I am assuming that you are in a direction with the household consumption
## data file in place

## dataset starts on 12/16/2006 we want 2/1/2007 and 2/2/2007, so lets create a 
## start index that will skip a lot of the early dates (should start midday on
## january 31st 2007)

start <- (31-16 + 31) *24*60

## create a # of rows value of three days so we will grab slightly more than
## all the data we want to use
rowstograb <- 3*24*60

## grab the names from the table since using a header with a skip value leads
## to odd results
headerinfo <- read.table('household_power_consumption.txt',
                         header=TRUE,sep=';',
                         nrows=1)
## grab the data we want
household <- read.table('household_power_consumption.txt',
                        header=TRUE,sep=';',
                        skip=start,
                        nrows=rowstograb,
                        na.strings = '?')

## rename the colums so they match the header in the file
names(household) <- names(headerinfo)

## get the first and last indices needed to only have the data we want
firstind <- match('1/2/2007',household$Date)
lastind <- match('3/2/2007',household$Date)-1L
## pair down the data to exactly what we want
household <- household[firstind:lastind,]

png(file = 'plot1.png',
    width = 480,
    height = 480,
    bg = 'transparent')
## make the first plot
hist(household$Global_active_power,
     col="red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.off()
