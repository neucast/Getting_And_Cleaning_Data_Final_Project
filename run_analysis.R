#######################################
# This R script called run_analysis.R does the following:
#
# 1.- Merges the training and the test sets to create one data set.
# 2.- Extracts only the measurements on the mean and standard deviation for each measurement.
# 3.- Uses descriptive activity names to name the activities in the data set
# 4.- Appropriately labels the data set with descriptive variable names.
# 5.- From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
#
# README.md for details.
#######################################


library(dplyr)


#######################################

# Download and unzip data

#######################################

fileName <- "finalProjectDataSet.zip"

# Checking if archieve already exists.
if (!file.exists(fileName)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, fileName, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(fileName) 
}


dataPath <- "UCI HAR Dataset"


#######################################

# Read data

#######################################



# Training data

trainingSubjects <- read.table(file.path(dataPath, "train", "subject_train.txt"))
trainingValues <- read.table(file.path(dataPath, "train", "X_train.txt"))
trainingActivity <- read.table(file.path(dataPath, "train", "y_train.txt"))
bodyAccXTrainData <- read.table(file.path(dataPath, "train/Inertial Signals", "body_acc_x_train.txt"))
bodyAccYTrainData <- read.table(file.path(dataPath, "train/Inertial Signals", "body_acc_y_train.txt"))
bodyAccZTrainData <- read.table(file.path(dataPath, "train/Inertial Signals", "body_acc_z_train.txt"))
bodyGyroXTrainData <- read.table(file.path(dataPath, "train/Inertial Signals", "body_gyro_x_train.txt"))
bodyGyroYTrainData <- read.table(file.path(dataPath, "train/Inertial Signals", "body_gyro_y_train.txt"))
bodyGyroZTrainData <- read.table(file.path(dataPath, "train/Inertial Signals", "body_gyro_z_train.txt"))
totalAccXTrainData <- read.table(file.path(dataPath, "train/Inertial Signals", "total_acc_x_train.txt"))
totalAccYTrainData <- read.table(file.path(dataPath, "train/Inertial Signals", "total_acc_y_train.txt"))
totalAccZTrainData <- read.table(file.path(dataPath, "train/Inertial Signals", "total_acc_z_train.txt"))

# Test data

testSubjects <- read.table(file.path(dataPath, "test", "subject_test.txt"))
testValues <- read.table(file.path(dataPath, "test", "X_test.txt"))
testActivity <- read.table(file.path(dataPath, "test", "y_test.txt"))
bodyAccXTestData <- read.table(file.path(dataPath, "test/Inertial Signals", "body_acc_x_test.txt"))
bodyAccYTestData <- read.table(file.path(dataPath, "test/Inertial Signals", "body_acc_y_test.txt"))
bodyAccZTestData <- read.table(file.path(dataPath, "test/Inertial Signals", "body_acc_z_test.txt"))
bodyGyroXTestData <- read.table(file.path(dataPath, "test/Inertial Signals", "body_gyro_x_test.txt"))
bodyGyroYTestData <- read.table(file.path(dataPath, "test/Inertial Signals", "body_gyro_y_test.txt"))
bodyGyroZTestData <- read.table(file.path(dataPath, "test/Inertial Signals", "body_gyro_z_test.txt"))
totalAccXTestData <- read.table(file.path(dataPath, "test/Inertial Signals", "total_acc_x_test.txt"))
totalAccYTestData <- read.table(file.path(dataPath, "test/Inertial Signals", "total_acc_y_test.txt"))
totalAccZTestData <- read.table(file.path(dataPath, "test/Inertial Signals", "total_acc_z_test.txt"))


# Activity labels

activity <- read.table(file.path(dataPath, "activity_labels.txt"))
colnames(activity) <- c("activityId", "activityLabel")


# Features

features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)


#######################################

# Step 1: Merges the training and the test sets to create one data set.

#######################################

xDataSet <- rbind(trainingValues, testValues)
yDataSet <- rbind(trainingActivity, testActivity)
subjectDataSet <- rbind(trainingSubjects, testSubjects)
mergedDataSet <- cbind(subjectDataSet, yDataSet, xDataSet)

# Remove data tables to save memory
rm(trainingSubjects, trainingValues, trainingActivity, bodyAccXTrainData, bodyAccYTrainData, bodyAccZTrainData, bodyGyroXTrainData, bodyGyroYTrainData, bodyGyroZTrainData, totalAccXTrainData, totalAccYTrainData, totalAccZTrainData,
testSubjects, testValues, testActivity, bodyAccXTestData, bodyAccYTestData, bodyAccZTestData, bodyGyroXTestData, bodyGyroYTestData, bodyGyroZTestData, totalAccXTestData, totalAccYTestData, totalAccZTestData,
xDataSet, yDataSet, subjectDataSet)

# Assign column names
colnames(mergedDataSet) <- c("subject", features[, 2], "activity")


#######################################

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

#######################################


# Determine columns of interest
columnsOfInterest <- grepl("subject|code|activity|mean|std", colnames(mergedDataSet))
mergedDataSet <- mergedDataSet[, columnsOfInterest]


#######################################

# Step 3: Uses descriptive activity names to name the activities in the data set.

#######################################


# Replace activity values with named factor levels
mergedDataSet$activity <- factor(mergedDataSet$activity, levels = activity[, 1], labels = activity[, 2])


#######################################

# Step 4: Appropriately labels the data set with descriptive variable names.

#######################################

# Column names
mergedDataSetCols <- colnames(mergedDataSet)

# No special characters
mergedDataSetCols <- gsub("[\\(\\)-]", "", mergedDataSetCols)

# Clean names
mergedDataSetCols <- gsub("Acc", "Accelerometer", mergedDataSetCols)
mergedDataSetCols <- gsub("angle", "Angle", mergedDataSetCols)
mergedDataSetCols <- gsub("gravity", "Gravity", mergedDataSetCols)
mergedDataSetCols <- gsub("Gyro", "Gyroscope", mergedDataSetCols)
mergedDataSetCols <- gsub("Mag", "Magnitude", mergedDataSetCols)
mergedDataSetCols <- gsub("^f", "frequencyDomain", mergedDataSetCols)
mergedDataSetCols <- gsub("Freq", "Frequency", mergedDataSetCols)
mergedDataSetCols <- gsub("-freq()", "Frequency", mergedDataSetCols)
mergedDataSetCols <- gsub("BodyBody", "Body", mergedDataSetCols)
mergedDataSetCols <- gsub("tBody", "TimeBody", mergedDataSetCols)
mergedDataSetCols <- gsub("^t", "timeDomain", mergedDataSetCols)
mergedDataSetCols <- gsub("mean", "Mean", mergedDataSetCols)
mergedDataSetCols <- gsub("-mean()", "Mean", mergedDataSetCols)
mergedDataSetCols <- gsub("std", "StandardDeviation", mergedDataSetCols)
mergedDataSetCols <- gsub("-std()", "StandardDeviation", mergedDataSetCols)


# Assing labels as column names
colnames(mergedDataSet) <- mergedDataSetCols


#######################################

# Step 5: From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.

#######################################

tidyDataSet <- mergedDataSet %>% group_by(subject, activity) %>% summarise_each(funs(mean))

# Output to file "tidyData.txt"
write.table(tidyDataSet, "tidyData.txt", row.name=FALSE, quote = FALSE)

#######################################

# Final Check

#######################################

# Checking variable names
str(tidyDataSet)

tidyDataSet
