install.packages("rtweet")
install.packages("tidytext")
install.packages("wordcloud")
library(rtweet)
library(tidyverse)
library(tidytext)
library(lubridate)
library(ggplot2)
library(wordcloud)
library(reshape2)

##connect

## app-assigned name
appname <- "rtweet_token"
key <- "FqoiqdHGUUtPpclSnjUrLTzH3"
secret <- "Wv5k5nek58thwepAN9LOcXXWFw6xrTDl0ZzJXZ4mE7JNW7HjBX"

## create token named "twitter_token"
twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret)

#pull popular tweets
#return last 50K tweets
b <- search_tweets("#billoreilly", n = 50000, type = "recent",retryonratelimit = TRUE)
#these go back to April 18, so return 18k right before
c <- search_tweets("#billoreilly", n = 18000, type = "recent",retryonratelimit = TRUE, until="2017-04-18")

cc <- c[[1]]
for (i in 2:length(c)) { cc <- cbind(cc,c[[i]]) }
colnames(cc) <- names(b)
cc<-as_tibble(cc)


#visualize average sentiment
  tweets <- as_tibble(b) %>% 
            select(tweet = text, date = created_at) %>%
            unnest_tokens(word,tweet) %>%
            inner_join(get_sentiments("bing"),by=c("word")) %>%
            mutate(logsent = ifelse(sentiment == "positive",1,-1), zero = 0)

  dailyavg <- tweets %>%
              mutate(month=month(date), day=day(date)) %>%
              group_by(month, day) %>%
              summarise(mean_sentiment=mean(logsent)) %>%
              ggplot(aes(day, mean_sentiment)) + geom_line() + geom_point()
  
#get NRC sentiments
  nrc <-  get_sentiments("nrc") %>%
          mutate(ones=1) %>%
          spread(sentiment, ones)

#join with NRC sentiment engine    
  standouts <-  tweets %>%
                mutate(month=month(date), day=day(date)) %>%
                group_by(month, day, word) %>%
                summarise(wordfreq = n()) %>%
                inner_join(nrc) %>%
                select(month, day, word, wordfreq, anger, anticipation, disgust,  fear, joy, sadness, surprise, trust,negative, positive) %>%
                gather(5:12, key="emotion", value="indicator",na.rm=TRUE) %>%
                gather(5:6, key="posneg", value="posindicator") %>%
                mutate(posnegind = ifelse(posneg == "positive",1,-1)) %>%
                select(month, day, word, wordfreq, emotion, posneg, posnegind)

#retrieve core emotions by day
  emotiontrends <-  standouts %>%
                    group_by(month, day, emotion) %>%
                    summarise(freq = n()) %>%
                    ggplot(aes(x=emotion,y=freq)) + 
                            geom_bar(stat="identity", position = "dodge") + 
                            facet_wrap(~day)

#retrieve most used words and their positive/negative sentiment
  wordtrends <- tweets %>% 
                select(word,sentiment) %>% 
                count(word,sentiment) %>%
                acast(word ~ sentiment, value.var = "n", fill = 0) %>%
                comparison.cloud(colors = c("#F8766D", "#00BFC4"), max.words = 100)
