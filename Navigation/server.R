library(shiny)
library(dplyr)
library(plotly)
library(stringr)

#tab3-Muse resource
source('Musetab3_backup.R')
source('supportFunctions_backup.R')

#tab7-Muse resource
source('Musetab7.R')
source('supportFunctions.R')

function(input,output, session){
  
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
