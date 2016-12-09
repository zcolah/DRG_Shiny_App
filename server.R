  #loading Libraries
  library(shiny)
  library(dplyr)
  library(plotly)
  library(stringr)
  library(leaflet)
  library(maps)
  
  # source "DRG.location.payments" dataframe, buildBarChart function, 
  # and all the reactive functions.
  source('scripts/buildBarChart.R')
  source('scripts/Reactive Functions.R')
  
  # Read in the data for the leaflet map
  hospital.data.for.leaflet <- read.csv("data/hospital_data_for_leaflet.csv", stringsAsFactors = F)
  
  # Read in the data for the choropleth map
  hospital.data.state <- read.csv("data/hospital_data_state.csv", stringsAsFactors = F)
  
  # Read in the scripts used for the leaflet and choropleth maps
  source("scripts/leaflet_map.r")
  source("scripts/choropleth.r")
  source("scripts/get_range.r")
  source("scripts/make_table.r")
  
  # Sourcing for Select a county and get information about the hospitals in that city for a particular DRG
  source('./scripts/search_hospitals_by_region.R')
  source ('./scripts/support_functions_search_hospital_by_region.R')
  
  # Sourcing for finding gap between medicare and payment for DRG
  source('./scripts/find_gap_between_total_payments_and_medicare.R')
  source('./scripts/support_functions_finding_gap_between_total_payments_and_medicare.R')
  
  # Read in the scripts for DRG_impact on states
  source("scripts/drg_chloropleth.R")
  source("scripts/drg_impact.r")
  source("scripts/drg_impact_table.r")
  
  #Calling dataframes into server
  hospital.data <- hospital.data <- read.csv("./data/hospital_data_with_state_name.csv", stringsAsFactors = FALSE)
  population.data <- read.csv("./data/population_estimate_for_2011.csv", stringsAsFactors = FALSE)
  
  function(input, output, session){
    
    #Tab : Find a hospital in your budget 

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
    
    # This is the leaflet map  which will be generated which contains all the available hospital locations
    output$budget_map <- renderLeaflet(
      MakeHospitalMap(hospital.data.for.leaflet, input$selected.drg.for.leaflet, input$payment)
    )
    
    # This is the data table which will be generated which contains all the available hospital locations
    output$hospital_locations_table <- renderDataTable({
      MakeTable(hospital.data.for.leaflet, input$selected.drg.for.leaflet, input$payment)
    })
    
    
    #Tab : Find a hospital Near You
    
    #Creates a bar chart based on the inputs by the user
    output$bar.chart.city.info <- renderPlotly({
      region.passin <- input$region.select
      drg.passin <- input$drg.select
      return(Build.bar.chart(region.name = region.passin, drg.name = drg.passin))
    })
    
    
    #Creates a table below the graph so that people can learn more information about the hospitals
    output$data.table.find.a.hospital.near.you <- renderDataTable({
      tab3.data %>%
        select(Provider.Name, Provider.City, Provider.Street.Address, Provider.Zip.Code, Hospital.Referral.Region.Description, DRG.Definition) %>%
        filter(DRG.Definition == input$drg.select) %>%
        filter(Hospital.Referral.Region.Description == input$region.select) %>%
        select(Provider.Name, Provider.City, Provider.Street.Address, Provider.Zip.Code)
    })
    
    #Tab: Medicare and Insurance Coverages Tab
    
    # This is the choropleth map generated in the tab
    output$coverage.choropleth <- renderPlotly(
      MakeStateChoropleth(hospital.data.state, input$coverage)
    )
    
    
    #Tab: Discharge Statistics 
    
    #This is the discharge choropleth map for a particular DRG
    output$choropleth_drg_impact_percentage <- renderPlotly(DRG_Impact_Choropleth_Map(input$drg_option_for_impact,input$discharge_visualization_option,hospital.data,population.data))
    
    #Table created for discharges for a particular DRG
    output$discharge_table <- renderDataTable({DRG_Impact_Table(input$drg_option_for_impact,hospital.data,population.data)})
    
    # Tab: Medicare Gap
    # This is a scatterplot that shows the difference between total payment and medicare payment
    output$drg.payment.medicare <- renderPlotly({
      drg.passin = input$drg.select
      return(Build.scatter.plot(drg.name = drg.passin))
    }) 
  }