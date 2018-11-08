install.packages("alphavantager")
library(alphavantager)
#getwd()
#setwd("C:/Users/Rahul/Desktop/dwproject/2018-04-13_FinalStockProject/1.Original Data")

# Set API Key for alphavanatge API

av_api_key("58YDOV3AR8PE16CD")

# Get Time Series Data for the top 20 US based companies by Market Capitaliztion

# function for retrieving the data from the top 20 companies using the API

###setwd("C:/Users/Rahul/Desktop/dwproject/2018-04-13_FinalStockProject/1.Original Data")


#Columns for using in the Api function call
#df <- read.csv("MarketCapRanking.csv")
#Ticker <- df$Ticker
#Ticker <- as.character(Ticker)
Ticker <- c("AAPL","GOOG","MSFT","AMZN","BRK.B","FB","JPM","JNJ","XOM","BAC","V","WMT","INTC","WFC","CVX","UNH","PFE","T","CSCO","PG")
#Companies <- df$Company
#Companies <- as.character(Companies)
Companies <- c("Apple Inc.","Alphabet Inc","Microsoft Corp.","Amazon.com Inc.","Berkshire Hathaway","Facebook, Inc.","JPMorgan Chase & Co.","Johnson & Johnson","Exxon Mobil Corp.","Bank of America Corp","Visa Inc.","Wal-Mart Stores","Intel Corp.","Wells Fargo","Chevron Corp.","United Health Group Inc.","Pfizer Inc.","AT&T Inc.","Cisco Systems","Procter & Gamble")  
#Function for getting the data
getdata <- function(symbl){
  
  data <- av_get(symbol = symbl, av_fun = "TIME_SERIES_DAILY", outputsize = "full", datatype = "csv" )
  return (as.data.frame(data))
  
}


#In the loop, confine the data to last five years, from '2013-04-17' to  '2018-04-18'



for(i in 1:10)
{
  stockhist <- getdata(symbl = as.character(Ticker[i]))
  stockhist <- stockhist[stockhist$timestamp > '2013-04-17' & stockhist$timestamp < '2018-04-18', ]
  stockhist$Ticker <- rep( x = as.character(Ticker[i]), times = nrow(stockhist))
  write.csv(stockhist, file =  paste(Companies[i], ".csv", sep = ""))
  #Adding a small delay to reduce frequency of calls made to the API
  Sys.sleep(0.3)
}










