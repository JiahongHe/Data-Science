# README

## Getting and Cleaning Data Course Project  

Data for the project:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
After downloading the .zip file, extract "train" and "test" folder to the same directory as run_analysis.R and modify the variable "directory" in run_analysis.R to the direcoty this script is in.  

run_analysis.R does the following:

1.Merges the training and the test sets to create one data set.  
2.Extracts only the measurements on the mean and standard deviation for each measurement.  
3.Uses descriptive activity names to name the activities in the data set. 
4.Appropriately labels the data set with descriptive activity names.  
5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

### Run the script  
After downloading the .zip file, extract "train" and "test" folder to the same directory as run_analysis.R and modify the variable "directory" in run_analysis.R to the direcoty this script is in.   

### How Data is Processed
1. For both the test and train folder, get all the path to the files, read in all the text file using read.table(), as 3 data frames (feature, activity, subject), and then bind them together with rbind().
2. After step 1, we get 2 data frames (for files in "train" folder and "test" folder), bind them together with rbind().
3. Put each variable on its own row.
4. Rejoin the data frame, with key on subject/acitivity pairs, applying the mean() to each ubject/acitivity pair, as the final result data frame.
5. Write the result data to a local file.

