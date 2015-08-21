source( "load-data.R" )

library( ggplot2 )

doPlot3 <- function() {
    
    loadData()
    
    ## Was going to do separate aggregates, when I realized that using "Emissions ~ year + type" got me the same result, and more easily
    
    ## mean or sum?
    ##point    <- baltimore[ baltimore$type == "POINT", ]
    ##nonpoint <- baltimore[ baltimore$type == "NONPOINT", ]
    ##onroad   <- baltimore[ baltimore$type == "ON-ROAD", ]
    ##nonroad  <- baltimore[ baltimore$type == "NON-ROAD", ]
    ##pointAggregate    <- aggregate( Emissions ~ year, point, mean )
    ##nonpointAggregate <- aggregate( Emissions ~ year, nonpoint, mean )
    ##onroadAggregate   <- aggregate( Emissions ~ year, onroad, mean )
    
    ## Much simpler!
    baltimoreAggregate <- aggregate( Emissions ~ year + type, baltimore, mean )
    if ( debug ) print( baltimoreAggregate )
    
    # Open png device
    if ( png ) png( filename = "plot3.png" )
    
    newPlot <- ggplot( data = baltimoreAggregate, aes( x = year, y = Emissions, group = type, colour = type ) ) + 
               geom_line() + 
               geom_point() + 
               xlab( "Year" ) + 
               ylab( "Total Emissions (tons)" ) + 
               ggtitle( "Total PM2.5 emissions for Baltimore\nYears 1999–2008" )
    
    print( newPlot )
    
    # Turn off device
    if ( png ) dev.off()
}
