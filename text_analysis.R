library(tidyverse)
library(tidytext)
library(stringr)

cruz<-read_csv("./data_clean/cruz_data_clean.csv")


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

