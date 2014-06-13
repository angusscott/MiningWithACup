library(RCurl)
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

library(twitteR)
cred <- OAuthFactory$new(consumerKey='ijsMDE7smzdpNiemqlZ3wag8Q',
                         consumerSecret='OXijwNVnrh7kwA5tcGhXrTFASKVGKY7h9kk02kv6drt4FW6Kh3',
                         requestURL='https://api.twitter.com/oauth/request_token',
                         accessURL='https://api.twitter.com/oauth/access_token',
                         authURL='http://api.twitter.com/oauth/authorize')

#handshake (should have info stored so you don't go hunting for the PIN)
load("C:/Users/David/SkyDrive/Documents/Data Science/twitter authentication.Rdata")
registerTwitterOAuth(cred)

#http://www.slideshare.net/jeffreybreen/r-by-example-mining-twitter-for
require(plyr)

#Set up a table and populate it with search counts
predictions <- matrix(data=0, nrow=7, ncol=7)
for (j in 0:6) {
     for (k in 0:6) {
         team1 <- paste("Australia ",j)
         team2 <- paste("Chile ", k)
         prediction <- paste('"',team1,'" "',team2,'"')
         searchResults <- searchTwitter(prediction, n=1500, cainfo="cacert.pem")
         print(prediction)
         print(length(searchResults))
         predictions[j+1,k+1] = length(searchResults)
     }
}
#  
#  text = laply(data, function(t) t$getText())

source("C:/Users/David/SkyDrive/Documents/Data Science/score.r")  #generates the score.sentiment function
tea.scores = score.sentiment(tweets, pos.words, neg.words, .progress='text')
tea.scores$text = gsub('\n',' ',tea.scores$text) #removes pesky linebreaks from tweet text
tea.scores$text = gsub('\t',' ',tea.scores$text) #removes tabs
write.table(tea.scores, file="yorkshiretea.csv", sep="\t", col.names=T,row.names=F)
