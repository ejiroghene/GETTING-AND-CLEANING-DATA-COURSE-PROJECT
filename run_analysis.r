
##(Q1). Merge the training and the test sets to create one data set.


## Set the working directory 

setwd("C:/Users/Ejiroghene/Desktop/DataScience/COURSES/Getting And Cleaning Data/UCI HAR Dataset")



##Read the test data set, subject data, and Activity label data into R

dataTest <- read.table("X_test.txt", header = FALSE)
activityTest <- read.table("y_test.txt", header = FALSE)
subjectTest <- read.table("subject_test.txt", header = FALSE)


##Read the train data set, subject data, and Activity label data into R

dataTrain <- read.table("X_train.txt", header = FALSE)
activityTrain <- read.table("y_train.txt", header = FALSE)
subjectTrain <- read.table("subject_train.txt", header = FALSE)

##Load dplyr package in order to manipulate the data

library(dplyr)

TestDf <- tbl_df(dataTest)
TrainDf <- tbl_df(dataTrain)

activitytestDf <- tbl_df(activityTest)
subjectTestDf <- tbl_df(subjectTest)

activityTrainDf <- tbl_df(activityTrain)
subjectTrainDf <- tbl_df(subjectTrain)


library(plyr)

##Rename the variables(columns) in the test and train activity label and subject data frames since the columns don't have names. 

activityTestDf <- rename(activitytestDf, c("V1" = "Activity"))
subjectTestDf<- rename(subjectTest, c("V1" = "Subject"))

activityTrainDf <- rename(activityTrainDf, c("V1" = "Activity"))
subjectTrainDf<- rename(subjectTrainDf, c("V1" = "Subject"))

test <- cbind(activityTestDf, subjectTestDf, TestDf)
train <- cbind(activityTrainDf, subjectTrainDf,TrainDf)


##Merge the test and train data frame 

testTrain <- merge(test, train, all = TRUE)





##After the merge it was noticed that "Activity" and "Subject variables were 
##placed in the 1st & 2nd indexes respectively, this 
##may affect the  manipulaaton of the data set since these varibles were not included in the original 
##features.txt file that has indices of 1:561. 

##Reorder the data frame so that "Activity" and "Subject" variables will be the last two variables

testTrain <- testTrain[, c(3:563,1,2)]


##Q2). Extract only the measurements on the mean and standard deviation for each measurement.

##Read the features.txt dataframe into R

variableNames <- read.table("features.txt", header = FALSE)



# The columns are filterd out from  "variableNames" by getting a list of 
##indices indicating the positions occupied by column names with mean or standard deviation.


meanStdColIndices <- grep("mean|std", variableNames$V2, value = FALSE) 


##Get a subset of the merged data that has  columns with mean/std
##(ie the extracted data with only mean and standard deviation variables)

testTrain_Mean_Std <- testTrain[, c(1, 2, 3,  4, 5, 6,  41,  42, 43, 44, 45, 46, 81, 82, 83, 84, 85, 86,
                                    121, 122, 123, 124, 125, 126, 161, 162,163, 164, 165, 166, 201, 202, 214, 215, 227, 228,
                                    240, 241, 253, 254, 266, 267, 268, 269, 270, 271, 294, 295, 296, 345, 346, 347,348, 349,
                                    350, 373, 374, 375, 424, 425, 426, 427, 428, 429, 452, 453, 454, 503, 504, 513, 516, 517,
                                    526, 529, 530, 539, 542, 543,552)]





##Q3). Use descriptive activity names to name the activities in the data set

##Assign activity to each of the corresponding figure as given in activity_label.txt file.

testTrain$Activity[testTrain$Activity == 1] <- 'WALKING'
testTrain$Activity[testTrain$Activity == 2] <- 'WALKING_UPSTAIRS'
testTrain$Activity[testTrain$Activity == 3] <- 'WALKING_DOWNSTAIRS'
testTrain$Activity[testTrain$Activity == 4] <- 'SITTING'
testTrain$Activity[testTrain$Activity == 5] <- 'STANDING'
testTrain$Activity[testTrain$Activity == 6] <- 'LAYING'




##Q4). Appropriately label the data set with descriptive variable names. 

mean_Std_Names <- grep("mean|std", variableNames$V2, value = TRUE) 





testTrainDf <- tbl_df(testTrain)


varNames <- select(variableNames,  V2)


colnames(testTrainDf) <- varNames[1:561,]
colnames(testTrainDf)[562] <- "Activity"
colnames(testTrainDf)[563] <- "Subject"



##Remove any occurence of duplicate variable name since this a common occurrence with joined/merged data set

colnames(testTrainDf) = make.names(colnames(testTrainDf), unique=TRUE)


##From the data set in step 4, create a second, independent tidy data set with 
##the average of each variable for each activity and each subject.


tidyData<- (testTrainDf%>%
              group_by(Subject,Activity) %>%
              summarise_each(funs( mean)))

