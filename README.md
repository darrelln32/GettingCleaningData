s#Design of a Tidy Data Set from UCI HAR Dataset
##Course Project
####Darrell Nabors

###Abstract
The purpose of this document is to illustrate the functional process of the run_analysis.R script for the Course Project in Getting and Cleaning Data.  



###System Requirements
Hardware  
- System: Apple MacBook Pro
- Processor:  2.4 GHz Intel Core 2 Duo
- Memory: 8 GB 1067 MHz DDR3

Software
- Mac OS X, version 10.10
- RStudio, Version 0.98.1028
- Markdown Pro, Version 1.0.9 (2330)

###Functional Process of R Script

1. Read in all of the data from the UCI HAR provided files.
2. Next, the features (y-test and y-train) and the subjects (s-test and s-train) are merged together to so that the appropriate analysis can be done on the set.
3. Next, the mean and the standard deviation for each measurement is extracted from the merged dataset.
4. The activity labels are attached to the corresponding numbers representing the activities.
5. The columns featuring numbers indicating the activities are deleted.
6. Next, tapply is used to calculate the mean for each activity for each subject.  
7. Next, the columns are rearranged to add the new calculations for the mean until all the means for every variable are calculated and added to the new table.  This new table is the new tidy data set.
8. Next, all appropriate labels are added to the columns for the tidy data.
9.  Finally, the tidy data file is written to a txt file in the working R directory called "tidy_data.txt".


The run_analysis.R script can be placed in your working R directory and executed from the R prompt:

"> X <- run_analysis()"

Note: X can be the name of any object you wish.