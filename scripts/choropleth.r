# Library necessary packages
library(plotly)
library(dplyr)
library(choroplethr)

# This script will make a choropleth map of the United States that displays the average covered charges divided by the average total payments
makeStateChoropleth <- function(data){
  # This sets the graphics for the map
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white')
  )
  
  # This is what puts in the data for the choropleth map
  plot_geo(data, locationmode = 'USA-states') %>%
    add_trace(
      z = ~State.Covered.Charges, 
      text = ~round(State.Covered.Charges, 2), 
      locations = ~Provider.State,
      color = ~State.Covered.Charges, 
      colors = 'Purples'
    ) %>%
    
    # This will make the colorbar on the right of the map
    colorbar(title = "Average Covered Charges / Average Total Payments") %>%
    
    # This will make the title and use the graphics to make the map
    layout(
      title = 'Ratio of Average Covered Medical Charges to Average Total Payments by State<br>(Hover for breakdown)',
      geo = g
    )
}