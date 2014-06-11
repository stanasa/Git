##Binomial regression and Neural Net
#install.packages("neuralnet")

#libraries to be used
library(ggplot2)
library(neuralnet)
library(gvlma)
library(gridExtra)

set.seed(1234567890)

setwd("/Users/Serban/Documents/OneDrive/Foo/Neural Net")
dataset <- read.csv("creditset.csv")
head(dataset)



#Defaults are quite common in the dataset: about 10%
table(dataset$default10yr)
summary(dataset)
summary(dataset[dataset$default10yr==1,])
summary(dataset[dataset$default10yr==0,])


dataset$oldLTI <- dataset$LTI
dataset$LTI <- dataset$LTI * 100


#Loans to income perpendicular (no collinearity)
p <- ggplot(dataset, aes(x=age,y=LTI, color=factor(default10yr)))
p <- p + geom_point() + scale_color_discrete() + ylab("Loan to Income Ratio (%)")+xlab("Age") + labs(color="10 Year Default:")+ ggtitle("Original Data")
p
cor(dataset$LTI,dataset$age)
#But both correlate highly with default:
cor(dataset$LTI,dataset$default10yr)
cor(dataset$age,dataset$default10yr)


#########################Linear Regression!

#linear methods...
summary(lm1 <- lm(default10yr~LTI+age, dataset))
##..don't work well
gvmodel <- gvlma(lm1) 
summary(gvmodel)
##model violates most linar regression assumptions!

##Generate test data
a<-NULL
for(i in 18:64){a <- c(a,t(rep(i,20)))}
newdata2 <- with(dataset, data.frame(LTI = rep(seq(from = 0, to = 20, length.out = 100)), age = mean(age)))
newdata2 <- with(dataset, data.frame(LTI = rep(seq(from = 0, to = 20, length.out = 20),47), age=a))
dim(newdata2)

newdata3<-  cbind(newdata2, predict(lm1, newdata2, interval = "prediction"))
summary(newdata3)
 r0 <- ggplot(newdata3, aes(x=age,y=LTI, color=fit))
 r0 <- r0 + geom_point()  +scale_color_gradient(low="brown1",high="cyan")+ ylab("Loan to Income Ratio (%)")+xlab("Age") + labs(color="10 Year Default:")
 r0
# Predicts negative values! 
# Max prediction is .63!

#Let's be generous and assume that the linear regression returns a probability...
#Can't have negative probabilities
newdata3$fit[newdata3$fit<=0] <- 0.0000001  #Clear negative values to avoid NAs.
newdata3$prediction <-  rbinom(n = dim(newdata3)[1], size=1, prob=newdata3$fit)
predictions1 <- newdata3[newdata3$age<35 & newdata3$LTI>=12,]
predictions2 <- newdata3[!(newdata3$age<35 & newdata3$LTI>=12),]
res.set1 <- table(predictions1$prediction)  
res.set2 <- table(predictions2$prediction)

names(res.set1) <-  c("False Negatives","True Positives")
names(res.set2) <-  c("True Negatives","False Positives")
res.set1
res.set2
Correct <- res.set1[2] + res.set2[1]
Incorrect <- res.set1[1] + res.set2[2]
Linear.Result <- cbind(Correct, Incorrect, rownames=NULL)
Linear.Result <- round(Linear.Result/sum(Linear.Result),3)
rownames(Binomial.Result) <- "Ratio"
Linear.Result

r1 <- ggplot(newdata3, aes(x=age,y=LTI, color=factor(prediction)))
r1 <- r1 + geom_point()  + ylab("Loan to Income Ratio (%)")+xlab("Age") + labs(color="10 Year Default:")+ scale_color_discrete()+ ggtitle("Linear Regression")
r1
##18% of Predictions are wrong!
##Even worse, only half of true positives IDed! Not good at all!

######################################Binomial Regression:

#Binomial logit works better:
model1 <- glm(default10yr~LTI+age, dataset, family=binomial(logit))
summary(model1)
confint(model1)
exp(cbind(OR = coef(model1), confint(model1))) #Odds ratios


#We get the estimates on the link scale and back transform both the predicted values and confidence limits into probabilities.

newdata4 <- cbind(newdata2, predict(model1, newdata = newdata2, type = "link",
                                    se = TRUE))
