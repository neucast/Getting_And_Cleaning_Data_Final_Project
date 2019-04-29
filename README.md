# Getting_And_Cleaning_Data_Final_Project
# Coursera *Getting and Cleaning Data* course final project

One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here is the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


In this project, data collected from the accelerometer was retrieved, worked with, and cleaned, to prepare a tidy data that can be used for later analysis.

The repository contains:

- `README.md`, this file.
- `tidyData.txt`, which contains the data set.
- `CodeBook.md`, the code book, which describes the contents of the data set.
- `run_analysis.R`, the R script that was used to create the data set (see the [Creating the data set](#creating-data-set) section below) 

## Creating the data set <a name="creating-data-set"></a>

The R script `run_analysis.R` can be used to create the data set.

- 1. Download and unzip source data.
- 2. Read the data.
- 3. Merges the training and the test sets to create one data set.
- 4. Extracts only the measurements on the mean and standard deviation for each measurement.
- 5. Uses descriptive activity names to name the activities in the data set
- 6. Appropriately labels the data set with descriptive variable names.
- 7. From the data set in step 6, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- 8. Write the data set to the `tidyData.txt` file.

The `tidyData.txt` in this repository was created by running the `run_analysis.R` script using R version 3.5.3 (2019-03-11) -- "Great Truth" on Windows 10 64-bit edition.

This script requires the `dplyr` package (version  0.8.0.1 was used).