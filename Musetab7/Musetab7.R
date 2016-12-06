library(dplyr)
tap7.data <- read.csv('patient_data.csv')

#------------------------------------------------------------------#
#--------------------------option1---------------------------------#
#http://www.catalogs.com/info/bestof/top-10-diseases-of-the-elderly#
#------------------------------------------------------------------#
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




#----------------------------------------------------#
#-------------------option2--------------------------#
#http://www.hcup-us.ahrq.gov/reports/natstats/rn4.htm#
#----------------------------------------------------#
#----------------------------------------------------#

#normal newborn
#795

#vaginal delivery
#767,768

#heart failure
#291 - HEART FAILURE & SHOCK W MCC
#292
#293










#---------------------------------------------#
#---------------option3-----------------------#
#http://www.ehrdocs.com/time/pdf/Top10DRGs.pdf#
#---------------------------------------------#
#---------------------------------------------#


