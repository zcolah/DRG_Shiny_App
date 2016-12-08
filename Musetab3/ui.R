#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(plotly)

source("./supportFunctions.R")

shinyUI(fluidPage(
  titlePanel('City Hospital Information Filter'),
  
  sidebarLayout(
    sidebarPanel(
      selectInput('state.select', label  = 'State',
                  choices = states$Provider.State),
      
      htmlOutput('uiRegion'),
      
      htmlOutput('uiDrg')),

    mainPanel(
      plotlyOutput('bar.chart.city.info')
    )
  )))





