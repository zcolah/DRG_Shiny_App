#------------------------structure---------------------------#
#------------------------structure---------------------------#
#------------------------structure---------------------------#


#Select a state then select a region, and get information about the hospitals in the region for a particular DRG
#Audience: Patient who has a DRG looks for a hospital which suits the best in the city or city which is nearby


#select a DRG
#select a region
#output a list of hospitals in the region
#numberic input, type the money that they want for the most amount of money that they can offer 


#---------------------------question------------------------------#
#---------------------------question------------------------------#
#---------------------------question------------------------------#


#how to make the title font bigger?
#how to make another color in the graph?


#-------------------------------test-----------------------------------#
#-------------------------------test-----------------------------------#
#-------------------------------test-----------------------------------#

drg.name <- c('039 - EXTRACRANIAL PROCEDURES W/O CC/MCC')
region.name <- c('AL - Dothan')


#---------------------------code------------------------------#
#---------------------------code------------------------------#
#---------------------------code------------------------------#


library(plotly)
library(stringr)
library(dplyr)

patient.data <- read.csv('patient_data.csv', stringsAsFactors = F)

#tab3.data will be used in this function. So that original data which is patient.data will not be changed
tab3.data <- patient.data

#we subsitude the $ sign by blank space in order to put the only number in the dataset
tab3.data$Average.Covered.Charges <- lapply(tab3.data$Average.Covered.Charges, 
                                            function(x)as.numeric(gsub("[,$]","",x)))
tab3.data$Average.Total.Payments <- lapply(tab3.data$Average.Total.Payments, 
                                           function(x)as.numeric(gsub("[,$]","",x)))
tab3.data$Average.Medicare.Payments <- lapply(tab3.data$Average.Medicare.Payments, 
                                              function(x)as.numeric(gsub("[,$]","",x)))

#This column gives the information that an elderly who has medicare needs to pay
#The amount of money = total payment - medicare
tab3.data$payment.medicare.gap <- as.numeric(tab3.data$Average.Total.Payments) - as.numeric(tab3.data$Average.Medicare.Payments)

#alphabetic order the region name, it will be easy for people to search
tab3.data <- tab3.data[order(tab3.data$Hospital.Referral.Region.Description),] 

Build.bar.chart <- function(region.name, drg.name){
  
  #select the information that we need
  hospital.data <- select(tab3.data,
                            Hospital.Referral.Region.Description,
                            DRG.Definition,
                            Provider.Name,
                            Average.Covered.Charges, 
                            Average.Total.Payments, 
                            Average.Medicare.Payments,
                            payment.medicare.gap) %>%
                    
                   #select the information that is in the selected region
                   filter(Hospital.Referral.Region.Description == region.name) %>%  
    
                   #select the information that is about the selected DRG
                   filter(DRG.Definition == drg.name) %>%
    
                   #Output the information that we need
                   select(Provider.Name,
                          Average.Covered.Charges,
                          Average.Total.Payments, 
                          Average.Medicare.Payments,
                          payment.medicare.gap)
  
  #the structure of x variable in plotly graph is character
  #transform the hospital name column in the data frame that we find in the function into character
  x.hospital.name <- as.character(hospital.data$Provider.Name)
  
  #the structure of y variable in plotly graph is numeric
  #transform the hospital name column in the data frame that we find in the function into numeric
  y1.ave.covered.charges <- as.numeric(hospital.data$Average.Covered.Charges)
  y2.ave.total.payments <- as.numeric(hospital.data$Average.Total.Payments)
  y3.ave.medicare.payments <- as.numeric(hospital.data$Average.Medicare.Payments)
  y4.ave.payment.medicare.gap <- hospital.data$payment.medicare.gap
  
  bar.chart <- plot_ly(x = ~x.hospital.name, y = ~y1.ave.covered.charges,
                       type = "bar", name = 'Average.Covered.Charges')%>%
    
    #add Average.Total.Payments information
    add_trace(y = ~y2.ave.total.payments, name = 'Average.Total.Payments')%>%
    
    #add Average.Medicare.Payments information 
    add_trace(y = ~y3.ave.medicare.payments, name = 'Average.Medicare.Payments')%>%
    
    add_trace(y = ~y4.ave.payment.medicare.gap, name = 'Average.Payment.Medicare.Gap') %>%
    
    #lable yaxis, determine the display mode of the bar chart
    layout(title = 'Region Hospital Information',
           yaxis = list(title = 'Amount of Money'),
           xaxis = list(title = x.hospital.name),
           barmode = 'group')
  
return(bar.chart)}

#------------------------discription---------------------------#
#------------------------discription---------------------------#
#------------------------discription---------------------------#

#if you are an elder who is older than 65 years old 
#you can compare to the red bar
#the red bar tells you how much money do you need to speed on the DRG that you select in the region that you chose
#if you are not an elder who is older than 65 years old
#you can compare to the orange bar 