newdata4 <- within(newdata4, {
  PredictedProb <- plogis(fit)
  LL <- plogis(fit - (1.96 * se.fit))
  UL <- plogis(fit + (1.96 * se.fit))
})

##The Logistic distribution with location = m and scale = s has distribution function
# F(x) = 1 / (1 + exp(-(x-m)/s))

newdata4$fit <- rbinom(n=dim(newdata4)[1], size=1,prob=newdata4$PredictedProb)
newdata4 <- round(newdata4,3)
newdata4[newdata4$age==25,]
newdata4[newdata4$age==30,]
newdata4[newdata4$age==45,]

#Remeber our data structure:
p
newdata4[newdata4$age==25 & newdata4$LTI>=12,]  #should all be 1s. 

#Not bad, but far from a perfect predictor.
predictions1 <- newdata4[newdata4$age<35 & newdata4$LTI>=12,]
predictions2 <- newdata4[!(newdata4$age<35 & newdata4$LTI>=12),]
res.set1 <- table(predictions1$fit)  
res.set2 <- table(predictions2$fit)

names(res.set1) <-  c("False Negatives","True Positives")
names(res.set2) <-  c("True Negatives","False Positives")
res.set1
res.set2
Correct <- res.set1[2] + res.set2[1]
Incorrect <- res.set1[1] + res.set2[2]
Binomial.Result <- cbind(Correct, Incorrect, rownames=NULL)
Binomial.Result <- round(Binomial.Result/sum(Binomial.Result),3)
rownames(Binomial.Result) <- "Ratio"
Binomial.Result

r2 <- ggplot(newdata4, aes(x=age,y=LTI, color=factor(fit)))
r2 <- r2 + geom_point()  + ylab("Loan to Income Ratio (%)")+xlab("Age") + labs(color="10 Year Default:")+ scale_color_discrete()+ ggtitle("Binomial Logit")
r2

grid.arrange(p, r1,r2, nrow=2, ncol=2)


#################################Neural Network Methods:

## extract a set to train the NN
trainset <- dataset[1:800, ]

## select the test set
testset <- dataset[801:2000, ]

creditnet <- neuralnet(default10yr ~ LTI + age, trainset, hidden = 4, lifesign = "minimal", 
                       linear.output = FALSE, threshold = 0.05)

plot(creditnet, rep = "best")


## test the resulting output
temp_test <- subset(testset, select = c("LTI", "age"))

creditnet.results <- compute(creditnet, temp_test)

results <- data.frame(actual = testset$default10yr, prediction = creditnet.results$net.result, age=testset$age, LTI=testset$LTI)
results$prediction <- round(results$prediction)

results$Match <- with(results, {Match = ifelse(actual==prediction, "Prediction Match",ifelse(actual==0 & prediction ==1, "False positive","False negative") 
                                               )})
cat("Test Sample results:")
round(table(results$Match)/sum(table(results$Match)),3)

p1 <- ggplot(results, aes(x=age,y=LTI, color=factor(prediction)))
p1 <- p1 + geom_point()  + ylab("Loan to Income Ratio (%)")+xlab("Age") + labs(color="10 Year Default:")+ scale_color_discrete()+ ggtitle("Neural Net on Test Subset")
p1

grid.arrange(p,p1, nrow=1, ncol=2)


### Test against the artificial toy dataset we tested the other models against:
temp_test2 <- subset(newdata2, select = c("LTI", "age"))
creditnet.results2 <- compute(creditnet, temp_test2)
newdata2$default10yr <- ifelse(newdata2$age<35 & newdata2$LTI>=12, 1, 0)
results2 <- data.frame(actual = newdata2$default10yr, prediction = creditnet.results2$net.result, age=newdata2$age, LTI=newdata2$LTI)
results2$prediction <- round(results2$prediction)

results2$Match <- with(results2, {Match = ifelse(actual==prediction, "Prediction Match",ifelse(actual==0 & prediction ==1, "False positive","False negative") 
)})
cat("Final results:")
round(table(results2$Match)/sum(table(results2$Match)),3)


r3 <- ggplot(results2, aes(x=age,y=LTI, color=factor(prediction)))
r3 <- r3 + geom_point()  + ylab("Loan to Income Ratio (%)")+xlab("Age") + labs(color="10 Year Default:")+ scale_color_discrete()+ ggtitle("Neural Net")
r3

grid.arrange(p, r1,r2,r3, nrow=2, ncol=2)



