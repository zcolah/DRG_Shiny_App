
library(shiny)
library(dplyr)
library(plotly)

#code for the bar chart
source("Musetab3_backup.R")



shinyServer(function(input,output){

  output$bar.chart.city.info <- renderPlotly({

    region.passin <- input$region.select

    drg.passin <- input$drg.select

    return(Build.bar.chart(region.name = region.passin, drg.name = drg.passin))

  })

})

