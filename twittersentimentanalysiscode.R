
consumer_key <- "WB1nXqCI5tuecYHu18DfuKA0n"
consumer_secret <- "RFxnvxCS7n45Pje7w9Th8sYjX8CfvIXyQZ6qypuYZPIGGtFI1a"
access_token <- "1863077642-qYgmfsk5vlqTOpTOzuehLJ3tvZmz1dhUWznIZVy"
access_secret <- "JJzgPSm25Fn0ohUnJfPH0pRolOnewK1N25jC4yGziw2Sp"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)


tuser <- getUser('exxonmobil')
c <- tuser[]