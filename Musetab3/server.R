
library(shiny)
library(dplyr)
library(plotly)
source("Musetab3.R")

shinyServer(function(input,output){
  output$bar.chart.city.info <- renderPlotly({
    state.passin = input$state.select
    city.passin = input$city.select
    drg.passin = input$drg.select
    return(Build.bar.chart(state.name = state.passin, 
                           city.name = city.passin, 
                           drg.name = drg.passin))
  }) 
})

