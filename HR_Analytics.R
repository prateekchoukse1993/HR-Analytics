library(readr)
library(mlbench)
library(readr)
library(caTools)
library(ROCR)
library(caret)
library(pROC)
library(mice)
library(xlsx)
HR_comma_sep <- read_csv("C:/Users/PrateekChoukse/Desktop/MS BAPM/Project/human-resources-analytics/HR_comma_sep.csv")


final_data = data.frame(model.matrix(~., data = HR_comma_sep, contrasts.arg = NULL))

split <- sample.split(final_data,SplitRatio = 0.75)
Data_Training <- subset(final_data,split==TRUE)
Data_Testing <- subset(final_data,split==FALSE)


#logistic regression
#model <- glm(Data_Training$left~.,binomial,Data_Training)

#Classification tree
#model <- rpart(Data_Training$left~., data=Data_Training, method='class')

#random forest
set.seed(415)
model <- randomForest(left~.,
                    data=Data_Training, 
                    importance=TRUE, 
                    ntree=2000)

summary(model)

#For logistic regression
#predictions <- predict(object=model, Data_Testing, type='response')

#For classification tree
#predictions <- predict(object=model, Data_Testing, type='prob')


#For random forrest
predictions <- predict(object=model, Data_Testing)

table(Data_Testing$left, predictions > 0.5)
#0.988 accuracy