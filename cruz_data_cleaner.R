
# note this code could be more efficient but I wanted ppl 
# to be able to easily understand changes 
# TODO: change remaining division names to abbreviations


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
             recipient_type == "for-profit organization (other than small business)" ~ "for_profit_nonbiz",
             recipient_type == "small business" ~ "small_biz",
             recipient_type == "non-domestic (non-u.s.) entity" ~ "non_usa_org",
             recipient_type == "indian/native american tribal designated organization" ~ "tribal_org",
             .default = as.factor(recipient_country_perf)
           )
  ) %>% 
  mutate(nsf_source=
           case_when(
             funding_office == "div of biological infrastructure" ~ "DBI", # "Biological Infrastructure"
             funding_office == "division of environmental biology" ~ "DEB", # "Environmental Biology"
             funding_office == "emerging frontiers" ~ "EF", # "Emerging Frontiers"
             funding_office == "div of integrative organismal sys" ~ "IOS", # "Integrative Organismal Systems
             funding_office == "division of molecular and" ~ "MCB", # "Molecular and Cellular Biosciences" 
             funding_office == "Computer and Information Science and Engineering" ~ "CISE",
             funding_office == "ofc of adv cyberinfrastructure" ~ "OAC", # "Advanced Cyberinfrastructure"
             funding_office == "div of computer  comm foundations"  ~ "CCF", # "Computing and Communication Foundations"
             funding_office == "div of computer  network systems" ~ "CNS", # "Computer and Network Systems"
             funding_office == "div of infor  intelligent systems" ~ "IIS", # "Information and Intelligent Systems"
             funding_office == "division of chemical bioengineering" ~ "CBET", # "Chemical, Bioengineering, Environmental and Transport Systems"
             funding_office == "div of civil, mechan  manuf innov" ~ "CMMI", # "Civil, Mechanical and Manufacturing Innovation"
             funding_office == "division electrical, communication" ~ "ECCS", # "Electrical, Communications and Cyber Systems"
             funding_office == "division of engineering education" ~ "EEC", # "Engineering Education and Centers"
             funding_office == "office of emerging frontiers and" ~ "EFMA", # "Emerging Frontiers and Multidisciplinary Activities"
             funding_office == "division of atmospheric and" ~ "AGS", # "Atmospheric and Geospace Sciences"
             funding_office == "division of earth sciences"  ~ "EAR", # "Earth Sciences"
             funding_office == "division of ocean sciences" ~ "OCE", # "Ocean Sciences"
             funding_office == "office of polar programs" ~ "OPP", # "Polar Programs"
             funding_office == "office of integrative activities" ~ "OIA", # "Integrative Activities"
             funding_office == "ofc interntl science  eng" ~ "OISE", # "International Science and Engineering"
             funding_office == "division of astronomical sciences" ~ "AST", # "Astronomical Sciences"
             funding_office == "division of chemistry" ~ "CHE", # "Chemistry"
             funding_office == "division of materials research" ~ "DMR", # "Materials Research"
             funding_office == "division of mathematical sciences" ~ "DMS", # "Mathematical Sciences"
             funding_office == "division of physics"  ~ "PHY", # "Physics"
             funding_office == "div of social and economic science" ~ "SBE", # "Social, Behavioral and Economic Sciences"
             funding_office == "div of behavioral  cognitive sci" ~ "BCS" ,
             funding_office == "division of equity for excellence in stem" ~ "EES", # "Equity for Excellence in STEM"
             funding_office == "division of graduate education"  ~ "DGE", # "Graduate Education"
             funding_office == "div of research on learning in" ~ "DRL", # "Research on Learning in Formal and Informal Settings"
             funding_office == "division of undergraduate education" ~ "DUE", # "Undergraduate Education"
             funding_office == "Technology, Innovation and Partnerships" ~ "TIP",
             .default = as.factor(funding_office)
           )
  ) %>% 
  mutate(nsf_source=tolower(nsf_source)) %>% 
  mutate(recipient_type=as.factor(recipient_type)) %>% 
  mutate(status_cat=if_else(is.na(status_cat),NA,"Y")) %>% 
  mutate(social_justice_cat=if_else(is.na(social_justice_cat),NA,"Y")) %>% 
  mutate(env_justice_cat=if_else(is.na(env_justice_cat),NA,"Y")) %>% 
  mutate(race_cat=if_else(is.na(race_cat),NA,"Y")) %>% 
  mutate(gender_cat=if_else(is.na(gender_cat),NA,"Y")) %>% 
  relocate(c(award_amount,
             recipient_name,
             recipient_city,
             recipient_state,
             recipient_type,
             nsf_source,
             funding_office,
             award_descriptions),.after=1)
  


# save the data as csv ----------------------------------------------------

write_csv(cruz,here("data_clean","cruz_data_clean.csv"))












