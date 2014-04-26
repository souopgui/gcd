
Summary
===========
The final tidy data set is made up of a set of a single tables (file): X_ave.txt
To get this data set:
* download the script run_analysis.R
* download the original dataset (see the link in the section Study design),
* unzip the dataset, rename the directory to data and put it in the same
  directory as the script.
* run the script

For customization, see README.

Study design
===============
The table has the columns subject and activity. A part from the variables
subject and activity, there is a total  of 561 self descriptives variables.

All those data are extracted from the feature data of the original data set.
Each observation corresponds to the the average of of the original data grouped
by activity and each subject. In other word, a row of the table corresponds to
the data of a subject (variable subject) for a given activity (variable activity)

Data comes from a study of activity perfomed by a subject equiped with device
capable of measuring acceleration and velocity. The experiments have been
carried out with a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS,
WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone
(Samsung Galaxy S II) on the waist. For more details see section appendix of
this document.
The input data for the processing described in this document are output of a
process on the original data measured by the device. See section appendix for
the description of that step.

data source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Cleaning the data
=================
We made sure that there is no missing value in the data set
```{r}
  sum(is.na(merged))==0
```
We also made sure that the data were normalized
```{r}
sum( merged[,3:563]<(-1.0) )==0
# and
sum( merged[,3:563]>(1.0) )==0
```
Lastly we made sure that all the standard deviation observation were positive.

Code Book
========================================================
Variable names are given by the original data set, 
Apart from the angular data, each table has 2 types of data:
1- time signal prefixed by t
2- frequency signal prefixed by f
The measurements were done in the 3 dimentional physical space. The suffix X, Y
or Z in the variable name identify the physical direction of the measurement.
The data are made up of a set of statistical calculations: A radical in the
variable name identify the calculation. FOr example mean for the mean, std for
the standard deviation, etc.
For details on the variable description, see Appendix section of this code book.


All variables are normalized (no Unit) as described by the original data set


Appendix: Description of the original dataset
========================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

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

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.