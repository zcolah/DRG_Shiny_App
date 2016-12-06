#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(plotly)
source("Musetab3.R")

shinyServer(function(input,output){
  output$bar.chart.city.info <- renderPlotly({
    state.passin =input$state.select
    drg.passin = input$drg.select
    return(Build.bar.chart(state.name = state.passin, drg.name = drg.passin))
  }) 
})



#use city.name = state.passin and input$state.select for test 19,17