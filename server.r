# Library necessary packages
#Importing the required libraries
library(devtools)
library (dplyr)
library (knitr)
library (plotly)
library (RColorBrewer)
library(dplyr)

# Read in the two scripts that I will be using
source("scripts/drg_chloropleth.r")
source("scripts/drg_impact.r")

hospital.data <- hospital.data <- read.csv("./data/hospital_data_with_state_name.csv",stringsAsFactors = FALSE)
population.data <- read.csv("./data/population_estimate_for_2011.csv",stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  
  # This is the choropleth map
  output$choropleth_drg_impact_percentage<- renderPlotly(DRG_Impact_Choropleth_Map(input$drg_option_for_impact,input$discharge_visualization_option,hospital.data,population.data))
  
})