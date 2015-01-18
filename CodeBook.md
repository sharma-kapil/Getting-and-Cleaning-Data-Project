# Getting and Cleaning Data Project Code Book

This Code book describes the variables, the data, and transformations applied to the data to clean up the data.

## Datasource

The datasoruce for the project is at the link below

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The full description of the dataset is at the site

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Data Set

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

The data set includes the following files:

* **README.txt**
* **features_info.txt**: Lists and provides the information for the variables used in the feature vector.
* **features.txt**: List of all features.
* **activity_labels.txt**: Mapping of the labels with their activity name.
* **train/X_train.txt**: Training set.
* **train/y_train.txt**: Training labels.
* **test/X_test.txt**: Test set.
* **test/y_test.txt**: Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- **train/subject_train.txt**: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- **train/Inertial Signals/total_acc_x_train.txt**: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- **train/Inertial Signals/body_acc_x_train.txt**: The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- **train/Inertial Signals/body_gyro_x_train.txt**: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Transformations
The following transformations have to be applied:

1. Merge the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The run_analysis.R go through the following steps to implement the transformations:

1. Load the datasets into dataframes [features.txt, activity_labels.txt, train/X_train.txt, train/y_train.txt, test/X_test.txt, test/y_test.txt]
2. Set descriptive columns from the features dataframe [features.txt] to the training and test dataframes [train/X_train.txt, test/X_test.txt]
3. Subset to get only the std and mean column indexes from the training and test dataframes.
4. Add the column for subject to the training and test dataframes.
5. Add the column for activity to the training and test dataframes.
6. Append the training and test dataframes into a full dataframe.
7. Convert the full dataframe and activity labels dataframes to a data.table to allow quick operations.
8. Set Activity column as the Key for the Full datatable and activity labels datatable to do a quick merge.
9. Merge the Full datatable and the Activity Labels to add the Activity Names for each row.
10. Set Activity name as a key on the Full datatable to preserve the content when you do the mean and group by on all the columns.
11. Create a tidy dataset by doing a lapply across all columns of the full dataset while grouping by activity, subject and activity names columns.
12. Save the tidy data set with no row names.
