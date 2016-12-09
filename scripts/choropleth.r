# Library necessary packages
library(plotly)
library(dplyr)
library(choroplethr)

# This script will make a choropleth map of the United States that displays the average covered charges divided by the average total payments
makeStateChoropleth <- function(data, type){
  # This sets the graphics for the map
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white')
  )
  
  text <- paste(data$Provider.State, 
                paste0("Average Coverage ", round(data[, eval(quote(type))], 2), "%"),
                sep = "</br>")
  
  # This is what puts in the data for the choropleth map
  plot_geo(data, locationmode = 'USA-states') %>%
    add_trace(
      text = text,
      z = ~eval(parse(text = type)), 
      hoverinfo = "text", 
      locations = ~Provider.State,
      color = ~eval(parse(text = type)), 
      colors = "Greens"
    ) %>%
    
    # This will make the colorbar on the right of the map
    colorbar(title = "Percentage of<br>Average Covered Charges") %>%
    
    # This will make the title and use the graphics to make the map
    layout(
      title = 'Ratio of Average Covered Medical Charges to Average Total Payments by State<br>(Hover for breakdown)',
      geo = g,
      hovermode = "closest"
    )
}