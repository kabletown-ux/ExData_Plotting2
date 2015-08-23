source( "load-data.R" )

## Question 2: Have total emissions from PM2.5 decreased in the Baltimore City
doPlot2 <- function() {
    
    loadData()
    ## mean or sum?
    emmissionsAggregate <- aggregate( Emissions ~ year, baltimore, sum )
    
    # Open png device
    if ( png ) png( filename = "plot2.png" )
    
    barplot( height    = emmissionsAggregate$Emissions, 
             names.arg = emmissionsAggregate$year,
             xlab      = "years", 
             ylab      = "PM2.5 emissions (tons)",
             main      = "Baltimore PM2.5 emissions" ) 
    
    # Turn off device
    if ( png ) dev.off()
}
