# Course3Project
Contains the script and code book for the Course Project (Week 4) of the Coursera "Getting and Cleaning Data" course

The script run_analysis.R performs the follwing tasks: (as outlined in the instructions)
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names.
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Script Input:
  The data as downloaded and unpacked from:
  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  (date of retrieval: 27.12.2017)

Script Ouput:
  - final-dataset.csv: Contains the final data set.
  - final-dataset-features.csv: contains a list of all variable names of the final dataset.
