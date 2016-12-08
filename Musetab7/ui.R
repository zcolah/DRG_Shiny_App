shinyUI(fluidPage(
  titlePanel('City Hospital Information Filter'),
  sidebarLayout(
    sidebarPanel(      
      selectInput('drg.select', label  = 'DRG: Diagnosis-Related Group',
                                   choices = list("chronic obstructive pulmonary disease-190 - CHRONIC OBSTRUCTIVE PULMONARY DISEASE W MCC" = '190 - CHRONIC OBSTRUCTIVE PULMONARY DISEASE W MCC',
                                     'chronic obstructive pulmonary disease-191 - CHRONIC OBSTRUCTIVE PULMONARY DISEASE W CC' = '191 - CHRONIC OBSTRUCTIVE PULMONARY DISEASE W CC',
                                     "chronic obstructive pulmonary disease-192 - CHRONIC OBSTRUCTIVE PULMONARY DISEASE W/O CC/MCC" = '192 - CHRONIC OBSTRUCTIVE PULMONARY DISEASE W/O CC/MCC', 
                                     
                                     'Heart Disease - 238 - MAJOR CARDIOVASC PROCEDURES W/O MCC' = '238 - MAJOR CARDIOVASC PROCEDURES W/O MCC',
                                     'Heart Disease - 291 - HEART FAILURE & SHOCK W MCC' = '291 - HEART FAILURE & SHOCK W MCC',
                                     'Heart Disease - 292 - HEART FAILURE & SHOCK W CC' = '292 - HEART FAILURE & SHOCK W CC',
                                     'Heart Disease - 293 - HEART FAILURE & SHOCK W/O CC/MCC' = '293 - HEART FAILURE & SHOCK W/O CC/MCC',
                                     
                                     'Hypertension -305 - HYPERTENSION W/O MCC' = '305 - HYPERTENSION W/O MCC',
                    
                                     'Arthritis - 469 - MAJOR JOINT REPLACEMENT OR REATTACHMENT OF LOWER EXTREMITY W MCC' = '469 - MAJOR JOINT REPLACEMENT OR REATTACHMENT OF LOWER EXTREMITY W MCC',
                                     'Arthritis - 470 - MAJOR JOINT REPLACEMENT OR REATTACHMENT OF LOWER EXTREMITY W/O MCC' = '470 - MAJOR JOINT REPLACEMENT OR REATTACHMENT OF LOWER EXTREMITY W/O MCC',
                                     'Arthritis - 480 - HIP & FEMUR PROCEDURES EXCEPT MAJOR JOINT W MCC' = '480 - HIP & FEMUR PROCEDURES EXCEPT MAJOR JOINT W MCC',
                                     'Arthritis - 481 - HIP & FEMUR PROCEDURES EXCEPT MAJOR JOINT W CC' = '481 - HIP & FEMUR PROCEDURES EXCEPT MAJOR JOINT W CC',
                                     'Arthritis - 482 - HIP & FEMUR PROCEDURES EXCEPT MAJOR JOINT W/O CC/MCC' = '482 - HIP & FEMUR PROCEDURES EXCEPT MAJOR JOINT W/O CC/MCC',
                                     
                                     'Diabetes- 638 - DIABETES W CC' = '638 - DIABETES W CC'
                                     ))
    ),
    mainPanel(
      plotlyOutput('drg.payment.medicare')
    )
  ))
)

