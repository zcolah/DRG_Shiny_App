#list of the drg name that is going to pass in the ui
drgs <- tab7.data %>% 
  
  #select the region name column in tab3.data
  select(DRG.Definition) %>% 
  
  #discard the repeated region name
  distinct(DRG.Definition)

 
