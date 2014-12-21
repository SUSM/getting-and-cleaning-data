

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

mergedX<-rbind(TestX,TrainX)					## rowbind Test and Training sets to create mergedX dataset
mergedY<-rbind(TestY,TrainY)					
mergedsubject<-rbind(Testsubject,Trainsubject)		

## step2: Extract only the measurements of only mean and standard deviation 


features<-read.table("features.txt")			## read features.txt file into features data frame

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
