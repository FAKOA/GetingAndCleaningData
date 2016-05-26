#**Code Book**

This document describes the code inside run_analysis.R. 

The code is splitted (by comments) in some sections. These sections represent the steps followed to generate the tidy data set.

##**Constants**

Some fixed values like dataDir, outputDir and outputFile used in the other parts of the code.

##**Variables**

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tbodyacc-xyz

- tgravityacc-xyz

- tbodyaccjerk-xyz

- tbodygyro-xyz

- tbodygyrojerk-xyz

- tbodyaccmag

- tgravityaccmag

- tbodyaccjerkmag

- tbodygyromag

- tbodygyrojerkmag

- fbodyacc-xyz

- fbodyaccjerk-xyz

- fbodygyro-xyz

- fbodyaccmag

- fbodyaccjerkmag

- fbodygyromag

- fbodygyrojerkmag

The set of variables that were estimated from these signals are:

mean: Mean value

std: Standard deviation

##**Downloading and loading data**

- Downloads the UCI HAR zip file if it doesn't exist
- Reads the activity labels to activityLabels
- Reads the column names of data (a.k.a. features) to features
- Reads the test data.frame to testData
- Reads the trainning data.frame to trainningData

##**Manipulating data for getting a tidy data set**

- Merges test data and trainning data to allData
- Indentifies the mean and std columns (plus Activity and Subject) to wc_MeanStd
- Extracts a new data.frame (called wc2) with only those columns from wc_MeanStd
- Summarizes wc2 calculating the average for each column for each activity/subject pair to meanAndStdAverages.
- Transforms the column Activity into a factor.
- Uses activityLabels to name levels of Activity factor.

At this point we have the final data frame wc2.

##**Writing final data to a txt file**

Creates the output dir if it doesn't exist and writes wc2 data frame to the ouputfile.

