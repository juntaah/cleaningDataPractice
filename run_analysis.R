# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt",row.names = 1)

test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt",col.names = "subjectId")
test_X <- read.table("UCI HAR Dataset/test/X_test.txt") #data
test_Y <- read.table("UCI HAR Dataset/test/Y_test.txt") #activity labels from 1 to 6
test_Y_explicit <- merge(test_Y,activities,by="V1")
test_df <- cbind(test_subject,test_Y_explicit,test_X)

train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt",col.names = "subjectId")
train_X <- read.table("UCI HAR Dataset/train/X_train.txt") #data
train_Y <- read.table("UCI HAR Dataset/train/Y_train.txt") #activity labels from 1 to 6
train_Y_explicit <- merge(train_Y,activities,by="V1")
train_df <- cbind(train_subject,train_Y_explicit,train_X)

all_df <- rbind(test_df,train_df)

names(all_df) <- c("subjectId","activityId","activityName",as.character(features$V2))

# Extracts only the measurements on the mean and standard deviation for each measurement.

df_final <- all_df[,c(1:3,grep("(mean|std)\\(\\)",names(all_df)))]

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)

df_averages <- df_final %>%
  group_by(subjectId,activityId,activityName) %>%
  arrange(subjectId,activityId,activityName) %>%
  summarise_all(mean)

View(df_averages)
