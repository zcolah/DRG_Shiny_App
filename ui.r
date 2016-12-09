# Library necessary packages
library(shiny)

# Read in the drg names
hospital.data.drg <- read.csv("data/hospital_data_drg.csv")

shinyUI(fluidPage(
  
  # Make a title for the application
  titlePanel("Impact of DRGs "),
  
  # Create a sidebar with widgets that will modify the map
  sidebarLayout(
    sidebarPanel(
      
      # Select input for the DRGs
      selectInput("drg_option_for_impact",
                  "Select a DRG",
                  hospital.data.drg$DRG.Definition,
                  selected = "039 - EXTRACRANIAL PROCEDURES W/O CC/MCC")),
      mainPanel(
      # Show a map of each state and the average ratio between average covered charges and average total payment
      plotlyOutput("choropleth_drg_impact_percentage")
    )
    
  )
))