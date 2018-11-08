#install.packages("twitteR")
library(twitteR)

#Twitter authentication
consumer_key <- "WB1nXqCI5tuecYHu18DfuKA0n"
consumer_secret <- "RFxnvxCS7n45Pje7w9Th8sYjX8CfvIXyQZ6qypuYZPIGGtFI1a"
access_token <- "1863077642-qYgmfsk5vlqTOpTOzuehLJ3tvZmz1dhUWznIZVy"
access_secret <- "JJzgPSm25Fn0ohUnJfPH0pRolOnewK1N25jC4yGziw2Sp"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

# Using the file twitter handles that was manually constructed.

twitterhandles <- read.csv("twitterhandles.csv")
handle <- as.character(twitterhandles$TwitterHandle)

ticker <- as.character(twitterhandles$Ticker)

#Initializing the data frame
companiestwtr <- setNames(data.frame(matrix(ncol = 4, nrow = 0)), c("tweets", "followers", "following", "name" ))

#Extracting only the required columns for understanding the twitter presence of the companies
# Name, followerscount , following count, statuscount
#Getuser function of the twitteR package is used for this purpose
for(i in 1:10)
{
  if(!(handle[i]) == ""){
  
  company <- getUser(as.character(handle[i]))
  company <- as.data.frame(company)
  company <- company[, c(2,3,5,7)] 
  companiestwtr[i, ] <- rbind(company)
  }
  
}


is.na(companiestwtr)
# 5           TRUE           TRUE         TRUE  TRUE
# This happened because Berkshire Hathaway doesnt have an official account
# In order to represent this as another row, it must be manually mended.
# Adding berkshire hathaway as having 0 followers

companiestwtr[5,] <- c(0,0,0,"Berkshire Hathway") 


#Adding the ticker column
companiestwtr$Ticker <- ticker
write.csv(companiestwtr, file = "Twitterprofiles.csv") 

