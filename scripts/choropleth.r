# Library necessary packages
library(plotly)
library(dplyr)

# This script will make a choropleth map of the United States that displays the average covered charges divided by the average total payments
MakeStateChoropleth <- function(data, type){
  
  # This sets the graphics for the map
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white')
  )
  
  # This is the text that will show up when the user hovers over the state
  text <- paste(data$Provider.State, 
                paste0("Average Coverage ", round(data[, eval(quote(type))], 2), "%"),
                sep = "</br>")
  #Margin
  m <- list(
    l = 50,
    r = 50,
    b = 100,
    t = 100,
    pad = 4
  )
  
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
    colorbar(title = "Percentage of<br>Average Covered<br>Charges") %>%
    
    # This will make the title and use the graphics to make the map
    layout(
      title = 'Average Percentage of Coverage by State<br>(Hover for breakdown)',
      geo = g,
      hovermode = "closest"
    ) %>% 
    layout(autosize = T, width = 700, height = 600, margin = m)
  
}