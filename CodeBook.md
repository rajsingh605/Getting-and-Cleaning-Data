##Transformations done to clean up the data:-

Firstly I read the X_test, X_train, y_test, y_train, activities_label, features, subject_test, subject train dataset into R from the given UCI HAR Dataset.

    X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"", stringsAsFactors=FALSE)
    X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"", stringsAsFactors=FALSE)
	y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"",stringsAsFactors=FALSE)
	y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"", stringsAsFactors=FALSE)
	features <- read.table("./UCI HAR Dataset/features.txt", quote="\"")
	activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", quote="\"", stringsAsFactors=FALSE)
	subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="\"", stringsAsFactors=FALSE)
	subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="\"", stringsAsFactors=FALSE)


Then, I went according to the steps given in the course project.

I merged the train and test dataset into one dataset named raw_ dataset using rbind() function of R.

    raw_dataset<-rbind(X_test,X_train)

Then, I applied feature names to columns of raw_dataset using features dataset and colnames() function of R.

    colnames(raw_dataset)<-features[,2]

Then, I extracted only the measurements on mean and standard deviation of each measurement.

    meancol<-grepl("mean()",features[,2])
	meanFreqcol<-grepl("meanFreq()",features[,2])
	meancol<-meancol & (!meanFreqcol)
	stdcol<-grep("std()",features[,2])
	raw_dataset1<-raw_dataset[,meancol]
	raw_dataset2<-raw_dataset[,stdcol]
	raw_dataset<-cbind(raw_dataset1,raw_dataset2)
Then, I applied descriptive activity names to name the activities in the data set.

    y_test[,1]<-activity_labels[y_test[,1],2] ##To apply activity labels to y test data set
    y_train[,1]<-activity_labels[y_train[,1],2] ##To apply activity labels to y train data set
	activity<-rbind(y_test,y_train)

Then, I combined subject and activity columns to raw_dataset.

    subject<-rbind(subject_test,subject_train)
	subject_activity<-cbind(subject,activity)
	colnames(subject_activity)<-c("SUBJECT","ACTIVITY")
	raw_dataset1<-cbind(subject_activity,raw_dataset)

Then, I created a second, independent tidy data set with the average of each variable for each activity and each subject.

    library(plyr)
	names<-colnames(raw_dataset)
	tidy_data<-ddply(raw_dataset1,.(SUBJECT,ACTIVITY),function(raw_dataset1) colMeans(raw_dataset1[,names]))

Then, I removed all the temporary datasets.

    list1<-c("raw_dataset","raw_dataset1","raw_dataset2","subject_activity","activity_labels","subject")
	rm(list=list1)

##TIDY_DATA dataset description:-

tidy_data is a dataset containing 180 rows and 68 columns extracted from untidy, messy data X_train, X_test, Y_test, Y_train, activites_label, features, subject_test, subject_train datasets.

##Variables of The *TidyDataset* are:-

1. "SUBJECT" - "Number of the subject on which the experiments were carried out".
2. "ACTIVITY" - "The activity which the volunteer was performing"
3. "tBodyAcc-mean()-X"
4. "tBodyAcc-mean()-Y"
5. "tBodyAcc-mean()-Z"
6. "tGravityAcc-mean()-X"
7. "tGravityAcc-mean()-Y"
8. "tGravityAcc-mean()-Z"
9. "tBodyAccJerk-mean()-X"
10. "tBodyAccJerk-mean()-Y"
11. "tBodyAccJerk-mean()-Z"
12. "tBodyGyro-mean()-X"
13. "tBodyGyro-mean()-Y"
14. "tBodyGyro-mean()-Z"
15. "tBodyGyroJerk-mean()-X"
16. "tBodyGyroJerk-mean()-Y"
17. "tBodyGyroJerk-mean()-Z"
18. "tBodyAccMag-mean()"
19. "tGravityAccMag-mean()"
20. "tBodyAccJerkMag-mean()"
21. "tBodyGyroMag-mean()"
22. "tBodyGyroJerkMag-mean()"
23. "fBodyAcc-mean()-X"
24. "fBodyAcc-mean()-Y"
25. "fBodyAcc-mean()-Z"
26. "fBodyAccJerk-mean()-X"
27. "fBodyAccJerk-mean()-Y"
28. "fBodyAccJerk-mean()-Z"
29. "fBodyGyro-mean()-X"
30. "fBodyGyro-mean()-Y"
31. "fBodyGyro-mean()-Z"
32. "fBodyAccMag-mean()"
33. "fBodyBodyAccJerkMag-mean()"
34. "fBodyBodyGyroMag-mean()"
35. "fBodyBodyGyroJerkMag-mean()"
36. "tBodyAcc-std()-X"
37. "tBodyAcc-std()-Y"
38. "tBodyAcc-std()-Z"
39. "tGravityAcc-std()-X"
40. "tGravityAcc-std()-Y"
41. "tGravityAcc-std()-Z"
42. "tBodyAccJerk-std()-X"
43. "tBodyAccJerk-std()-Y"
44. "tBodyAccJerk-std()-Z"
45. "tBodyGyro-std()-X"
46. "tBodyGyro-std()-Y"
47. "tBodyGyro-std()-Z"
48. "tBodyGyroJerk-std()-X"
49. "tBodyGyroJerk-std()-Y"
50. "tBodyGyroJerk-std()-Z"
51. "tBodyAccMag-std()"
52. "tGravityAccMag-std()"
53. "tBodyAccJerkMag-std()"
54. "tBodyGyroMag-std()"
55. "tBodyGyroJerkMag-std()"
56. "fBodyAcc-std()-X"
57. "fBodyAcc-std()-Y"
58. "fBodyAcc-std()-Z"
59. "fBodyAccJerk-std()-X"
60. "fBodyAccJerk-std()-Y"
61. "fBodyAccJerk-std()-Z"
62. "fBodyGyro-std()-X"
63. "fBodyGyro-std()-Y"
64. "fBodyGyro-std()-Z"
65. "fBodyAccMag-std()"
66. "fBodyBodyAccJerkMag-std()"
67. "fBodyBodyGyroMag-std()"
68. "fBodyBodyGyroJerkMag-std()"

