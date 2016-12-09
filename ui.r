# Library necessary packages
library(shiny)
library(leaflet)
library(plotly)

# Read in the drg names
hospital.data.drg <- read.csv("data/hospital_data_drg.csv")

shinyUI(fluidPage(
  
  # Make a title for the application
  titlePanel("Hospital Locations"),
  
  # Create a sidebar with widgets that will modify the map
  sidebarLayout(
    sidebarPanel(
      
      # Select input for the DRGs
      selectInput("selected.drg.for.leaflet",
                  "Select DRG",
                  hospital.data.drg$DRG.Definition,
                  selected = "039 - EXTRACRANIAL PROCEDURES W/O CC/MCC"),
      
      # This puts the slider bar that will adjust based on the selected drg
      htmlOutput("numeric.range"),

      # These buttons will adjust the choropleth map
      radioButtons("coverage",
                   "Coverage Options",
                   choices = list(Medicare = "State.Medicare.Coverage.Percent", Insurance = "State.Covered.Charges.Percent"),
                   selected = "State.Medicare.Coverage.Percent")
    ),
    
    # The main panel will display the map
    mainPanel(
      # Show a map of where the hospitals are that fit the DRG and the maximum payment
      leafletOutput("map"),
      
      # Show a map of each state and the average ratio between average covered charges and average total payment
      plotlyOutput("coverage.choropleth")
    )
  )
))