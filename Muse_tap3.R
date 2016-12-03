#------------------------structure---------------------------#
#------------------------structure---------------------------#
#------------------------structure---------------------------#


#Select a state and get information about the hospitals in the state for a particular DRG
#Audience: Patient who has a DRG looks for the hospital which suits the best in the state where he lives 
#People will travel in the state in order to get treatment
#select a DRG
#select a state
#output a list of hospitals in the state
#numberic input, type the money that they want for the most amount of money that they can offer 


#---------------------------question------------------------------#
#---------------------------question------------------------------#
#---------------------------question------------------------------#

#input the city and the zip code, then match the similar zip cod
#add a check box to chose whether you are a elder or not, 
  #if you are a elder there will only have green in front and orange in the back


#take the value in there will be a math function and find the closest function



#---------------------------code------------------------------#
#---------------------------code------------------------------#
#---------------------------code------------------------------#


library(plotly)
library(stringr)
library(dplyr)

patient.data <- read.csv('patient_data.csv', stringsAsFactors = F)

#the city.name needs to have ''
Build.bar.chart <- function(zipcode.number, DRC.name){
  
  #tap4.data will be used in this function. So that original data which is patient.data will not be changed
  tap3.data <- patient.data
  
  #we subsitude the $ sign by blank space in order to put the only number in the dataset
  tap3.data$Average.Covered.Charges <- lapply(tap3.data$Average.Covered.Charges, 
                                              function(x)as.numeric(gsub("[,$]","",x)))
  tap3.data$Average.Total.Payments <- lapply(tap3.data$Average.Total.Payments, 
                                              function(x)as.numeric(gsub("[,$]","",x)))
  tap3.data$Average.Medicare.Payments <- lapply(tap3.data$Average.Medicare.Payments, 
                                              function(x)as.numeric(gsub("[,$]","",x)))
  
  #select the information that we need
  hospital.data <- select(tap3.data,
                            DRG.Definition,
                            Provider.Zip.Code,
                            Provider.Name,
                            Average.Covered.Charges, 
                            Average.Total.Payments, 
                            Average.Medicare.Payments)%>%
    
                   #select the information that is about the selected DRC
                   filter(DRG.Definition == DRC.name)%>%
    
                   #select the infornation that is in the selected state
                   filter(Provider.Zip.Code == zipcode.number)%>%
    
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
  
  bar.chart <- plot_ly(x = x.hospital.name,y = y1.ave.covered.charges,
                       type = "bar", name = 'Average.Covered.Charges')%>%
    
    #add Average.Total.Payments information
    add_trace(y = y2.ave.total.payments, name = 'Average.Total.Payments')%>%
    
    #add Average.Medicare.Payments information 
    add_trace(y = y3.ave.medicare.payments, name = 'Average.Medicare.Payments')%>%
    
    #lable yaxis, determine the display mode of the bar chart
    layout(title = 'State Hospital Information',
           yaxis = list(title = 'Amount of Money'),
           xaxis = list(title = x.hospital.name),
           x = c("Average.Covered.Charges", "Average.Total.Payments", "Average.Medicare.Payments"))
  
return(bar.chart)}



#-------------------------------test-----------------------------------#
#-------------------------------test-----------------------------------#
#-------------------------------test-----------------------------------#

DRC.name <- c('039 - EXTRACRANIAL PROCEDURES W/O CC/MCC')
zipcode.number <- 36301


#---------------------------better code--------------------------------#
#---------------------------better code--------------------------------#
#---------------------------better code--------------------------------#


#patient.data <- read.csv('patient_data.csv', stringsAsFactors = F)