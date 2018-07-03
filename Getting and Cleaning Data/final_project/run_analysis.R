# train/test data folders are in the same directory as this R script

library(reshape2)
source("functions.R")
source("read_data.R")

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


