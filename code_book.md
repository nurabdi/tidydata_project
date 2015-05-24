Code Book
This code book describes the variables, the data, and the process to clean up the data.

Source of Data
Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This analysis is based on an experiment that was carried out by Smartlab - Non Linear Complex Systems Laboratory.
The participants of the experiment were 30 volunteers with an age range between 19-48 years. 
The volunteers wore wearable smartphones of on their waists, and performed six different activities: 
WALKING, 
WALKING_UPSTAIRS, 
WALKING_DOWNSTAIRS, 
SITTING, 
STANDING, 
LAYING.


 The data that was captured included :
3-axial linear acceleration  
3-axial angular velocity at a constant rate of 50Hz. 

The data for this project came from this link: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Data Sets
Subject Test Data :
subject_test.txt
subject_train.txt

Acivities Data:
Y_test.txt
Y_train.txt

 Features Data:
X_test.txt
X_train.txt

Observation Data
"train/subject_train.txt: Subjects who performed the activities
"train/Inertial Signals/total_acc_x_train.txt": acceleration signal from the smartphone
"train/Inertial Signals/body_acc_x_train.txt": Body acceleration
"rain/Inertial Signals/body_gyro_x_train.txt": angular velocity victor

Tidy data Process:
1.Merges the Subject data, Activities data, and Feature’s data
2.Extracts only the measurements on the mean and standard deviation for each measurement.
3.Uses descriptive activity names to name the activities in the data set
4.Labels the data set with descriptive activity names.
5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Notes
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.