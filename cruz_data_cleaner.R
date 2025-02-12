
# Database from:https://www.commerce.senate.gov/2025/2/cruz-led-investigation-uncovers-2-billion-in-woke-dei-grants-at-nsf-releases-full-database

# note this code could be more efficient but I wanted ppl 
# to be able to easily understand changes 

# TODO: change division names to abbreviations
# TODO: read_me to list abbreviations

# load libraries ----------------------------------------------------------

require(tidyverse)
library(readxl)
library(usdata)
require(here)


# load raw data -----------------------------------------------------------


cruz <- read_xlsx(here("data_raw", "Public Database_Release (1) (1).xlsx")) %>% 
  mutate_all(tolower) %>% 
  rename_with(tolower) 


# clean up column names ---------------------------------------------------

clean_col_names<-names(cruz) %>% 
  as_tibble() %>% 
  mutate(value=gsub(" ","_",value)) %>% 
  mutate(value=str_replace(value,"category","cat")) %>% 
  mutate(value=str_replace(value,"performance_start","start")) %>% 
  mutate(value=str_replace(value,"performance_end","end")) %>% 
  mutate(value=str_replace(value,"nsf_","")) %>% 
  mutate(value=str_replace(value,"_of_","_")) %>% 
  mutate(value=str_replace(value,"environmental_","env_")) %>%
  mutate(value=str_replace(value,"performance","perf")) %>%
  mutate(value=str_replace(value,"total_award_funding_amount","award_amount")) 

clean_col_names<-as.matrix(clean_col_names)

names(cruz)<-clean_col_names


# fix column categories ---------------------------------------------------

cruz<-cruz %>% 
  mutate(award_amount=as.numeric(award_amount)) %>% 
  mutate(across(where(is.character), as.factor)) %>% 
  mutate(start_date=as.Date(start_date)) %>% 
  mutate(end_date=as.Date(end_date)) %>% 
  mutate(recipient_state=state2abbr(recipient_state)) %>% 
  mutate(recipient_state_perf=state2abbr(recipient_state_perf)) %>%
  mutate(recipient_state_perf=tolower(recipient_state_perf)) %>%
  mutate(recipient_state=tolower(recipient_state)) %>%
  mutate(recipient_country=
           case_when(
             recipient_country == "united states" ~ "usa",
             .default = as.factor(recipient_country)
             )
  ) %>% 
  mutate(recipient_country_perf=
           case_when(
             recipient_country_perf == "united states" ~ "usa",
             .default = as.factor(recipient_country_perf)
           )
  ) %>% 
  
  mutate(recipient_type=
           case_when(
             recipient_type == "public/state controlled institution of higher education" ~ "public",
             recipient_type == "private institution of higher education" ~ "private",
             recipient_type == "for-profit organization (other than small business)" ~ "for_profit_nonbis",
             recipient_type == "small business" ~ "small_biz",
             recipient_type == "non-domestic (non-u.s.) entity" ~ "non_usa_org",
             recipient_type == "indian/native american tribal designated organization" ~ "tribal_org",
             .default = as.factor(recipient_country_perf)
           )
  ) %>% 
  mutate(status_cat=if_else(is.na(status_cat),NA,"Y")) %>% 
  mutate(social_justice_cat=if_else(is.na(social_justice_cat),NA,"Y")) %>% 
  mutate(env_justice_cat=if_else(is.na(env_justice_cat),NA,"Y")) %>% 
  mutate(race_cat=if_else(is.na(race_cat),NA,"Y")) %>% 
  mutate(gender_cat=if_else(is.na(gender_cat),NA,"Y")) %>% 
  relocate()
  

# save the data as csv ----------------------------------------------------

write_csv(cruz,here("data_clean","cruz_data_clean.csv"))
