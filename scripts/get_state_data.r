# This was just how I did my data manipulation to get state information. I am creating
# multiple dataframes so I don't have to do a ton of data manipulation every time the
# data is loaded and I only keep the columns I need

library(dplyr)
hospital.data <- read.csv("data/hospital_data.csv", stringsAsFactors = F)
hospital.data.state <- hospital.data %>%
  mutate(Average.Total.Payments = as.numeric(gsub("\\$", "", Average.Total.Payments))) %>% 
  mutate(Average.Covered.Charges = as.numeric(gsub("\\$", "", Average.Covered.Charges))) %>% 
  mutate(Average.Medicare.Payments = as.numeric(gsub("\\$", "", Average.Medicare.Payments))) %>% 
  select(Provider.State, Average.Covered.Charges, Average.Total.Payments, Average.Medicare.Payments) %>% 
  group_by(Provider.State) %>% 
  summarize(State.Covered.Charges.Percent = mean(100 * Average.Covered.Charges / (Average.Covered.Charges + Average.Total.Payments)),
            State.Medicare.Coverage.Percent = mean(100 * Average.Medicare.Payments / Average.Total.Payments))