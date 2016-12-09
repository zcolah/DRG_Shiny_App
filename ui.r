# Library necessary packages
#Importing the required libraries
library(devtools)
library (dplyr)
library (knitr)
library (plotly)
library (RColorBrewer)
library(shiny)

# Read in the drg names
hospital.data.drg <- read.csv("data/hospital_data_drg.csv")

shinyUI(fluidPage(
  
  # Make a title for the application
  titlePanel("Impact of DRGs "),
  
  # Create a sidebar with widgets that will modify the map
  sidebarLayout(
    
    #Sidebar containing input options
    sidebarPanel(
      
      # Select input for the DRGs
      selectInput("drg_option_for_impact",
                  "Select a DRG",
                  hospital.data.drg$DRG.Definition,
                  selected = "039 - EXTRACRANIAL PROCEDURES W/O CC/MCC"),
    
      # Select input for discharge visualization options
      selectInput("discharge_visualization_option",
                  "Discharge data set to visualize",
                  choices = list("Total Discharges" = "Total.Discharges.For.State", "Approximate Percentage of Discharges for Population" = "impact.percentage.on.state", "Approximate State Population for 2011" = "population.estimate.2011", "Total Cases for every 100,000" = "impact.on.hundred.thousand"),
                  selected = "Total Discharges")),
      
    #Main Panel to show data visualization 
      mainPanel(
      # Show a map of each state and the average ratio between average covered charges and average total payment
      plotlyOutput("choropleth_drg_impact_percentage")
    )
    
  )
))