Getting and Cleaning Data: Course Project
-----------------------------------------

####Introduction:
------------
This repository contains the following files as instructed:
README.MD and Run_analysis.R: The main code to process the data 
Codebook.md: decribes all the variables and the process to clean the data set

The goal of the course project is to prepare a tidy data set from the given raw data for the project

###Raw Data:
---------
Raw data is obtained by unzipping the source data at "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 

save the unzipped file in your local drive. Set the working directory to UCI HAR Dataset folder. And put the Run_analysis.R into the working directory.

Following raw data can be found in the source data folder:

The features (561 of them) are unlabeled and are found in the X_test.txt 
The activity labels are in the y_test.txt 
The test subjects are in the subject_test.txt 
The same applies to the Training data sets

activity_labels.txt: Links the class labels with their activity name.
features.txt: List of all features
features_info.txt: Shows information about the variables used on the feature vector.

###Data cleaning:
--------------
Followin packages needed to run the script:
library(reshape2)

I created a script Run_analysis.R which will first merge the test and training sets together.
Next, descriptive activity labels have been added and only the columns that have to do with mean and standard deviation are extracted.
And then the data set with descriptive variable names have been labeled.

Lastly, Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
And this tab-delimited dataset can be found in the tidydata.txt file

###Run_analysis.R: Following script is used to create a tidy data set from the source data:
--------------

setwd(""C:/Users/SUSM/Documents/assignmentdata/UCI HAR Dataset")

list.files("./test")						

###step1: Merge the Test and Train data sets to create merged data sets of Test and Train

TestX<-read.table("./test/X_test.txt") 			
TestY<-read.table("./test/y_test.txt") 			
Testsubject<-read.table("./test/subject_test.txt")	

list.files("./train")						

TrainX<-read.table("./Train/X_train.txt")			
TrainY<-read.table("./Train/y_train.txt")			
Trainsubject<-read.table("./Train/subject_train.txt")	

mergedX<-rbind(TestX,TrainX)					
mergedY<-rbind(TestY,TrainY)					
mergedsubject<-rbind(Testsubject,Trainsubject)		

## step2: Extract only the measurements of only mean and standard deviation 


features<-read.table("features.txt")			
									## using grep(),extract variables ending with mean() and std() from features dataset  
									## and assign to features_meanstd subset
features_meanstd<-features[grep("mean\\>|std",features$V2),]


## step 3: and label the data with descriptive variable names									
features_meanstd[,2]<-sub("tB","timeB",features_meanstd[,2])
features_meanstd[,2]<-sub("tG","timeG",features_meanstd[,2])
									
features_meanstd[,2]<-sub("f","Freq",features_meanstd[,2])
									## find and replace illegal characters with '.' in the variable names of dataset
features_meanstd[,2]<-gsub("[()]","",features_meanstd[,2])
features_meanstd[,2]<-gsub("-",".",features_meanstd[,2])

									
mergedXmeanstd<-mergedX[,c(features_meanstd[,1])]
									
names(mergedXmeanstd)<-c(features_meanstd[,2])		## rename column names with descriptive variable names assigned in features_meanstd

## step 4: descriptive activity names to name the activities in the data

names(mergedY)<-c("Activity")					## rename column name to Activity in mergedY dataset
names(mergedsubject)<-c("Subject")				## rename column name to Subject in mergedsubject dataset

activity_labels<-read.table("activity_labels.txt")	
activitylabels<-activity_labels[,2]				
mergedY$Activity<-as.factor(mergedY$Activity)
mergedY$Activity<-factor(mergedY$Activity,labels=activitylabels)

									## cbind X data (containing mean & std),Y and subject datasets to create one mergeddata data set
mergeddata<-cbind(mergedsubject,mergedY,mergedXmeanstd)

## step5: create tidy data set from the one data set created above

library(reshape2)							
									

melteddata<-melt(mergeddata, id.vars=c("Subject","Activity"),measure.vars=c(features_meanstd[,2]))
									
casteddata<-dcast(melteddata,Subject+Activity ~ variable, mean)

## write the casteddata into tidydata.txt file using write.table

write.table(castdata,file="tidydata.txt", sep="\t", row.name=FALSE)
------------------------------------------------------------------------------------------------------------------------------------------------------

Run Run_analysis.R to process the data. 
Output is a tidy data with dimensions 180*68. There are 66 meansurements on the mean and the standard deviation from the source data.
30 subjects from 1 to 30 and 6 activities labelled as "Walking","Walking Upstairs",Walking Downstairs","Sitting","Standing","Laying".
Each row represents an average of each variable for each subjecy and the activity.
The tidy data is saved as a 'tidydata.txt' file. 

Following code could be used to read the 'tidydata.txt' into R
--------------------------------------------------------------
address <- "https://s3.amazonaws.com/coursera-uploads/user-7bb184abf097e0b0c571d2c9/973758/asst-3/e2571d10890111e49d12aba7d8d5847f.txt"
address <- sub("^https", "http", address)
data <- read.table(url(address), header = TRUE)
View(data)

The dimensions of data are 180x68 because there are 30 subjects and 6 activities, thus "for each activity and each subject" means 30 * 6 = 180 rows.



