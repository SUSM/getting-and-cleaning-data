Codebook for the tidydata set:
-----------------------------
This file decribes the variables, the data, and any transformations or work that you performed to clean up the data

Data Source:
-----------
The data was obtained from the site http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

and the data for the project is taken from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

I refer you to the README and features.txt files in the original dataset to learn more about the feature selection for this dataset. 

As given in the README file of the original data set, the dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

As mentioned in the features.txt file of the original data sets,these signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag



###The Run_analysis.R script performs the following steps to clean the data
--------------------------------------------------------------------
The first step is to merge the data sets in Test and Train folders.
Read the files X_test.txt, Y_test.txt and subject_test.txt into TestX, TestY, Testsubject variables respectively.
Same goes for train data sets and store them in tainX, tainY, tainsubject variables. row bind test and train data sets to create MergedX, MergedY, Mergedsubject variables

Second step is to extract only the measurements of mean and standard deviations from features.txt file. Read features.txt file into features variable and use grep() to 
extract mean and std() into faturesXmeanstd from MergedX data

Next, label the extracted data of mean and std with descriptive variable names while editing/replacing variable names using grep()to match the criteria for column names (removing illegal characters)

Next, descriptive activity labels have been added to MergedY data set after readind the file activity_labels.txt into activity_labels and factoring the activities into activitylabels factor.

And then one merged data is created by columnbinding Mergedsubject,MergedY and MergedXmeanstd to create Mergeddata variable

reshape library is called and Mergeddata is melted and dcasted to create dcasted variable and a second, independent tidy data set is created with the average of each of the 66 variables for each activity and each subject. 

And lastly with write.table(),dcasteddata has been imported into tab-delimited dataset tidydata.txt file

Tidydata.txt file:
------------------

Output is a tidy data with dimensions 180*68. There are 66 meansurements on the mean and the standard deviation from the source data.
30 subjects from 1 to 30 and 6 activities.
Each row represents an average of each variable for each subjecy and the activity.

The 68 variables of the tidydata set are described below:

1. Subject : Subject who performed the activity for each window sample. It ranges from 1 to 30
2. Activity: Activity names labeled as: 
		WALKING
 		WALKING_UPSTAIRS 
		WALKING_DOWNSTAIRS
		SITTING
		STANDING
		LAYING

And these 66 variables are averages of means and standard deviation of measurements for each subject and activity

timeBodyAcc.mean.X
timeBodyAcc.mean.Y
timeBodyAcc.mean.Z
timeBodyAcc.std.X
timeBodyAcc.std.Y
timeBodyAcc.std.Z
timeGravityAcc.mean.X"        
timeGravityAcc.mean.Y"       
timeGravityAcc.mean.Z"        
timeGravityAcc.std.X"        
timeGravityAcc.std.Y"         
timeGravityAcc.std.Z"        
timeBodyAccJerk.mean.X"       
timeBodyAccJerk.mean.Y"      
timeBodyAccJerk.mean.Z"       
timeBodyAccJerk.std.X"       
timeBodyAccJerk.std.Y"        
timeBodyAccJerk.std.Z"       
timeBodyGyro.mean.X"          
timeBodyGyro.mean.Y"         
timeBodyGyro.mean.Z"          
timeBodyGyro.std.X"          
timeBodyGyro.std.Y"           
timeBodyGyro.std.Z"          
timeBodyGyroJerk.mean.X"      
timeBodyGyroJerk.mean.Y"     
timeBodyGyroJerk.mean.Z"      
timeBodyGyroJerk.std.X"      
timeBodyGyroJerk.std.Y"       
timeBodyGyroJerk.std.Z"      
timeBodyAccMag.mean"          
timeBodyAccMag.std"          
timeGravityAccMag.mean"       
timeGravityAccMag.std"       
timeBodyAccJerkMag.mean"      
timeBodyAccJerkMag.std"      
timeBodyGyroMag.mean"         
timeBodyGyroMag.std"         
timeBodyGyroJerkMag.mean"     
timeBodyGyroJerkMag.std"     
FreqBodyAcc.mean.X"           
FreqBodyAcc.mean.Y"          
FreqBodyAcc.mean.Z"           
FreqBodyAcc.std.X"           
FreqBodyAcc.std.Y"            
FreqBodyAcc.std.Z"           
FreqBodyAccJerk.mean.X"       
FreqBodyAccJerk.mean.Y"      
FreqBodyAccJerk.mean.Z"       
FreqBodyAccJerk.std.X"       
FreqBodyAccJerk.std.Y"        
FreqBodyAccJerk.std.Z       
FreqBodyGyro.mean.X          
FreqBodyGyro.mean.Y         
FreqBodyGyro.mean.Z          
FreqBodyGyro.std.X          
FreqBodyGyro.std.Y           
FreqBodyGyro.std.Z          
FreqBodyAccMag.mean          
FreqBodyAccMag.std          
FreqBodyBodyAccJerkMag.mean  
FreqBodyBodyAccJerkMag.std  
FreqBodyBodyGyroMag.mean     
FreqBodyBodyGyroMag.std     
FreqBodyBodyGyroJerkMag.mean
FreqBodyBodyGyroJerkMag.std 
