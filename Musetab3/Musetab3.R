#------------------------structure---------------------------#
#------------------------structure---------------------------#
#------------------------structure---------------------------#


#Select a city and get information about the hospitals in the state for a particular DRG
#Audience: Patient who has a DRG looks for a hospital which suits the best in the city or city which is nearby


#select a DRG
#select a city
#output a list of hospitals in the city
#numberic input, type the money that they want for the most amount of money that they can offer 


#---------------------------question------------------------------#
#---------------------------question------------------------------#
#---------------------------question------------------------------#

#how to select a state then output the city that is in the state? renderUI? reactive?
#add a check box to chose whether you are a elder or not, 
  #if you are a elder there will only have green in front and orange in the back
#how to make the title font bigger?


#-------------------------------test-----------------------------------#
#-------------------------------test-----------------------------------#
#-------------------------------test-----------------------------------#

drg.name <- c('039 - EXTRACRANIAL PROCEDURES W/O CC/MCC')
city.name <- c('SEATTLE')
state.name <- c('WA')

#---------------------------code------------------------------#
#---------------------------code------------------------------#
#---------------------------code------------------------------#


library(plotly)
library(stringr)
library(dplyr)

patient.data <- read.csv('patient_data.csv', stringsAsFactors = F)

Build.bar.chart <- function(state.name, city.name, drg.name){
  
  #tab3.data will be used in this function. So that original data which is patient.data will not be changed
  tab3.data <- patient.data
  
  #we subsitude the $ sign by blank space in order to put the only number in the dataset
  tab3.data$Average.Covered.Charges <- lapply(tab3.data$Average.Covered.Charges, 
                                              function(x)as.numeric(gsub("[,$]","",x)))
  tab3.data$Average.Total.Payments <- lapply(tab3.data$Average.Total.Payments, 
                                              function(x)as.numeric(gsub("[,$]","",x)))
  tab3.data$Average.Medicare.Payments <- lapply(tab3.data$Average.Medicare.Payments, 
                                              function(x)as.numeric(gsub("[,$]","",x)))
  
  #select the information that we need
  hospital.data <- select(tab3.data,
                            DRG.Definition,
                            Provider.State,
                            Provider.City,
                            Provider.Name,
                            Average.Covered.Charges, 
                            Average.Total.Payments, 
                            Average.Medicare.Payments)%>%
    
                   #select the information that is about the selected DRG
                   filter(DRG.Definition == drg.name)%>%
    
                   #select the information that is in the selected state
                   filter(Provider.State == state.name)%>%
                    
                   #select the information that is in the selected city
                   filter(Provider.City == city.name)%>%  
    
                   #Output the information that we need
                   select(Provider.Name,
                          Average.Covered.Charges,
                          Average.Total.Payments, 
                          Average.Medicare.Payments)
  
  #the structure of x variable in plotly graph is character
  #transform the hospital name column in the data frame that we find in the function into character
  x.hospital.name <- as.character(hospital.data$Provider.Name)
  
  #the structure of y variable in plotly graph is numeric
  #transform the hospital name column in the data frame that we find in the function into numeric
  y1.ave.covered.charges <- as.numeric(hospital.data$Average.Covered.Charges)
  y2.ave.total.payments <- as.numeric(hospital.data$Average.Total.Payments)
  y3.ave.medicare.payments <- as.numeric(hospital.data$Average.Medicare.Payments)
  
  bar.chart <- plot_ly(x = ~x.hospital.name, y = ~y1.ave.covered.charges,
                       type = "bar", name = 'Average.Covered.Charges')%>%
    
    #add Average.Total.Payments information
    add_trace(y = ~y2.ave.total.payments, name = 'Average.Total.Payments')%>%
    
    #add Average.Medicare.Payments information 
    add_trace(y = ~y3.ave.medicare.payments, name = 'Average.Medicare.Payments')%>%
    
    #lable yaxis, determine the display mode of the bar chart
    layout(title = 'City Hospital Information',
           yaxis = list(title = 'Amount of Money'),
           xaxis = list(title = x.hospital.name),
           barmode = 'group')
  
return(bar.chart)}


#trying to use the Provider.City.vector pass in the server so that I do not need to manually put in all the city name
Provider.City.dataframe <- as.data.frame(patient.data[,5], drop = FALSE)
Provider.City.vector <- as.vector(Provider.City.dataframe)


