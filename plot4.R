source( "load-data.R" )

library( ggplot2 )

## Question 4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
doPlot4 <- function() {
  
    loadData()
    
    ## hit all fields w/ one regex, instead of merging multiple grepl queries
    matcher <- '([Cc]oal.*[Cc]omb)|([Cc]omb.*[Cc]oal)'
    coalOrCombustionRelated <- grepl( matcher, SCC$Short.Name ) | grepl( matcher, SCC$EI.Sector ) | grepl( matcher, SCC$SCC.Level.Four )
    
    ## using as.character(...) drops excess factors, most of the 11,717 values
    sccCodes <- as.character( SCC[ coalOrCombustionRelated, 'SCC' ] )
    coalEmissions <- NEI[ NEI$SCC %in% sccCodes, ]
    coalEmissionsAggregate <- aggregate( Emissions ~ year, coalEmissions, sum )
    
    if ( debug ) print( coalEmissionsAggregate )
    
    # Open png device
    if ( png ) png( filename = "plot4.png" )
    
    # TODO: Check accuracy in labels/units!
    ggp <- ggplot( coalEmissionsAggregate, aes( factor( year ), Emissions ) ) + #/10^5 ) ) +
        geom_bar( stat = "identity", fill = "grey", width = 0.875 ) +
        theme_classic() +
        #theme_bw() +  guides( fill = FALSE ) +
        labs( x = "year", y = "Total PM2.5 Emission (tons)" ) + 
        labs( title = "PM2.5 Coal Combustion Emissions Across US from 1999-2008")
 
    print( ggp )
  
  # Turn off device
  if ( png ) dev.off()
}