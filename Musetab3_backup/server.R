
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
  
#show a table below the graph
#so that people know where is the hospital
  output$data.table <- renderDataTable({
    tab3.data %>%
      select(Provider.Name, Provider.City, Provider.Street.Address, Provider.Zip.Code, Hospital.Referral.Region.Description, DRG.Definition) %>%
      filter(DRG.Definition == input$drg.select) %>%
      filter(Hospital.Referral.Region.Description == input$region.select) %>%
      select(Provider.Name, Provider.City, Provider.Street.Address, Provider.Zip.Code)
  })
  
})

