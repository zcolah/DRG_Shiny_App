library(plotly)
library(dplyr)
hospital.data <- read.csv("data/hospital_data.csv", stringsAsFactors = F)
hospital.data.shortened <- hospital.data %>%
  select(Provider.City, Provider.State, Average.Covered.Charges) %>% 
  group_by(Provider.State) %>% 
  summarize(State.Covered.Charges = mean(as.numeric(gsub("\\$", "", Average.Covered.Charges)))) %>% 
  filter(Provider.State != "DC")
makeChoropleth <- function(data){
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
    colorbar(title = "Covered Charges") %>%
    layout(
      title = 'Average Covered Medical Charges by State<br>(Hover for breakdown)',
      geo = g
    )
}