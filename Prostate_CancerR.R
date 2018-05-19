# K-Nearest Neighbors (K-NN)

# Importing the dataset
dataset = read.csv('Prostate_Cancer.csv')
dataset = dataset[2:10]

x= unique(dataset$diagnosis_result)
# Encoding the target feature as factor
dataset$diagnosis_result = factor(dataset$diagnosis_result,
                                  levels = c('B','M'),
                                  labels = c(1,2))

# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$diagnosis_result, SplitRatio = 0.75)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
training_set[-1] = scale(training_set[-1])
test_set[-1] = scale(test_set[-1])

#making the model
library(class)
y_pred = knn(train = training_set[, -1],
             test = test_set[, -1],
             cl = training_set[,1],
             k = 5,
             prob = TRUE)

# Making the Confusion Matrix
cm = table(test_set[, 1], y_pred)

# confusion matrix result
#     1  2
# 1   6  4
# 2   3 13
