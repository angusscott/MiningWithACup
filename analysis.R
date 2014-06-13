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

#labels
#if I can be bothered I'll set this up for every country
countries.of.interest <- c("england","australia","usa","brazil")
codes <- c("en","au","us","br")
labels=rep("",length(country))
labels[match(countries.of.interest,country)]=codes 

#Correlation (absolute)
cor.test(odds, tweets) #gives a PMCC of 0.6-0.7 depending on whether you use tweets or log(tweets)
cairo_pdf("plot.pdf", family="Roboto Slab", width=5, height=5) #saves an image of the basic data+model+countries of interest
  plot(log(odds), log(interest), main="World Cup competitors", xlab="log(odds)", ylab="log(share of tweets)", mgp=c(2.5,1,0))
#  text(log(odds), log(interest), labels, pos=1, offset=0.2)

#Simple linear regression
  model <- lm(log(interest)~log(odds))
  abline(model, col="#A53545", lwd=2) #line of best fit
dev.off()
model.nolog <- lm(interest~odds)
summary(model)

#Diagnostic plots (residuals and QQ) to test normality
oldpar <- par(mfrow=c(1,2))
plot(model, which=c(1,2))
par(oldpar)
