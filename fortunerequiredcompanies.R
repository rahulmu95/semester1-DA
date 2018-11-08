getwd()
#setwd("C:/Users/Rahul/Desktop/dwproject/2018-04-13_FinalStockProject/1.Original Data")


#File containing 
fortune500 <- read.csv("Fortune500-2017.csv")
#Obtaining the ticker from the marketcapranking file for filtering the fortune500file
df <- read.csv("MarketCapRanking.csv")
ticker <- df$Ticker
ticker

#While trying to execute the for loop in the subsequent section, foll error occured
#Error in x[[jj]][iseq] <- vjj : replacement has length zero
#On inspection, it was found that there are conflicting tickers in the files
#Berkshire, Google are listed as multiple shares on NYSE
# But as they represent the same company, it would be safe to assume them as one entity
# Any measure that is additive in nature shall be combined

#Manually changing the ticker of the fortune500 listings as discussed above
# "BRKA" - ticker as per fortune500 file
# "BRK.B" - ticker as per MarketCapRanking


fortune500$Ticker <- as.character(fortune500$Ticker)
fortune500$Ticker[fortune500$Fullname == "Berkshire Hathaway Inc."] <- "BRK.B"

fortune500reqd <- fortune500

for(i in 1:10)
{

tmptckr <- ticker[i]
fortune500reqd[i,c(1:23)] <-  fortune500[grepl(pattern = as.character(tmptckr), as.character(fortune500$Ticker)), ]


}

 nrow(fortune500reqd)
# [1] 10 - matches the ticker count from MarketCapranking
# 10 indicates success-- as in all the required information about the companies has been obtained


#Getting rid of the unnecesary columns in the dataset
#Unnecessary columns in the dataset: Address, Ceo title,revenue change, profit change,Fullname

#Also, the Ticker for Google has been given as GOOGL instead of GOOG
fortune500reqd$Ticker[fortune500reqd$Ticker == "GOOGL"] <- "GOOG"

write.csv(fortune500reqd[1:10,c(-7,-8,-11,-12,-14,-15,-17,-19,-21,-23)], file = "fortune500required.csv")






















