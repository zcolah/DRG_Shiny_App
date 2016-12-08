#------------------------------------------------------------------#
#--------------------------option1---------------------------------#
#http://www.catalogs.com/info/bestof/top-10-diseases-of-the-elderly#
#-------------------------information------------------------------#
#------------------------------------------------------------------#


#10. Arthritis
#joint
#469 - MAJOR JOINT REPLACEMENT OR REATTACHMENT OF LOWER EXTREMITY W MCC
#470 - MAJOR JOINT REPLACEMENT OR REATTACHMENT OF LOWER EXTREMITY W/O MCC
#480 - HIP & FEMUR PROCEDURES EXCEPT MAJOR JOINT W MCC
#481 - HIP & FEMUR PROCEDURES EXCEPT MAJOR JOINT W CC
#482 - HIP & FEMUR PROCEDURES EXCEPT MAJOR JOINT W/O CC/MCC


#9. Hypertension
#305 - HYPERTENSION W/O MCC


#8. Diabetes
#638 - DIABETES W CC


#7. Heart Disease
#a. heart
#291 - HEART FAILURE & SHOCK W MCC
#292 - HEART FAILURE & SHOCK W CC
#293 - HEART FAILURE & SHOCK W/O CC/MCC
#b. cardiovasc
#238 - MAJOR CARDIOVASC PROCEDURES W/O MCC


#6. Osteoporosis
#bone
#553,554, not in the dataset
#539-541
#do not recommand to do surgery?


#5. chronic obstructive pulmonary disease
#190 - CHRONIC OBSTRUCTIVE PULMONARY DISEASE W MCC
#191 - CHRONIC OBSTRUCTIVE PULMONARY DISEASE W CC
#192 - CHRONIC OBSTRUCTIVE PULMONARY DISEASE W/O CC/MCC


#4. Hearing impairments
#133,134,146,147,148
#Surgery for Otosclerosis: Laser Stapedotomy / Stapedectomy
#http://www.nyogmd.com/files/SurgeryForConductiveHearingLoss.pdf




#3. Depression
#Usually people do not have surgery for depression


#2. Alzheimer's disease
#Usually people do not have surgery for disease


#1. Parkinson's disease
#Usually people do not have surgery for this disease



#------------------------structure---------------------------#
#------------------------structure---------------------------#
#------------------------structure---------------------------#

#if you are old, you get to see the cost for top 5 DRGs for the hospital of your choice

#scatter plot display, x is average total payment, y is average medicare
#select disease
#select DRG
#Output scatter plot


#-------------------------------test-----------------------------------#
#-------------------------------test-----------------------------------#
#-------------------------------test-----------------------------------#

drg.name <- c('190 - CHRONIC OBSTRUCTIVE PULMONARY DISEASE W MCC')

#-----------------------------code---------------------------------#
#-----------------------------code---------------------------------#
#-----------------------------code---------------------------------#

#make a scatter plot, x is the payment, y is medicare

library(plotly)
library(stringr)
library(dplyr)

patient.data <- read.csv('patient_data.csv', stringsAsFactors = F)

Build.scatter.plot <- function(drg.name){
  
  #tab7.data will be used in this function. So that original data which is patient.data will not be changed
  tab7.data <- patient.data
  
  #we subsitude the $ sign by blank space in order to put the only number in the dataset
  tab7.data$Average.Total.Payments <- lapply(tab7.data$Average.Total.Payments, 
                                             function(x)as.numeric(gsub("[,$]","",x)))
  tab7.data$Average.Medicare.Payments <- lapply(tab7.data$Average.Medicare.Payments, 
                                                function(x)as.numeric(gsub("[,$]","",x)))
  
  tab7.data$payment.medicare.gap <- as.numeric(tab7.data$Average.Total.Payments) - as.numeric(tab7.data$Average.Medicare.Payments)
  
  #select the information that we need
  hospital.data <- select(tab7.data,
                          DRG.Definition,
                          Provider.Name, 
                          Average.Total.Payments, 
                          Average.Medicare.Payments,
                          payment.medicare.gap)%>%
    
                  #select the information that is about the selected DRC
                  filter(DRG.Definition == drg.name)%>%
  
                  #Output the information that we need
                  select(Provider.Name,
                         Average.Total.Payments, 
                         Average.Medicare.Payments,
                         payment.medicare.gap)
  
  #make a scatter plot
  scatter.plot <- plot_ly(hospital.data, 
                          x = ~Average.Total.Payments,
                          y = ~Average.Medicare.Payments,
                          
                          #Hover text, show the total payment, medicare and the hospital name
                          text = ~paste('Total Payment:', Average.Total.Payments,
                                        'Medicare Coverage:', Average.Medicare.Payments,
                                        'Hospital Name:', Provider.Name),
                          
                          #the color is going to change according to the amount of gap
                          color = ~payment.medicare.gap,
                          
                          #The larger the gap is, the bigger the dot is
                          size = ~payment.medicare.gap)
  
return(scatter.plot)}

#-----------------------------discription---------------------------------#
#-----------------------------discription---------------------------------#
#-----------------------------discription---------------------------------#

#The bigger the gap between total payment and medicare, the bigger the dots is, the more yellow the color is 
#looking at the outliers, government will be able to know what hospital should be improve in specific DRG medicare

