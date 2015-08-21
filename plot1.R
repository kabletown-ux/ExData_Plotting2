source( "load-data.R" )

doPlot1 <- function() {
    
    loadData()
    ## mean or sum?
    emmissionsAggregate <- aggregate( Emissions ~ year, NEI, mean )
    
    # Open png device
    if ( png ) png( filename = "plot1.png" )
    
    #hist complains about x needing to be numeric.  Wuh?
    #hist( emmissionsAggregate )
    barplot( height    = emmissionsAggregate$Emissions, 
             names.arg = emmissionsAggregate$year,
             xlab      = "years", 
             ylab      = "PM2.5 emissions",
             main      = "PM2.5 emissions across years" ) 
    
    # Turn off device
    if ( png ) dev.off()
}
