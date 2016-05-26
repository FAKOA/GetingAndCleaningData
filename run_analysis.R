#
# The script below generates a tidy data set for the data in
#http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
#


# 1 - Merges the training and the test sets to create one data set.

      # Download + Unzip File
     if (!file.exists(data.file)){
       download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "data.zip", method="curl")
       unzip("data.zip")
       file.remove("data.zip")
     }
   
     #List of the files present in the repository UCI HAR Dataset
     
     path_rf <- file.path("./" , "UCI HAR Dataset")
     files<-list.files(path_rf, recursive=TRUE)
     files
      
     #*Read data from the targeted files and look at their characteristics
      
     #Read Fearures files
     data.trainsetFeatures.dir <- "./UCI HAR Dataset/train/X_train.txt"
     data.testsetFeatures.dir  <- "./UCI HAR Dataset/test/X_test.txt"
      
     wc_FeaturesTrain <- read.table(data.trainsetFeatures.dir, header= F)
     str(wc_FeaturesTrain)
     
     wc_FeaturesTest  <- read.table(data.testsetFeatures.dir, header= F)
     str(wc_FeaturesTest)
     
     
     
     data.features  <- "./UCI HAR Dataset/features.txt"
     wc_FeaturesNames    <- read.table(data.features, header= F)
     str(wc_FeaturesNames)
     
     #Read the Activity files
     data.trainset.dir <- "./UCI HAR Dataset/train/y_train.txt"
     data.testset.dir <- "./UCI HAR Dataset/test/y_test.txt"
     
     wc_ActivityTrain <- read.table(data.trainset.dir, header= F)
     str(wc_ActivityTrain)
     
     wc_ActivityTest  <- read.table(data.testset.dir, header= F)
     str(wc_ActivityTest)
     
     #Read the Subject files
     
     wc_SubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
     str(wc_SubjectTrain)
     
     wc_SubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
     str(wc_SubjectTest)
     
     #Merges the training and the test sets to create one data set
     
     #1. Concatenate the data tables by rows
     
      wc_Subject  <- rbind(wc_SubjectTrain, wc_SubjectTest)
      wc_Activity <- rbind(wc_ActivityTrain, wc_ActivityTest)
      wc_Features <- rbind(wc_FeaturesTrain, wc_FeaturesTest)
        
     #2. Set names to variables
     
      
     names(wc_Subject)<-c("subject")
     names(wc_Activity)<- c("V1","activityNumber")
     names(wc_Features)<- wc_FeaturesNames$V2
     
     #3.Merge columns to get the data frame Data for all data
     
     wc_Combined <- cbind(wc_Subject, wc_Activity)
 
     
     wc <- cbind(wc_Features, wc_Combined)
    
     str(wc)
     
      
     # 2 Extracts only the measurements on the mean and standard deviation for each measurement.
      
     wc_MeanStd <- subset(wc, select = c(grep("mean\\(\\)|std\\(\\)",wc_FeaturesNames$V2),activityNumber,subject))
     #str(wc_MeanStd)
     
# 3 Uses descriptive activity names to name the activities in the data set
     #Read descriptive activity names from "activity_labels.txt"
     
     wc_ActivityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)
     names(wc_ActivityLabels) <- c("activityNumber","activityName")
    
     head(wc_MeanStd,n=2) 
     
     wc_MeanStd <- merge(wc_ActivityLabels, wc_MeanStd , by="activityNumber", all.x = TRUE)
     
     head(wc_MeanStd,n=2)
       
      
# 4 Appropriately labels the data set with descriptive variable names.
     # prefix t is replaced by time
     # Acc is replaced by Accelerometer
     # Gyro is replaced by Gyroscope
     # prefix f is replaced by frequency
     # Mag is replaced by Magnitude
     # BodyBody is replaced by Body

     names(wc_MeanStd)<-gsub("^t", "time", names(wc_MeanStd))
     names(wc_MeanStd)<-gsub("^f", "frequency", names(wc_MeanStd))
     names(wc_MeanStd)<-gsub("Acc", "Accelerometer", names(wc_MeanStd))
     names(wc_MeanStd)<-gsub("Gyro", "Gyroscope", names(wc_MeanStd))
     names(wc_MeanStd)<-gsub("Mag", "Magnitude", names(wc_MeanStd))
     names(wc_MeanStd)<-gsub("BodyBody", "Body", names(wc_MeanStd))
     
     #check
     
     names(wc_MeanStd)
   
# 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
      
     library(dplyr)
     
     wc2 <- aggregate(. ~subject + activityName, wc_MeanStd, mean)
     
     wc2<-wc2[order(wc2$subject,wc2$activityName),]
     
     head(wc2,n=2)
     write.table(wc2, file = "tidydata.txt",row.name=FALSE)
     
     #Prouduce Codebook
     
     library(knitr)
     knit2html("codebook.Rmd"); 
      
      
      