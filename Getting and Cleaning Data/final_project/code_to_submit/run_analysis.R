# train/test data folders are in the same directory as this R script

library(reshape2)

feature_file_name = function (name) {
  paste0("X_", name, ".txt")
}

activity_file_name = function (name) {
  paste0("Y_", name, ".txt")
}

subject_file_name = function (name) {
  paste0("subject_", name, ".txt")
}



features = c(1, 2, 3, 4, 5, 6, 41, 42, 43, 44, 45, 46, 81, 82, 83, 84, 85, 86, 121, 122, 123, 124, 125, 126, 161, 162, 163, 164, 165, 166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 266, 267, 268, 269, 270, 271, 345, 346, 347, 348, 349, 350, 424, 425, 426, 427, 428, 429, 503, 504, 516, 517, 529, 530, 542, 543)
feature_names = c("tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z", "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z", "tGravityAcc-std()-X", "tGravityAcc-std()-Y", "tGravityAcc-std()-Z", "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z", "tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z", "tBodyGyro-mean()-X", "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z", "tBodyGyro-std()-X", "tBodyGyro-std()-Y", "tBodyGyro-std()-Z", "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z", "tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z", "tBodyAccMag-mean()", "tBodyAccMag-std()", "tGravityAccMag-mean()", "tGravityAccMag-std()", "tBodyAccJerkMag-mean()", "tBodyAccJerkMag-std()", "tBodyGyroMag-mean()", "tBodyGyroMag-std()", "tBodyGyroJerkMag-mean()", "tBodyGyroJerkMag-std()", "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z", "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z", "fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z", "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y", "fBodyAccJerk-std()-Z", "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z", "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z", "fBodyAccMag-mean()", "fBodyAccMag-std()", "fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-std()", "fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-std()", "fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-std()")

activities = c(1, 2, 3, 4, 5, 6)
activity_names = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

read_data = function (path, name) {
  result = data.frame()
  
  feature_file_name = feature_file_name(name)
  activity_file_name = activity_file_name(name)
  subject_file_name = subject_file_name(name)
  directory = file.path(directory, name)
  
  #print("Getting dataset:" +  directory)
  # get all the path to the correct file
  
  feature_file = file.path(directory, feature_file_name)
  activity_file = file.path(directory, activity_file_name)
  subject_file = file.path(directory, subject_file_name)
  
  feature_table = read.table(feature_file)[features]
  names(feature_table) = feature_names
  result = feature_table
  
  activity_table = read.table(activity_file)
  names(activity_table) = c("activity")
  activity_table$activity = factor(activity_table$activity, levels = activities, labels = activity_names)
  result = cbind(result, activity = activity_table$activity)
  
  subject_table =  read.table(subject_file)
  names(subject_table) = c("subject")
  result = cbind(result, subject = subject_table$subject)
  
  return(result)
}



directory = "/Users/jiahonghe/Desktop/Self_learned/Coursera/Data Science/Getting and Cleaning Data/final_project"

print("reading train data")
train_data = read_data(directory, "train")
print("reading test data")
test_data = read_data(directory, "test")

data = rbind(train_data, test_data)
data_melt = melt(data, id = c("subject", "activity"))
data = dcast(data_melt, subject + activity ~ variable, mean)
data_file_name = file.path(directory, "result_data.txt")
write.table(data, data_file_name, row.names = FALSE, quote = FALSE)
print(paste("result written to:", as.character(data_file_name)))


