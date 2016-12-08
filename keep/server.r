library(shiny)

setwd("/Users/mac/Desktop/Project_Hospital_Information")

source('./Data Wrangling.R')
source('./scripts/buildBarChart.R')
source('./scripts/Reactive Functions.R')
# Define server logic required to draw a histogram

shinyServer(function(input, output) {
  
    v1 <- input$var.a1
    v2 <- input$var.b2
    
  reactive({
    r.city1 <- cities(input$var.a1)
    r.zip1 <- zip.codes(input$var.a2)
    r.hos1 <- hospitals(input$var.a3)
    r.drg1 <- drg(input$var.a4)
    
    r.city2 <- cities(input$var.b1)
    r.zip2 <- zip.codes(input$var.b2)
    r.hos2 <- hospitals(input$var.b3)
    r.drg2 <- drg(input$var.b4)
  })
  
  output$distPlot <- renderPlotly({
    
    return(DrawBarplot(data = DRG.location.payments, 
                       state1 = v1, 
                       city1 = r.city1, 
                       zip1 = r.zip1, 
                       hospital1 = r.hos1, 
                       drg1 = r.drg1,
                       state2 = v2,
                       city2 = r.city2,
                       zip2 = r.zip2,
                       hospital2 = r.hos2,
                       drg2 = r.drg2))
  })
})
