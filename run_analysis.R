## Load the required package
library(reshape2)
library(plyr)

# setting the directory
getwd()
setwd("c:/data science/cleandata")

# Download the files
if(!file.exists("./project")){dir.create("./project")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./project/Dataset.zip") 

#Unzip the files
unzip(zipfile="./project/Dataset.zip",exdir="./project")

thePath <- file.path("./project" , "UCI HAR Dataset")
files<-list.files(thePath, recursive=TRUE)
files

# Reading subject data
subject_test <- read.table(file.path(thePath, "test", "subject_test.txt"), header=FALSE, col.names=c("Subject.ID"))
subject_train <- read.table(file.path(thePath, "train","subject_train.txt"), header=FALSE, col.names=c("Subject.ID"))
str(subject_test)


# Reading activities data 
activity_test <- read.table(file.path(thePath, "test","y_test.txt"), header=FALSE, col.names=c("Activity"))
activity_train <- read.table(file.path(thePath, "train","y_train.txt"), header=FALSE, col.names=c("Activity"))
str(activity_test)

# Reading features data
features <- read.table(file.path(thePath,"features.txt"), header=FALSE, as.is=TRUE, col.names=c("Feature.ID", "Feature.Name"))
str(features)

# Reading data set and labels
features_test <- read.table(file.path(thePath, "test","X_test.txt"), header=FALSE, sep="", col.names=features$Feature.Name)
features_train <- read.table(file.path(thePath, "train","X_train.txt"), header=FALSE, sep="", col.names=features$Feature.Name)
str(features_train)

# Getting measurement names with std() and mean()
mean.std.index <- grep(".*mean\\(\\)|.*std\\(\\)", features$Feature.Name)
str(mean.std.index)

# Getting data by indexes. 
features_test <- features_test[, mean.std.index]
features_train <- features_train[, mean.std.index]
head(features_test)

# adding subjects and labels
features_test$Subject.ID <- subject_test$Subject.ID
features_train$Subject.ID <- subject_train$Subject.ID

# Setting activity and labels to data set: 
features_test$Activity <- activity_test$Activity
features_train$Activity <- activity_train$Activity


# Merges the training and the test data to create one data set.

train_test.data <- rbind(features_test, features_train)
names(train_test.data)


# descriptive activity names to name the activities in the data set
activity.labels <- read.table(file.path(thePath, "activity_labels.txt"), header=F, col.names=c("Activity", "Activity.Name"))

#activity.labels
activity.labels$Activity.Name <- as.factor(activity.labels$Activity.Name)

# 4. labels the data set with descriptive activity names: 
train_test.data$Activity <- factor(train_test.data$Activity, levels = 1:6, labels = activity.labels$Activity.Name)
head(train_test.data)
names(train_test.data)
 
#labels the data set with readable name
column.names <- colnames(train_test.data)

column.names <- gsub("\\.+mean\\.+", column.names, replacement="Mean")
column.names <- gsub("\\.+std\\.+", column.names, replacement="Std")

# assign the data with short names 
column.names <- gsub("Magn", column.names, replacement="Magnitude")
column.names <- gsub("Aclm", column.names, replacement="Accelerometer")
column.names <- gsub("Gyros", column.names, replacement="Gyroscope")
column.names

# add column names to the test data
colnames(train_test.data) <- column.names

# independent tidy data set with the average of each variable for each activity and each subject
library(reshape2)
melt_data <- melt(train_test.data, id.vars = c("Activity", "Subject.ID"))
tidy_data <- dcast(melt_data, Activity + Subject.ID ~ variable, mean)
head(melt_data)
head(tidy_data)
table(tidy_data$Subject.ID)

#write txt file for the final analysis
write.table(tidydata, "tidydata.txt", row.names = FALSE)


