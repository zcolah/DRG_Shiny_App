library(shiny)
library(leaflet)

hospital.data.drg <- read.csv("data/hospital_data_drg.csv")

shinyUI(fluidPage(
  
  # Make a title for the application
  titlePanel("Hospital Locations"),
  
  # Create a sidebar with widgets that will modify the map
  sidebarLayout(
    sidebarPanel(
      
      # Select input for the DRGs
      selectInput("drg",
                  "Select DRG",
                  hospital.data.drg$DRG.Definition,
                  selected = "039 - EXTRACRANIAL PROCEDURES W/O CC/MCC"),
      
      # Numeric input for the most they want to pay
      numericInput("max.payment",
                   "Maximum Average Total Charges ($)",
                   value = 20000,
                   min = 0,
                   max = 200000
                  )
    ),
    

    mainPanel(
      # Show a map of where the hospitals are that fit the DRG and the maximum payment
      leafletOutput("map"),
      
      # Show a map of each state and the average ratio between average covered charges and average total payment
      plotlyOutput("choropleth")
    )
  )
))