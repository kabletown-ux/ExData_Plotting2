source( "load-data.R" )

## Question 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
doPlot1 <- function() {
    
    loadData()
    ## mean or sum?
    emmissionsAggregate <- aggregate( Emissions ~ year, NEI, sum )
    
    # Open png device
    if ( png ) png( filename = "plot1.png" )
    
    barplot( height    = emmissionsAggregate$Emissions, 
             names.arg = emmissionsAggregate$year,
             xlab      = "years", 
             ylab      = "PM2.5 emissions (tons)",
             main      = "PM2.5 emissions across years" ) 
    
    # Turn off device
    if ( png ) dev.off()
}
