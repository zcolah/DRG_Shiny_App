# Library necessary packages
library(shiny)
library(leaflet)
library(plotly)

# Read in the drg names
hospital.data.drg <- read.csv("data/hospital_data_drg.csv")

shinyUI(navbarPage("Hospital Information",
  
  # Make a title for the application
  tabPanel("Hospital Locations",
  
           # This is a description of the tab
           p("This tab shows a map of the United States and all the hospitals for the selected DRG and the chosen budget. By clicking on the markers the user receives information about that particular hospital."),
  
           # Create a sidebar with widgets that will modify the map
  sidebarLayout(
    sidebarPanel(
      
      # Select input for the DRGs
      selectInput("selected.drg.for.leaflet",
                  "Select DRG",
                  hospital.data.drg$DRG.Definition,
                  selected = "039 - EXTRACRANIAL PROCEDURES W/O CC/MCC"),
      
      # This puts the slider bar that will adjust based on the selected drg
      htmlOutput("numeric.range")
    ),
      mainPanel(
        # Show a map of where the hospitals are that fit the DRG and the maximum payment
        leafletOutput("map"),
        
        # Show a table of the data about the hospitals
        dataTableOutput("hospital.locations.table")
    )
  )),
  tabPanel("Medicare and Insurance Coverages",
           
           # This is a description of the tab
           p("This tab contains a map that has information about the coverage in each state. The user can choose whether they want Medicare coverage or insurance coverage and a map will be displayed that shows the percent of the total charges that will be covered by that particular coverage plan. By hovering over the state the user receives the exact percent of the coverage for that state. Darker colors represent better coverage."),
           
           # Create a sidebar with widgets that will modify the map
           sidebarLayout(
             sidebarPanel(
      # These buttons will adjust the choropleth map
      radioButtons("coverage",
                   "Coverage Options",
                   choices = list(Medicare = "State.Medicare.Coverage.Percent", Insurance = "State.Covered.Charges.Percent"),
                   selected = "State.Medicare.Coverage.Percent")
    ),
    
    # The main panel will display the map
    mainPanel(
      # Show a map of each state and the average ratio between average covered charges and average total payment
      plotlyOutput("coverage.choropleth")
    )
  )
)))