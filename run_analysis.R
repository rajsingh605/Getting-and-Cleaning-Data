##run_analysis.R

##Set your Working Directory.
##Once we have set the working directory, place the download UCI HAR Dataset into the working directory.
##Following Code is used to read the X_test, X_train, y_test, y_train, activities_label, features, subject_test,
##subject train dataset into R from the given UCI HAR Dataset

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"", stringsAsFactors=FALSE)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"", stringsAsFactors=FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"",stringsAsFactors=FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"", stringsAsFactors=FALSE)
features <- read.table("./UCI HAR Dataset/features.txt", quote="\"")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", quote="\"", stringsAsFactors=FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="\"", stringsAsFactors=FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="\"", stringsAsFactors=FALSE)

###################################################################################################
##1. Merges the training and the test sets to create one data set.#################################
###################################################################################################

##Following part of script is used to merge X_train and X_test datasets.

raw_dataset<-rbind(X_test,X_train)

###################################################################################################
##End of Step 1####################################################################################
###################################################################################################


###################################################################################################
##2.Extracts only the measurements on the mean and standard deviation for each measurement.########
###################################################################################################

##Following part of script is used to apply feature names to columns of raw_dataset using features dataset.

colnames(raw_dataset)<-features[,2]

##Following part of script is used to extracts only the measurements on the mean and standard deviation for each measurement.

meancol<-grepl("mean()",features[,2])
meanFreqcol<-grepl("meanFreq()",features[,2])
meancol<-meancol & (!meanFreqcol) ##To remove those values of meancol where "meanFreq() occurs"
stdcol<-grep("std()",features[,2])
raw_dataset1<-raw_dataset[,meancol]
raw_dataset2<-raw_dataset[,stdcol]
raw_dataset<-cbind(raw_dataset1,raw_dataset2)

###################################################################################################
##End of Step 2####################################################################################
###################################################################################################

###################################################################################################
##3.Uses descriptive activity names to name the activities in the data set#########################
###################################################################################################

y_test[,1]<-activity_labels[y_test[,1],2]##To apply activity labels to y test data set
y_train[,1]<-activity_labels[y_train[,1],2]##To apply activity labels to y train data set
activity<-rbind(y_test,y_train)

###################################################################################################
##End of Step 3####################################################################################
###################################################################################################

###################################################################################################
##4.Appropriately labels the data set with descriptive variable names.#############################
###################################################################################################

##Already done in step 2

##combining subject and activity columns to raw_dataset

subject<-rbind(subject_test,subject_train)
subject_activity<-cbind(subject,activity)
colnames(subject_activity)<-c("SUBJECT","ACTIVITY")
raw_dataset1<-cbind(subject_activity,raw_dataset)

###################################################################################################
##End of Step 4####################################################################################
###################################################################################################

###################################################################################################
##5.From the data set in step 4, creates a second,independent tidy data set with the average of####
##each variable for each activity and each subject.################################################
###################################################################################################

##load plyr library
library(plyr)
names<-colnames(raw_dataset)
tidy_data<-ddply(raw_dataset1,.(SUBJECT,ACTIVITY),function(raw_dataset1) colMeans(raw_dataset1[,names]))

##TO REMOVE TEMPORARY DATASETS CREATED ABOVE#######################################################
list1<-c("raw_dataset","raw_dataset1","raw_dataset2","subject_activity","activity_labels","subject")
rm(list=list1)

###################################################################################################
##End of Step 5####################################################################################
###################################################################################################