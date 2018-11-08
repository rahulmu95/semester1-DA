getwd()
setwd("C:/Users/Rahul/Desktop/dwproject/2018-04-13_FinalStockProject/1.Original Data")


install.packages("rvest")
library(rvest)


#Top 50 companies by market capitalization as of end of end of 2017
#Website:http://www.iweblists.com/us/commerce/MarketCapitalization.html
#Up-to-Date as of April 2017
#Using top 10 companies to confine the scope of the project

url <- "http://www.iweblists.com/us/commerce/MarketCapitalization.html"
webpage <- read_html(url)



marketcaprank.html <- html_nodes(webpage, '.body:nth-child(1)')
marketcaprank <- html_text(marketcaprank.html)



Companyname.html <- html_nodes(webpage, '.body:nth-child(2)')
companyname <- html_text(Companyname.html)



Ticker.html <- html_nodes(webpage, '.body:nth-child(3)')
ticker <- html_text(Ticker.html)



marketcap.html <- html_nodes(webpage, '.body:nth-child(4)')
marketcap <- html_text(marketcap.html)

#Converting to a data frame with 4 columns
marketcap.df <- data.frame(MarketCapRank = marketcaprank, Company = companyname, Ticker = ticker, MarketCapBillion = marketcap)

#Confining the data frame to top 10 companies
marketcap.df <- marketcap.df[1:10, ]

is.na(marketcap.df)
#returns all false meaning there are no null values
#Manual inspection reveals no errors or missing values


write.csv(marketcap.df, file = "MarketCapRanking.csv")











