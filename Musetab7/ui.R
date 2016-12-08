
library(shiny)
library(dplyr)
library(plotly)

source("supportFunctions.R")

shinyUI(fluidPage(
  titlePanel('City Hospital Information Filter'),
  sidebarLayout(
    sidebarPanel(      
      selectInput('drg.select', label  = 'DRG: Diagnosis-Related Group',
                  choices = drgs$DRG.Definition)
    ),
    mainPanel(
      plotlyOutput('drg.payment.medicare')
    )
  ))
)

