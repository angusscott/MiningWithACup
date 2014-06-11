setwd("~/GitHub/MiningWithACup")

#Import the data
odds.df <- read.table("odds.csv",header=T, sep=",")
counts.df <- read.table("data.csv",header=T,sep=",")

#Combine into one table
dataset <- data.frame(country=odds.df$country, odds=1/(odds.df$odds), tweets=counts.df$frequency)
attach(dataset)

#Correlation
cor.test(odds, tweets) #gives a PMCC of 0.6-0.7 depending on whether you use tweets or log(tweets)

#Attempt simple linear regression
#Given 'tweets' is the dependent variable
plot(odds,log(tweets))
model <- lm(log(tweets)~odds)
summary(model)

#Diagnostic plots (residuals and QQ)
oldpar <- par
par(mfrow=c(1,2))
plot(model, which=c(1,2))
par(oldpar)
