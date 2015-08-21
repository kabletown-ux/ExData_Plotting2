source( "load-data.R" )

library( ggplot2 )

doPlot3 <- function() {
    
    loadData()
    
    # step 1: subset source (autos)
    # step 2: rbind balmer & la
    
    # Open png device
    if ( png ) png( filename = "plot6.png" )
    
    # plot
    
    # Turn off device
    if ( png ) dev.off()
}
