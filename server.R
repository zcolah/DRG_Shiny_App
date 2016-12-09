library(shiny)
library(plotly)
# source "DRG.location.payments" dataframe, buildBarChart function, 
# and all the reactive functions.
DRG.location.payments <- read.csv('scripts/2011 DRG Location Payments.csv', stringsAsFactors = F)
source('./scripts/buildBarChart.R')
source('./scripts/Reactive Functions.R')

# Define server logic required to render comparative bar chart.
shinyServer(function(input, output) {
  
  # use reactive functions to make the uses' input choice to decide the next selectInput scope.
  
  # For the first option
    v.region1 <- reactive({Region(input$var.a1)})
    v.city1 <- reactive({Cities(input$var.a1, input$var.a2)})
    v.hos1 <- reactive({Hospitals(input$var.a1, input$var.a2, input$var.a3)})
    v.drg1 <- reactive({DRG(input$var.a1, input$var.a2, input$var.a3, input$var.a4)})
    
  # For the second option
    v.region2 <- reactive({Region(input$var.b1)})
    v.city2 <- reactive({Cities(input$var.b1, input$var.b2)})
    v.hos2 <- reactive({Hospitals(input$var.b1, input$var.b2, input$var.b3)})
    v.drg2 <- reactive({DRG(input$var.b1, input$var.b2, input$var.b3, input$var.b4)})

    # build reactive selectInputs and render them to outputs. 
  output$selectUIregionA <- renderUI({ 
    selectInput("var.a2", "Provider Hospital Referral Region A", choices = v.region1())
  })
  
  output$selectUIcityA <- renderUI({ 
    selectInput("var.a3", "Provider City A", choices = v.city1())
  })
  
  output$selectUIhosA <- renderUI({ 
    selectInput("var.a4", "Provider Hospital A", choices = v.hos1())
  })
  
  output$selectUIdrgA <- renderUI({ 
    selectInput("var.a5", "Diagnosis-Related Group (DRG) A", choices = v.drg1())
  })
  
  output$selectUIregionB <- renderUI({ 
    selectInput("var.b2", "Provider Hospital Referral Region B", choices = v.region2())
  })
  
  output$selectUIcityB <- renderUI({ 
    selectInput("var.b3", "Provider City B", choices = v.city2())
  })
  
  output$selectUIhosB <- renderUI({ 
    selectInput("var.b4", "Provider Hospital B", choices = v.hos2())
  })
  
  output$selectUIdrgB <- renderUI({ 
    selectInput("var.b5", "Diagnosis-Related Group (DRG) B", choices = v.drg2())
  })
  
  # render the plot to the output and link all the variables from input by identifiers. 
  output$distPlot <- renderPlotly({

   return(DrawBarplot(data = DRG.location.payments, 
                      state1 = input$var.a1,
                      region1 = input$var.a2, 
                      city1 = input$var.a3, 
                      hos1 = input$var.a4,
                      drg1 = input$var.a5,
                      
                      state2 = input$var.b1,
                      region2 = input$var.b2, 
                      city2 = input$var.b3, 
                      hos2 = input$var.b4,
                      drg2 = input$var.b5))
    })
  
  # This is a data table that render the information from bar chart
  output$hospital.locations.table <- renderTable({
    BuildTable(state1 = input$var.a1,
               region1 = input$var.a2, 
               city1 = input$var.a3, 
               hos1 = input$var.a4,
               drg1 = input$var.a5,
               
               state2 = input$var.b1,
               region2 = input$var.b2, 
               city2 = input$var.b3, 
               hos2 = input$var.b4,
               drg2 = input$var.b5)
  })
})



