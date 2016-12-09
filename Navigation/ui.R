

library(plotly)
library(stringr)
library(dplyr)
library(shiny)
library(markdown)

#tab3-Muse resource
source('Musetab3_backup.R')
source('supportFunctions_backup.R')

#tab7-Muse resource
source('Musetab7.R')
source('supportFunctions.R')

navbarPage("Lays' Project : DRG Analyis",
           
           tabPanel("Hospitals Comparing"),
           #tab1-Justin,you pick your own hospital in different place in the nation
           #For people who know what hospital they are going to 
           
           tabPanel("Hospitals Location"),
           #tab5-Steven,chose your offer payment, you will see the hospital in the nation
           #For people know how much money thay can offer but do not know what hospital they will go
           
           tabPanel("Hospital Nearby",
           #tab3-Muse, you find the hospitals that is in a region
           #For people who want to have treatment near where they live
           
           #code from ui.R Musetab3
           sidebarLayout(
             sidebarPanel(
               
               #select a region
               selectInput('region.select', label = 'Region',
                           choices = regions$Hospital.Referral.Region.Description),
               
               #select a drg
               selectInput('drg.select', label  = 'DRG : DRG: Diagnosis-Related Group',
                           choices = drgs$DRG.Definition)), 
             mainPanel(
               plotlyOutput('bar.chart.city.info')
             )
           )),
           
           
           tabPanel("Discharge Rate"),
           #tab6-Zoshua, higher rate has darker color in the state
           #For insurance company, to know where has the biggest business
           
           tabPanel('Insurance/Medicare Rate'),
           #tab2-Steven, higher rate has darker color in the state
           #For insurance company, to know where has the biggest business
           #For government, to know where should has higher or lower tax for medicare
           
           tabPanel('Medicare Gap',
           #tab7-Muse, bigger gap between payment and medicare, bigger dot you will be 
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
                    )),
           tabPanel('About the Project')
)))
                             
