# Course 3 Project - Getting and Cleaning Data
# Create one R script called run_analysis.R
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Pre-Conditions:
# This script assumes that the dataset below has been downloaded as "data.zip" and unzipped.
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# The script should be saved / run from the folder where the dataset has been unzipped.

# Change the working directory to the correct folder on your machine
setwd("C:\\Users\\monk\\Documents\\Kapil\\Education\\Course 3\\Course3-Project")

#Uses the data.table library. Install the package if it not already loaded.
if (!require("data.table")) {
  install.packages("data.table")
}
require("data.table")

#Load the data sets
X_train<-read.table(".\\UCI HAR Dataset\\train\\X_train.txt", sep = "")
Y_train<-read.table(".\\UCI HAR Dataset\\train\\y_train.txt", sep = "")
subject_train<-read.table(".\\UCI HAR Dataset\\train\\subject_train.txt", sep = "")
X_test<-read.table(".\\UCI HAR Dataset\\test\\X_test.txt", sep = "")
Y_test<-read.table(".\\UCI HAR Dataset\\test\\y_test.txt", sep = "")
subject_test<-read.table(".\\UCI HAR Dataset\\test\\subject_test.txt", sep = "")
features <- read.table(".\\UCI HAR Dataset\\features.txt", sep = "")
activity_labels <- read.table(".\\UCI HAR Dataset\\activity_labels.txt", sep = "")

#Set descriptive column names
colnames <- as.character(features[, 2])
setnames(X_train,colnames)
setnames(X_test,colnames)
setnames(activity_labels,c("activity","activityname"))

#Subset to get only the std and mean columns 
colindex <- sort(append(grep ("*std*",features[,2]),grep ("*mean*",features[,2])))
X_train<-X_train[,colindex]
X_test<-X_test[,colindex]

# Add Column Subject
X_train[,"subject"]<-subject_train
X_test[,"subject"]<-subject_test

# Add Column Activity
X_train[,"activity"]<-Y_train
X_test[,"activity"]<-Y_test

#Append the two data sets
X_full<- rbind(X_train,X_test)

#Convert to data.table
X_full <- data.table(X_full)
activity_labels <- data.table(activity_labels)

#Set Key to activity in both X_test and activity labels datset to make the merge 
setkey(X_full,activity)
setkey(activity_labels,activity)

#Merge the two data tables to add the Activity Names for each row
X_full<-merge(X_full,activity_labels)

#Remove the unused data sets
rm(X_train,Y_train,X_test,Y_test,activity_labels,features,subject_test,subject_train,colindex,colnames)

#Set Key for subject and activity name column 
setkey(X_full,subject,activityname)

#Create tidy data set with the average of each variable for each activity and each subject
#   Activity  Subject AverageMean1 AverageStd1.....
X_Avg_tidy <- X_full[, lapply(.SD,mean), by=c("activity","subject","activityname")]
X_Avg_tidy<-X_Avg_tidy[order(activity,subject)]

#Write the Tidy Data set as a csv with no rownames
write.csv(X_Avg_tidy,"./tidy_data.txt",row.names=FALSE)

#Clean up the remaining datasets
rm (X_Avg_tidy,X_full)