library(tidyverse)
library(caret)
library(mlbench)

## split data function

split_data <- function(data){
  
  set.seed(42)
  n <- nrow(data)
  id <- sample(1:n, 0.7*n) 
  train_data <- data[id, ]
  test_data <- data[-id, ]
  return(list(train=train_data, test= test_data))
}

prep_df <- split_data(mtcars)

#k-fold cross vali
set.seed(42)

## this is default - using bootstrap
## ctrl <- trainControl(method="boot",
##                     number = 25) 

## we can change to others
#LOOCV --> train เท่ากับจำนวนdata
## ctrl <- trainControl(method="LOOCV") 

grid_k <- data.frame(k= c(3,5)) #hyperparameter tuning

## K fold CV, and can change number
##ctrl <- trainControl(method="cv",
##                     number = 5,
##                     verboseIter = TRUE # this will print progress of each fold
                     
##                     )

#we can do repeated Kfold CV
ctrl <- trainControl(method="repeatedcv",
                     number = 5,
                     repeats = 5,
                     verboseIter = TRUE ## this will print progress of each fold
                     
)

  
knn <- train(mpg ~ .,
             data = prep_df$train,
             method = "knn",
             metric = "MAE",
             trControl = ctrl,
             tuneGrid = grid_k)


## we can ask program to random k by random search
knn <- train(mpg ~ .,
             data = prep_df$train,
             method = "knn",
             metric = "MAE",
             trControl = ctrl,
             tuneLenth = 3) 

## we can choose metric
### Default will be RMSE but we can change
 
