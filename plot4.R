source( "load-data.R" )

library( ggplot2 )

## Question: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
doPlot4 <- function() {
  
  loadData()
  
  ## *love* this idea: hit all fields w/ one regex, instead of merging multiple grepl queries
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
         labs( x = "year", y = "Total PM2.5 Emission (Units?)" ) + 
         labs( title = "PM2.5 Coal Combustion Emissions Across US from 1999-2008")
 
 print( ggp )
 
#   ggp <- ggplot( coalEmissionsAggregate, aes( x = factor(year), y=Emissions)) +
#     geom_bar(stat="identity") +
#     xlab("year") +
#     ylab(expression("total PM"[2.5]*" emissions")) +
#     ggtitle("Emissions from coal combustion-related sources")
#  
#  print( ggp )

# BORING!
#    plot( coalEmissionsAggregate, type = "l", xlab = "Year", main = "Total Emissions From Coal Combustion-related\n Sources from 1999 to 2008", ylab = "Total PM2.5 Emission" )

  
  # Turn off device
  if ( png ) dev.off()
}