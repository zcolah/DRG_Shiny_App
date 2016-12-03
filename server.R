library(shiny)

setwd("/Users/mac/Desktop/Project_Hospital_Information")

source('./Data Wrangling.R')
source('./scripts/buildBarChart.R')

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlotly({ 
    a.var1 <- input$var.a1
    a.var2 <- input$var.a2
    a.var3 <- input$var.a3
    a.var4 <- input$var.a4
    a.var5 <- input$var.a5
    
    b.var1 <- input$var.b1
    b.var2 <- input$var.b2
    b.var3 <- input$var.b3
    b.var4 <- input$var.b4
    b.var5 <- input$var.b5
    
   return(DrawBarplot(data = DRG.location.payments, 
                      state1 = a.var1, 
                      city1 = a.var2, 
                      zip1 = a.var3, 
                      hospital1 = a.var4, 
                      drg1 = a.var5,
                      state2 = b.var1,
                      city2 = b.var2,
                      zip2 = b.var3,
                      hospital2 = b.var4,
                      drg2 = b.var5))
    })
})
