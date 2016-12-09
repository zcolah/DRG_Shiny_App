#Loading Libraries
library(plotly)
library(stringr)
library(dplyr)
library(shiny)
library(markdown)
library(leaflet)


# Read in the drg names
hospital.data.drg <- read.csv("data/hospital_data_drg.csv")


#Sourcing for Select a county and get information about the hospitals in that city for a particular DRG
source('./scripts/search_hospitals_by_region.R')
source ('./scripts/support_functions_search_hospital_by_region.R')

#Sourcing for finding gap between medicare and payment for DRG
source('./scripts/find_gap_between_total_payments_and_medicare.R')
source('./scripts/support_functions_finding_gap_between_total_payments_and_medicare.R')

#
navbarPage("Lays' Project : DRG Analyis", 
           
           
           # Make a title for the application
           tabPanel("Hospital Locations Map",
                    
                    # Create a sidebar with widgets that will modify the map
                    sidebarLayout(
                      sidebarPanel(
                        
                        # Select input for the DRGs
                        selectInput("selected.drg.for.leaflet",
                                    "Select DRG",
                                    hospital.data.drg$DRG.Definition,
                                    selected = "039 - EXTRACRANIAL PROCEDURES W/O CC/MCC"),
                        
                        # This puts the slider bar that will adjust based on the selected drg
                        htmlOutput("numeric.range")

                      
   
                    ),
                    # The main panel will display the map
                    mainPanel(
                      # Show a map of where the hospitals are that fit the DRG and the maximum payment
                      leafletOutput("map"),
                      
                      # Show a table of the data about the hospitals
                      dataTableOutput("hospital.locations.table")
                      
                    ))
           ),

           tabPanel('Insurance/Medicare Rate',
                    # Create a sidebar with widgets that will modify the map
                    sidebarLayout(
                      sidebarPanel(
                    # These buttons will adjust the choropleth map
                    radioButtons("coverage",
                                 "Coverage Options",
                                 choices = list(Medicare = "State.Medicare.Coverage.Percent", Insurance = "State.Covered.Charges.Percent"),
                                 selected = "State.Medicare.Coverage.Percent")
                      ),
                      mainPanel(
                      # Show a map of each state and the average ratio between average covered charges and average total payment
                      plotlyOutput("coverage.choropleth")
                    )
                    )
           ),
           
           
           tabPanel("Hospital Nearby",
                    
           #tab3 -  you find the hospitals that is in a region
           #For people who want to have treatment near where they live
           
 
           sidebarLayout(
             sidebarPanel(
               
               #select a Region
               selectInput('region.select', label = 'Region',
                           choices = regions$Hospital.Referral.Region.Description),
               
               #select a DRG
               selectInput('drg.select', label  = 'DRG : DRG: Diagnosis-Related Group',
                           choices = drgs$DRG.Definition)), 
             mainPanel(
               plotlyOutput('bar.chart.city.info')
             )
           )),
           
           tabPanel('Medicare Gap',
           
            #tab7-Muse, bigger gap between payment and medicare the bigger dot will be 
           #For government, to know which hospital need more assistance
           
           sidebarLayout(
             sidebarPanel(      
               selectInput('drg.select', label  = 'DRG: Diagnosis-Related Group',
                           choices = drgs$DRG.Definition)),
             mainPanel(
               plotlyOutput('drg.payment.medicare')
             )
           )),
           
           
           navbarMenu('Whats More',
           #More information about us
           #introduce our project
           #1. what is DRG, where we got the data
           #2. what is the purpose
           #3. who is the audience
           
           tabPanel("About Team Lays",
                    fluidRow(
                      column(3,
                              img(class = 'img-lays',
                                  src = paste0('http://www.perspectivebranding.com/images/uploads/portfolio/_960/Global_Lays_SINGLE.jpg')),
                    tags$small(
                      'Things you need to know:',
                      "1. Picture source: you search Lays online and click the first picture",
                      '2. We were eatting Lays chips when we tried to make a team.',
                      "3. Do you wanna know how can we make such awesome website?",
                      "You Google it!"
                    )
                    ))),
           tabPanel('About the Project')
))
                             
