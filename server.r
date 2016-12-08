# Library necessary packages
library(dplyr)
library(leaflet)
library(maps)

# This was just how I did my data manipulation to get state information. I am creating
# multiple dataframes so I don't have to do a ton of data manipulation every time the
# data is loaded and I only keep the columns I need

#hospital.data <- read.csv("data/hospital_data.csv", stringsAsFactors = F)
#hospital.data.state <- hospital.data %>%
#  select(Provider.State, Average.Covered.Charges, Average.Total.Payments) %>% 
#  group_by(Provider.State) %>% 
#  summarize(State.Covered.Charges = mean(as.numeric(gsub("\\$", "", Average.Covered.Charges)) / as.numeric(gsub("\\$", "", Average.Total.Payments))))

# Read in the data for the leaflet map
hospital.data.for.leaflet <- read.csv("data/hospital_data_for_leaflet.csv")

# Read in the data for the choropleth map
hospital.data.state <- read.csv("data/hospital_data_state_abb.csv")

# Read in the two scripts that I will be using
source("scripts/leaflet_map.r")
source("scripts/choropleth.r")

shinyServer(function(input, output) {
  
  # This is the leaflet map
  output$map <- renderLeaflet(
    makeHospitalMap(hospital.data.for.leaflet, input$drg, input$max.payment)
  )
  
  # This is the choropleth map
  output$choropleth <- renderPlotly(
    makeStateChoropleth(hospital.data.state)
  )
})