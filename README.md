# Hospital Information
A link to the shiny app can be found [here](https://zcolah.shinyapps.io/Project_Hospital_Information/).

Since we used a large dataset, many features will take a few seconds to load.

## About Our Dataset
Our project works with the “Inpatient Prospective Payment System (IPPS) Provider Summary for the Top 100 Diagnosis-Related Groups (DRG) - FY2011” data set of information created and maintained by the US Government. 

A Diagnosis Related Group is a statistical system of classifying any inpatient stay into groups for the purpose of payments. The DRG classification system divides possible diagnoses into more than 20 major body systems and subdivides them into almost 500 groups for the purpose of Medicare reimbursement.  

The data set we used in our investigation is a collection containing a summary for each of the top 100 DRGs for over 3000 hospitals in the United States of America that receive Medicare Inpatient Prospective Payment System Payment paid under Medicare based on a rate per discharge using the Medicare Severity Diagnosis Related Group (MS-DRG) for Fiscal Year (FY) 2011. These DRGs represent more than 7 million discharges or 60 percent of total Medicare IPPS discharges. These summaries contain information about the total discharges, the average covered charges, the average total payments and the average Medicare payments made by the patients who have been discharged.

The values that we focused on were the total discharges (which describes how many people were released from the hospital), average covered charges (which describes how much insurance will pay for the treatment), average total payments (which describes how much the patient pays for treatment), and average Medicare payments (which describes how much Medicare will pay for the treatment).

##Our Investigation
As part of our investigation of this data we compare the average total payments and average Medicare payments for each DRG of each state and city and for each hospital to try to identify the areas where it is more costly to receive medical treatment. We also investigated the total discharges for a particular DRG and compare the total discharges for each DRG of each state so as to identify accordingly if a particular state suffers more than the other.

Through this investigation of ours we want to help 

* Those seeking medical treatment and are facing problems in financing heavy medical bills
* Soon to be retiring elderly people because as they turn old they will need more and more medical procedures as medical issues increase with age, hence they will want to find an area which best suits their current financial status so as to ensure their medical issues do not harass them in the future. 
* The government as they will want to see the hospitals that have the lowest Medicare coverage
* People who are looking to ensure they receive good health insurance. Through our investigation they will be able to identify which areas receive better average Medicare or Insurance payments than others. 


## Technical Stuff
###About Our Analysis
We used a Shiny App to document our investigation and analysis of the data. Largely through the use of `plotly`, `dplyr`, and `leaflet` we were able to produce the outputs we wanted. In order to avoid too much data manipulation every time the app is loaded, we created many datasets so we just have to read them in. A challenge that we faced was getting the latitude and longitude for each hospital. This was solved though the use of the `zipcode` package and using `left_join` to join the data with the zipcodes, latitude, and longitude to the data with the hospital information.