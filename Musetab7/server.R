library(shiny)
library(dplyr)
library(plotly)
source("Musetab7.R")

shinyServer(function(input,output){
  output$drg.payment.medicare <- renderPlotly({
    drg.passin = input$drg.select
    return(Build.scatter.plot(drg.name = drg.passin))
  }) 
})