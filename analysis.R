setwd("~/GitHub/MiningWithACup")

#Import the data
odds.df <- read.table("odds.csv",header=T, sep=",")
counts.df <- read.table("data.csv",header=T,sep=",")

#Combine into one table
dataset <- data.frame(country=odds.df$country, odds=1/(odds.df$odds), tweets=counts.df$frequency)
attach(dataset)
#Compute proportions rather than absolute counts
dataset$interest <- sapply(tweets, function(x) x/sum(tweets))
attach(dataset)
#sum(interest) # = 1

#Correlation (absolute)
cor.test(odds, tweets) #gives a PMCC of 0.6-0.7 depending on whether you use tweets or log(tweets)
plot(odds, log(tweets), main="World Cup competitors", xlab="Paddy Power odds", ylab="log(# of tweets)")
text(odds, log(tweets), labels=country)

#Simple linear regression
model <- lm(log(tweets)~odds)
summary(model)

#Diagnostic plots (residuals and QQ) to test normality
oldpar <- par
par(mfrow=c(1,2))
plot(model, which=c(1,2))
par(oldpar)
