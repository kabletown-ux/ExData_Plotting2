debug <- TRUE
png <- TRUE
NEI <- NULL
SCC <- NULL
baltimore <- NULL
losangeles <- NULL
large <- TRUE

loadData <- function() {
    
    # Conditional data loading: Pull from file...
    if ( is.null( NEI) ) { 
        
        # Conditional dataset size: full, refreshed, data sets...
        if ( large ) {
            
            if ( debug ) print( "Using BIG-ASSED versions of NEI, losangeles and baltimore..." )
            NEI <<- readRDS( "../data/summarySCC_PM25.rds" )
            SCC <<- readRDS( "../data/Source_Classification_Code.rds" )
            baltimore <<- NEI[ NEI$fips == "24510", ]
            losangeles <<- NEI[ NEI$fips == "06037", ]
            
        } else { # ...or smaller samples
            
            if ( debug ) print( "Using TOY versions of NEI, losangeles and baltimore..." )
            NEI <<- read.csv( "../data/neiSample.csv" )
            SCC <<- readRDS( "../data/Source_Classification_Code.rds" )
            baltimore <<- read.csv( "../data/baltimore.csv" )
            losangeles <<- read.csv( "../data/losangeles.csv" )
        }
    
    } else { # or use cached copy
        
        if ( debug ) print( "Using cached versions of NEI, losangeles and baltimore..." )
    }
}
sampleData <- function() {
    
    loadData()
    set.seed( 2112 )
    ## grab 5000 random rows
    neiSample <<- NEI[ sample( nrow( NEI ), size = 250000, replace = F ), ]
    
    write.csv( neiSample, file = "../data/neiSample.csv" )
    write.csv( baltimore, file = "../data/baltimore.csv" )
    write.csv( losangeles, file = "../data/losangeles.csv" )
}