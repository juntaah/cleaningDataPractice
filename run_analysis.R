# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# if(!file.exists("./data")){dir.creat("./data")}
# fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(fileURL, destfile = "./data/run.zip", method = "curl")
# unzip("./data/run.zip", exdir = "data")
# file.remove("./data/run.zip")

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt",row.names = 1)

test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names = "subjectId")
test_X <- read.table("UCI HAR Dataset/test/X_test.txt") #data
test_Y <- read.table("UCI HAR Dataset/test/Y_test.txt") #activity labels from 1 to 6
test_df <- cbind(test_subject,test_Y,test_X)

train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt",col.names = "subjectId")
train_X <- read.table("UCI HAR Dataset/train/X_train.txt") #data
train_Y <- read.table("UCI HAR Dataset/train/Y_train.txt") #activity labels from 1 to 6
train_df <- cbind(train_subject,train_Y,train_X)

all_df <- rbind(test_df,train_df)

names(all_df) <- c("subjectId","activity",as.character(features$V2))
all_df$activity <- factor(all_df$activity,labels=activities$V2)

# Extracts only the measurements on the mean and standard deviation for each measurement.

df_final <- all_df[,c(1:2,grep("(mean|std)\\(\\)",names(all_df)))]

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)

df_averages <- df_final %>%
  group_by(subjectId,activity) %>%
  summarise_all(mean)

write.table(df_averages,"tidy_table.txt",row.name = F)

View(df_averages)
