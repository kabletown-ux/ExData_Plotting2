source( "load-data.R" )

library( ggplot2 )

## Question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
doPlot5 <- function() {
  
    loadData()
    
    # Get Baltimore emissions from motor vehicle sources
    balmorEmissions <- NEI[ (NEI$fips=="24510" ) & ( NEI$type=="ON-ROAD") , ]
    # sum or avg?
    balmorEmissionsAggregate <- aggregate( Emissions ~ year, data = balmorEmissions, FUN = sum )
    
    if ( debug ) print( balmorEmissionsAggregate )
    
    # Open png device
    if ( png ) png( filename = "plot5.png" )
    
    # TODO: Check accuracy in labels/units!
    ggp <- ggplot( balmorEmissionsAggregate, aes( factor( year ), Emissions ) ) + #/10^5 ) ) +
        geom_bar( stat = "identity", fill = "grey", width = 0.875 ) +
        theme_classic() +
        #theme_bw() +  guides( fill = FALSE ) +
        labs( x = "year", y = "Total PM2.5 Emission (Units?)" ) + 
        labs( title = "PM2.5 Motor Vehicle Emissions from 1999-2008" )
 
     print( ggp )
  
  # Turn off device
  if ( png ) dev.off()
}