---
title: "Getting and Cleaning Data Project README"
author: "Kapil Sharma"
date: "Sunday, January 18, 2015"
output: html_document
---

## Course Project 

Project for the Getting and Cleaning Data Course.

Use the data set from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The data set includes the following key files:

* **README.txt**
* **features_info.txt**: Lists and provides the information for the variables used in the feature vector.
* **features.txt**: List of all features.
* **activity_labels.txt**: Mapping of the labels with their activity name.
* **train/X_train.txt**: Training set.
* **train/y_train.txt**: Training labels.
* **test/X_test.txt**: Test set.
* **test/y_test.txt**: Test labels.

The project is to create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps
1. Create a Project folder on your local disk.
2. Download the source dataset on the local disk into a Project folder. 
3. Unzip the data set in the Project folder (./UCI HAR Dataset/...).
4. Copy run_analysis.R in the Project folder(./run_analysis.R)
5. Set the working directory to the Project folder in RStudio
6. Run run_analysis.R in RStudio. This code uses the data.table library and it installs it automatically.
7. run_analysis should create the tidy_data.txt file in the Project Folder. This file is in the CSV format.
