library(tidyverse)
library(tidytext)
library(stringr)

cruz<-read_csv("./data_clean/cruz_data_clean.csv")



# save the grant numbers in format to search WOS --------------------------

# write_csv(cruz %>% select(award_id) %>% mutate(or=" OR "), "./data_raw/search.csv")


# prep pubs with refsplitr ------------------------------------------------


library(refsplitr)

cruz_pubs<-references_read(data = "./data_raw/wos/",
                           dir=TRUE,
                           include_all = TRUE)

cruz_pubs<-cruz_pubs %>% mutate_all(tolower) 
titles<-cruz_pubs %>% select(TI,DE,SO)
write_csv(titles, "./data_clean/pub_titles.csv")

titles_summary<-titles %>% 
  select(SO) %>% 
  group_by(SO) %>% 
  tally() %>% 
  arrange(desc(n))|>
  print(n=20)  
  


keywords<-titles %>% 
  select(DE) %>% 
  mutate(kw = strsplit(DE, ";")) %>%
  unnest(kw) %>%
  group_by(DE) %>%
  mutate(group_id = cur_group_id()) %>% 
  relocate(group_id,.before=1) %>% 
  ungroup() %>%
  select(-DE) %>% 
  mutate(kw=trimws(kw,"both")) %>% 
  filter(!is.na(kw)) %>% 
  mutate(kw=gsub("\n", " ",kw)) %>% 
  group_by(kw) %>% 
  tally() %>% 
  arrange(desc(n))|>
  print(n=30)  



funds_by_cat<-cruz %>% 
  filter(status_cat=="Y") %>% 
  summarize(amt=sum(award_amount),awards=sum(n_distinct(award_id)),grants=n_distinct(summary))

career<-str_detect(cruz$summary, "career:")
summary(career)

cruz %>% summarize(n=n_distinct(award_id))


cruz %>% 
  distinct(summary,.keep_all=TRUE) %>% 
  summarize(n=n_distinct(award_id))


cruz_summary<-cruz %>% group_by(summary) %>% 
  tally() %>% 
  arrange(desc(n)) %>% 
  filter(n>1)












rows<-nrow(cruz)
text<-cruz$award_descriptions   
text_df <- tibble(line = 1:rows, text = text) %>%
  unnest_tokens(output = word, input = text)

cleaned_nsf <- text_df %>%
  anti_join(get_stopwords()) %>% 
  count(word, sort = TRUE) 


library(wordcloud)
cleaned_nsf %>%
  with(wordcloud(word, n, max.words = 100))

