
library(shiny)
library(dplyr)
library(plotly)

#code for the bar chart
source("Musetab3.R")

#cpde for the rective and list of the city and region
source("./supportFunctions.R")


shinyServer(function(input,output){

  #reactive, output the region that is in the selected state
  #the input$dstate.select is the state in the function locate.region
  r.region <- reactive({locate.region(input$state.select)})
  
  #reactive, output the drg that is exist in the selected region
  #the input$region.select is the state in the function locate.drg 
  r.drg <- reactive({locate.drg(input$region.select)})
  
  output$uiRegion <- renderUI({
    selectInput('region.select', label = 'Region',
          choices = r.region())
  })
  
  output$uiDrg <- renderUI({
    selectInput('drg.select', label = 'DRG: Diagnosis-Related Group', choices = r.drg())
  })
  
  output$bar.chart.city.info <- renderPlotly({

    return(Build.bar.chart(state.name = states$Provider.State, 
                           region.name = input$region.select, 
                           drg.name = input$drg.select))
  }) 
})
