library(dplyr)
library(dummies)
library(caret)

data <- read.csv("titanic.csv")
data <- data %>% select(Survived, Pclass, Sex, Age, Fare)
data <- dummy.data.frame(data, names  = c("Sex"))
data[is.na(data$Age),"Age"]<- median(data$Age, na.rm=TRUE)

ctrl <- trainControl(
  method = "repeatedcv",
  number = 5,
  repeats = 5)

set.seed(23)
fit <- train(Survived ~ .,
             data = data,
             method = "rf",
             trControl = ctrl,
             ntree = 10)

meanFares <- data %>% group_by(Pclass) %>% summarise(Fare = mean(Fare))

getFare <- function(selectedClass){
  as.double(meanFares %>% filter(Pclass == selectedClass) %>% select(Fare))
}

getFareInfo <- function(selectedClass) {
  fare <- getFare(selectedClass)
  fare_formatted <- format(round(fare, 2), nsmall = 2)
  paste("Price: ", fare_formatted)
}

calculateSurvivability <- function(class, sex, age) {
  submited_data <- data_frame(Pclass = class, 
                              Age = age, 
                              Fare = getFare(class), 
                              Sexfemale = as.integer(sex=="female"), 
                              Sexmale = as.integer(sex=="male")  )
  
  predicted_survivability <- as.double(predict(fit,submited_data))
  if(predicted_survivability > 1) predicted_survivability = 1.0
  if(predicted_survivability < 0) predicted_survivability = 0.0
  predicted_survivability
}

getSurvivabilityAsPercent <- function(class, sex, age) {
  survivability <- calculateSurvivability(class, sex, age)
  paste(format(round(survivability, 4) * 100, nsmall = 2), "%")
}

getFormattedSurvivability <- function(class, sex, age) {
  survivability <- getSurvivabilityAsPercent(class, sex, age)
  paste("Chance to survive: ", survivability)
}
