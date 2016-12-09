# Library necessary packages
library(leaflet)
library(maps)

# Read in the data for the leaflet map
hospital.data.for.leaflet <- read.csv("data/hospital_data_for_leaflet.csv")

# Read in the data for the choropleth map
hospital.data.state <- read.csv("data/hospital_data_state.csv")

# Read in the three scripts that I will be using
source("scripts/leaflet_map.r")
source("scripts/choropleth.r")
source("scripts/get_range.r")

shinyServer(function(input, output) {
  
  # This will get the range that the slider bar has
  dollar.range <- reactive({getRange(hospital.data.for.leaflet, input$selected.drg.for.leaflet)})
  
  # This will render the slider bar on the ui
  output$numeric.range <- renderUI({ 
    sliderInput("payment",
                "Range of Average Total Charges ($)",
                value = dollar.range(),
                min = dollar.range()[[1]],
                max = dollar.range()[[2]])
  })
  
  # This is the leaflet map
  output$map <- renderLeaflet(
    makeHospitalMap(hospital.data.for.leaflet, input$selected.drg.for.leaflet, input$payment)
  )
  
  # This is the choropleth map
  output$coverage.choropleth <- renderPlotly(
    makeStateChoropleth(hospital.data.state, input$coverage)
  )
})