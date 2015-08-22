source( "load-data.R" )

library( ggplot2 )

## Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California
doPlot6 <- function() {
    
    loadData()
    
    balmorEmissions <- NEI[ baltimore$type == "ON-ROAD", ]
    laEmissions <- NEI[ losangeles$type == "ON-ROAD", ]
    
    balmorEmissionsAggregate <- aggregate( Emissions ~ year, data = balmorEmissions, FUN = sum )
    # add location column/name
    city <- c( "Baltimore" );
    balmorEmissionsAggregate$city <- city
    #if ( debug ) print( balmorEmissionsAggregate )
    
    laEmissionsAggregate <- aggregate( Emissions ~ year, data = laEmissions, FUN = sum )
    # add location column/name
    city <- c( "Los Angeles" );
    laEmissionsAggregate$city <- city
    #if ( debug ) print( laEmissionsAggregate )
    
    bothCitiesAggregate <- rbind( balmorEmissionsAggregate, laEmissionsAggregate )
    if ( debug ) print( bothCitiesAggregate )
    
    # Open png device
    if ( png ) png( filename = "plot6.png" )
    
    # plot
    # TODO: Check accuracy in labels/units!
    newPlot <- ggplot( data = bothCitiesAggregate, aes( x = year, y = Emissions, group = city, colour = city ) ) + 
    geom_line() + 
    geom_point() + 
    xlab( "Year" ) + 
    ylab( "Total Emissions (tons)" ) + 
    ggtitle( "PM2.5 Motor Vehicle Emissions from 1999-2008\nBaltimore vs. Los Angeles" )

    print( newPlot )
    
    # Turn off device
    if ( png ) dev.off()
}
