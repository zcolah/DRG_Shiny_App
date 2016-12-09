

library(shiny)
library(dplyr)
library(plotly)

source("Musetab3_backup.R")
source("./supportFunctions_backup.R")



shinyUI(fluidPage(

  titlePanel('Region Hospital Information Filter'),
  sidebarLayout(
    sidebarPanel(
      
      #select a region
      selectInput('region.select', label = 'Region',
                  choices = regions$Hospital.Referral.Region.Description),
      
      #select a drg
      selectInput('drg.select', label  = 'DRG : DRG: Diagnosis-Related Group',
                  choices = drgs$DRG.Definition)

    ),
    mainPanel(
      plotlyOutput('bar.chart.city.info'),
      dataTableOutput('data.table')
    )
  ))
)




