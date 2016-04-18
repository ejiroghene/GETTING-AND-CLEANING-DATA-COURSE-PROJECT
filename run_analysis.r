
##Set working directory

setwd("C:/Users/Ejiroghene/Desktop/DataScience/COURSES/Getting And Cleaning Data/UCI HAR Dataset")## set the working directory 


##Read data sets into R

xtest <- read.table("X_test.txt", header = FALSE)
xtrain <- read.table("X_train.txt", header = FALSE)


## load dplyr package

library(dplyr)


##load data into a local data frame tbl_df since I wish to use dpyr package

xtestDf <- tbl_df(xtest) 
xtrainDf <- tbl_df(xtrain)

##Remove the original data frame  from workspace to avoid confusion
rm("xtest")
rm("xtrain")

##Merge the test and train sets
merged_Test_Train <- merge(xtestDf, xtrainDf, all = TRUE)

##Extract measurements on the mean and standard deviation.
##The column numbers correspond to the mean/standard deviation variables in the "features" file of both data sets   
meanStd_TestTrain <- select(merged_Test_Train, V1:V6, V41:V46, V81:V86, V121:V126,
                            V161:V166, V201:V202, V214:V215, V227:V228, V240:V241,
                            V253:V254, V266:V271, V345:V350, V424:V429, V503:V504,
                            V516:V517, V529:V530, V542:V543)





##Appropriately label the data set with descriptive variable names.

library(plyr)

labeled_TestTrain <- rename(meanStd_TestTrain, c("V1"="AVG_XtBodyAcc", "V2"="AVG_YtBodyAcc", "V3"="AVG_ZtBodyAcc", "V4"="STD_XtBodyAcc", "V5"="STD_YtBodyAcc", "V6"="STD_ZtBodyAcc", 
                                                 "V41"="AVG_XtGravityAcc", "V42"="AVG_YtGravityAcc", "V43"="AVG_ZtGravityAcc", "V44"="STD_XtGravityAcc", "V45"="STD_YtGravityAcc", "V46"="STD_ZtGravityAcc",
                                                 "V81"="AVG_XtBodyAccJerk", "V82"="AVG_YtBodyAccJerk", "V83"="AVG_ZtBodyAccJerk", "V84"="STD_XtBodyAccJerk", "V85"="STD_YtBodyAccJerk", "V86"="STD_ZtBodyAccJerk",
                                                 "V121"="AVG_XtGyroAcc", "V122"="AVG_YtGyroAcc", "V123"="AVG_ZtGyroAcc", "V124"="STD_XtGyroAcc", "V125"="STD_YtGyroAcc", "V126"="STD_ZtGyroAcc", 
                                                 "V161"="AVG_XtGyroJerkAcc", "V162"="AVG_YtGyroJerkAcc", "V163"="AVG_ZtGyroJerkAcc", "V164"="STD_XtGyroJerkAcc", "V165"="STD_YtGyroJerkAcc", "V166"="STD_ZtGyroJerkAcc", 
                                                 "V201"="AVG_tBodyAccMag", "V202"="STD_tBodyMag",
                                                 "V214"="AVG_tGravityAccMag", "V215"="STD_tGravityAccMag", 
                                                 "V227"="AVG_tBodyAccJerkMag", "V228"="STD_tBodyAccJerkMag", 
                                                 "V240"="AVG_tBodyGyroMag", "V241"="STD_tBodyGyroMag", 
                                                 "V253"="AVG_tBodyGyroJerkMag", "V254"="STD_tBodyGyroJerkMag", 
                                                 "V266"="AVG_XfBodyAcc", "V267"="AVG_YfBodyAcc", "V268"="AVG_ZfBodyAcc", "V269"="STD_XfBodyAcc", "V270"="STD_YfBodyAcc", "V271"="STD_ZfBodyAcc", 
                                                 "V345"="AVG_XfBodyAccJerk", "V346"="AVG_YfBodyAccJerk", "V347"="AVG_ZfBodyAccJerk", "V348"="STD_XfBodyAccJerk", "V349"="STD_YfBodyAccJerk", "V350"="STD_ZfBodyAccJerk", 
                                                 "V424"="AVG_XfBodyGyro", "V425"="AVG_YfBodyGyro", "V426"="AVG_ZfBodyGyro", "V427"="STD_XfBodyGyro", "V428"="STD_YfBodyGyro", "V429"="STD_ZfBodyGyro", 
                                                 "V503"="AVG_fBodyAccMag", "V504"="STD_fBodyMag",
                                                 "V516"="AVG_fBodyAccJerkMag", "V517"="STD_fBodyAccJerkMag",
                                                 "V529"="AVG_fBodyGyroMag", "V530"="STD_fBodyGyroMag",
                                                 "V542"="AVG_fBodyGyroJerkMag", "V543"="STD_fBodyGyroJerkMag"
)
)


## Select only the average variables 
avgVariables_TestTrain <-select(labeled_TestTrain, contains("AVG"))


library(tidyr)
tidyDataActivityAverage <- gather(avg_TestTrain, Activity, Average )
