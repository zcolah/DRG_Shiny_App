library(plotly)
library(dplyr)
makeStateChoropleth <- function(data){
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white')
  )
  plot_geo(data, locationmode = 'USA-states') %>%
    add_trace(
      z = ~State.Covered.Charges, text = ~State.Covered.Charges, locations = ~Provider.State,
      color = ~State.Covered.Charges, colors = 'Purples'
    ) %>%
    colorbar(title = "Average Covered Charges / Average Total Payments") %>%
    layout(
      title = 'Ratio of Average Covered Medical Charges to Average Total Payments by State<br>(Hover for breakdown)',
      geo = g
    )
}

makeCountyChoropleth <- function(data){
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white')
  )
  plot_geo(data, locationmode = 'USA-counties') %>%
    add_trace(
      z = ~State.Covered.Charges, text = ~State.Covered.Charges, locations = ~county,
      color = ~State.Covered.Charges, colors = 'Purples'
    ) %>%
    colorbar(title = "Average Covered Charges / Average Total Payments") %>%
    layout(
      title = 'Ratio of Average Covered Medical Charges to Average Total Payments by County<br>(Hover for breakdown)',
      geo = g
    )
}