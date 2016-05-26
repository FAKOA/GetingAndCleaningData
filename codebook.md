#**Code Book**

This document describes the code inside run_analysis.R. 

The code is splitted (by comments) in some sections. These sections represent the steps followed to generate the tidy data set.

##**Constants**

Some fixed values like dataDir, outputDir and outputFile used in the other parts of the code.

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

