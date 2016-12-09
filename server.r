# Library necessary packages
library(dplyr)

# Read in the two scripts that I will be using
source("scripts/drg_percentage_impact.r")

hospital.data <- hospital.data <- read.csv("./data/hospital_data_with_state_name.csv",stringsAsFactors = FALSE)
population.data <- read.csv("./data/population_estimate_for_2011.csv",stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  
  # This is the choropleth map
  output$choropleth_drg_impact_percentage<- renderPlotly(drg_impact_choropleth_map(input$drg_option_for_impact,hospital.data,population.data))
  
})