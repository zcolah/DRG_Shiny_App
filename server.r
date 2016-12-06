library(dplyr)
library(leaflet)
library(maps)
#hospital.data <- read.csv("data/hospital_data.csv", stringsAsFactors = F)
#hospital.data.state <- hospital.data %>%
#  select(Provider.State, Average.Covered.Charges, Average.Total.Payments) %>% 
#  group_by(Provider.State) %>% 
#  summarize(State.Covered.Charges = mean(as.numeric(gsub("\\$", "", Average.Covered.Charges)) / as.numeric(gsub("\\$", "", Average.Total.Payments))))
hospital.data.state <- read.csv("data/hospital_data_state_abb.csv")
source("scripts/choropleth.r")
hospital.data.for.leaflet <- read.csv("data/hospital_data_for_leaflet.csv")
source("scripts/leaflet_map.r")

shinyServer(function(input, output) {
  output$map <- renderLeaflet(
    makeHospitalMap(hospital.data.for.leaflet, input$drg, input$max.payment)
  )
  output$choropleth <- renderPlotly(
    makeStateChoropleth(hospital.data.state)
  )
})