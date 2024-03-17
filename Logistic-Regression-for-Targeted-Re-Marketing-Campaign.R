rm(list=ls())   # Clean environment
setwd("C:/Users/Abhishek/Desktop/IMT 562/Case Assignment 6 Coca Cola")

#Importing dependencies and importing data
library(dplyr)
library(caret)
library(pROC)
library(ggplot2)
library(neuralnet)
library(nnet)
cocacola=read.csv(file = "cocacola.csv", stringsAsFactors = FALSE)

#Feature engineering and train-test split
cocacola$speedavg=(cocacola$speeddown+cocacola$speedup)/2
cocacola$omev=cocacola$oldmodel*cocacola$eightvalve
set.seed(12345)
train=cocacola[cocacola$training==1,]
test=cocacola[cocacola$training==0,]

#Modeling
logit4=glm(buy1~factor(state)+ factor(type) + speeddown + last + numords + dollars + sincepurch + oldmodel*eightvalve + refurb +income+ medhvalue,
           family=binomial(link='logit'), data=train)
test$logit4=predict.glm(logit4, test, type = "response")
train$logit4=predict.glm(logit4, train, type = "response")   
summary(logit4) 

#Comparing train and test set AUC to check for overfitting
roc_logit4_train <- roc(train$buy1, train$logit4)
roc_logit4_test <- roc(test$buy1, test$logit4)
auc(roc_logit4_train)
auc(roc_logit4_test) #AUC for train and test set are similar indicating that the model is not overfit      


#Evaluating profitability on the test set
net_rev=786 #Net revenue per sale, per customer
marketing_cost=20 #Cost of reaching out to a customer
breakeven_prob=marketing_cost/net_rev #Minimum response rate to ensure profitability 
profit_baseline=(sum(test$buy1)*net_rev)-(length(test$buy1)*marketing_cost) #Baseline profit when targeting all possible targets - $191K
logit4_targets=test[test$logit4>=breakeven_prob,] #Filtering, ony keeping customers with purchase probability greater than the breakeven rate 
profit_logit4=(sum(logit4_targets$buy1)*net_rev)-(length(logit4_targets$buy1)*marketing_cost) #Profit in the targeted outreach scenario - $298K
profit_logit4  

#Creating the final target list
cocacola_prob=rbind(train,test) #Combining train and test in order to create the complete target list
cocacola_prob$logit4=cocacola_prob$logit4/2 #Halving the predicted probability of response by half to account for the reduced response rate in the second wave 
cocacola_prob$logit_target_wave2=with(cocacola_prob,ifelse(buy1==1,0,ifelse(logit4>=breakeven_prob,1,0))) #Setting target flag to 1 for customers with response rate greater than the breakeven rate
cocacola_prob$profit=with(cocacola_prob,ifelse(logit_target_wave2==1,logit4*786-20,0)) #Evaluating the profitability
sum(cocacola_prob$profit) #$268K
