# ==============================================================================
# Getting and Cleaning Data, Final Project
# Oliver Baumfeld
# 
# This script ontains the code for the final projet of the Getting and Cleaning 
# Data course on coursera. 
# 
# Input:
#   The data as downloaded and unpacked from:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#   (date of retrieval: 27.12.2017)
#
# Ouput:
#   - final-dataset.csv: Contains the final data set.
#   - final-dataset-features.csv: contains a list of all variable names of the final dataset.
# 
# The script performs the follwing tasks:
#  1. Merges the training and the test sets to create one data set.
#  2. Extracts only the measurements on the mean and standard deviation for each measurement.
#  3. Uses descriptive activity names to name the activities in the data set
#  4. Appropriately labels the data set with descriptive variable names.
#  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# ==============================================================================

library(tidyverse)

input_folder <-  "/Users/oliverbaumfeld/Documents/99 Coursera Data Science Course/Course 3 Getting and Cleaning Data/UCI HAR Dataset/"
output_folder <-  "/Users/oliverbaumfeld/Documents/99 Coursera Data Science Course/Course 3 Getting and Cleaning Data/"

# Loading Data =================================================================

# get feature names
file_name <- "features.txt"
feature_names <- read_table2(paste0(input_folder, file_name), 
                             col_names=FALSE)
feature_names <- feature_names[[2]]

# get activity names/labels
file_name <- "activity_labels.txt"
activity_labels <- read_table2(paste0(input_folder, file_name), 
                               col_names=c("number", "description"))
activity_labels$description <- tolower(activity_labels$description)

## Load test data set
file_name <-  "test/X_test.txt"
test_x <- read_table2(paste0(input_folder, file_name), 
                      col_names=feature_names)

file_name <- "test/y_test.txt"
test_y <- read_table2(paste0(input_folder, file_name),
                      col_names = c("activity"))

file_name <- "test/subject_test.txt"
test_subject <- read_table2(paste0(input_folder, file_name),
                            col_names = c("subject"))

## load training data set
file_name <-  "train/X_train.txt"
train_x <- read_table2(paste0(input_folder, file_name), 
                       col_names=feature_names)

file_name <- "train/y_train.txt"
train_y <- read_table2(paste0(input_folder, file_name),
                       col_names = c("activity"))

file_name <- "train/subject_train.txt"
train_subject <- read_table2(paste0(input_folder, file_name),
                             col_names = c("subject"))

# Transform and Tidy Data ======================================================

# Join subject, activity and measurements data sets
if (nrow(test_x) == nrow(test_y) && nrow(test_x) == nrow(test_subject)) {
    test <- bind_cols(test_subject, test_y, test_x)
} 

if (nrow(train_x) == nrow(train_y) && nrow(train_x) == nrow(train_subject)) {
    train <- bind_cols(train_subject, train_y, train_x)
}

#  Merge training and test data sets
if (ncol(test) == ncol(train)) {
    all_data <- bind_rows(test, train)
}

# Change names of the activity variable from numbers to names.
all_data$activity <- plyr::mapvalues(all_data$activity,
                                     from = activity_labels$number,
                                     to = activity_labels$description)

# Get all features that have "mean()" or "std()" in the variable name plus
# subject and activity.
data_meanstd <- select(all_data,
                       subject,
                       activity,
                       feature_names[grep("(mean|std)\\(\\)", feature_names)])

# Calculate the average of each variable for each activity and each subject.
final_dataset <- data_meanstd %>%
    group_by(subject, activity) %>%
    summarise_all(mean)

# Generate Output ==============================================================

# write final data set to csv file
write_csv(final_dataset,
          paste0(output_folder, "final-dataset.csv"))

# write list of variables in the final data set to csv file
write_csv(tibble(variable_names = names(final_dataset)), 
          paste0(output_folder, "final-dataset-features.csv"))

