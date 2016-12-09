#loading Libraries
library(shiny)
library(dplyr)
library(plotly)
library(stringr)
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
source("scripts/make_table.r")

#Sourcing for Select a county and get information about the hospitals in that city for a particular DRG
source('./scripts/search_hospitals_by_region.R')
source ('./scripts/support_functions_search_hospital_by_region.R')

#Sourcing for finding gap between medicare and payment for DRG
source('./scripts/find_gap_between_total_payments_and_medicare.R')
source('./scripts/support_functions_finding_gap_between_total_payments_and_medicare.R')

function(input,output, session){
  
  ### This is Steven's tab
  # This will get the range that the slider bar has
  dollar.range <- reactive({GetRange(hospital.data.for.leaflet, input$selected.drg.for.leaflet)})
  
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
    MakeHospitalMap(hospital.data.for.leaflet, input$selected.drg.for.leaflet, input$payment)
  )
  
  # This is the data table
  output$hospital.locations.table <- renderDataTable({
    MakeTable(hospital.data.for.leaflet, input$selected.drg.for.leaflet, input$payment)
  })
  
  # This is the choropleth map
  output$coverage.choropleth <- renderPlotly(
    MakeStateChoropleth(hospital.data.state, input$coverage)
  )
  
  #tab3-Muse
  output$bar.chart.city.info <- renderPlotly({
    region.passin <- input$region.select
    drg.passin <- input$drg.select
    return(Build.bar.chart(region.name = region.passin, drg.name = drg.passin))
  })
  
  
  #tab7-Muse
  output$drg.payment.medicare <- renderPlotly({
    drg.passin = input$drg.select
    return(Build.scatter.plot(drg.name = drg.passin))
  }) 
  
}
