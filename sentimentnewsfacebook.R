# install.packages("tidytext")
# install.packages("dplyr")
# install.packages("reshape")
# install.packages("ggplot2")
# install.packages("tidyr")
# install.packages("twitteR")
# install.packages("tm")


require(dplyr)
require(tidytext)
require(reshape)
require(ggplot2)
require(tidyr)
require(twitteR)
require(tm)



#setwd("C:/Users/Rahul/Desktop/dwproject/2018-04-13_FinalStockProject/financialtimes")
df <- read.csv("fbnews.csv",stringsAsFactors = F)
dates <- unique(df$Date)


newdf <- data.frame(Date = as.Date(character()), Headlines = character(), stringsAsFactors = F)

for(i in 1:length(dates))
{
newstext <-  df$Headlines[df$Date == dates[i]]
newstext <- paste(newstext, collapse = " ")
newdf[i,] <- rbind(dates[i],newstext)

}     

nofbdates <- table(newdf$Date)

text_df <- data_frame(date = newdf$Date, text = newdf$Headlines)
#a tokenize them
text_df <- text_df %>% unnest_tokens(word, text)
#Load the dictionaries
afin <- get_sentiments("afinn")
bing <- get_sentiments("bing")
nrc <- get_sentiments("nrc")



#Sentiment analysis with the three lexicons that have been downloaded

afinSent <- text_df %>%
  inner_join(afin) %>%
  group_by(index = date) %>%
  summarise(sentiment = sum(score))
## Joining, by = "word"
bingSent <- text_df %>%
  inner_join(bing) %>%
  count(index = date, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)
## Joining, by = "word"
nrcSent <- text_df %>%
  inner_join(nrc) %>%
  count(index = date, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)




# for(i in 1:length(nofbdates)) {
#   afinSent$sentiment[i] <- afinSent$sentiment[i] / nofbdates[[i]] * 100
#   bingSent$sentiment[i] <- bingSent$sentiment[i] / nofbdates[[i]] * 100
#   nrcSent[i, 2:12] <- nrcSent[i, 2:12] / nofbdates[[i]] * 100
# }

fbnews <- data.frame(afinSent)
fbnews <- merge(fbnews, bingSent[,c("index", "sentiment")], by="index")
fbnews <- merge(fbnews, nrcSent[, c("index", "sentiment")], by="index")
fbnews$Ticker <- rep("FB", times = nrow(fbnews))
names(fbnews) <- c("date", "afinn", "bing", "nrc", "Ticker")


getwd()

write.csv(fbnews, file = "fbsentimentnews.csv")


