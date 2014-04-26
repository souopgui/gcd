
Getting and Cleaning Data Project: Peer assignment
===============================================================================
Prerequisites
-------------
This script uses the package sqldf

Preliminaries
--------------
  In this script, data directory refers to the directory containing the
  subdirectories train and test. By default, we suppose that the data
  directory is renamed data and is a subdirectory of the working directory.
  If that is not the case, please, set the variable dataDir below to point to
  the data directory.
  For readability, the part of the code that does any of the 5 prescribed
  points is done in its own section.
 
Recall of the excercice
------------------------
You should create one R script called run_analysis.R that does the following.
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each
  measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive activity names. 
5) Creates a second, independent tidy data set with the average of each
   variable for each activity and each subject

For 1) we create a merged directory, merge the data from the train and the
test data sets and save it in the merged directory. The merge operation
here is the concatenation using the R function rbind. We merge the the
Inertial signal, the feature signal, the subject indexes and the activity
indexes.
For 2) we extract the mean and standard deviation for each measurements
and keep it in memory variable. We do not save it to file.
For 3) we consider the measurements associated to each feature, merged from 1)
we add a new column with the activity name associate to each observation.
For 4) we did not find any difference with 3, to do something different,
we add feature labels as column names. We saved the sew data file
For 5) we create a new directory and save new tidy data set containing the
average for each subject and activity appropriately labeled with the activity
name
