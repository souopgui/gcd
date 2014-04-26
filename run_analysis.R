###############################################################################
###         Getting and Cleaning Data Project: Peer assignment
###############################################################################
## Prerequisites
#  This script uses the package sqldf
## Preliminaries
#  In this script, data directory refers to the directory containing the
#  subdirectories train and test. By default, we suppose that the data
#  directory is renamed data and is a subdirectory of the working directory.
#  If that is not the case, please, set the variable dataDir below to point to
#  the data directory.
#  For readability, the part of the code that does any of the 5 prescribed
#  points is done in its own section.
# 
# Recall of the excercice
# You should create one R script called run_analysis.R that does the following.
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each
#    measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive activity names. 
# 5) Creates a second, independent tidy data set with the average of each
#    variable for each activity and each subject
# For 1) we create a merged directory, merge the data from the train and the
# test data sets and save it in the merged directory. The merge operation
# here is the concatenation using the R function rbind. We merge the the
# Inertial signal, the feature signal, the subject indexes and the activity
# indexes.
# For 2) we extract the mean and standard deviation for each measurements
# and keep it in memory variable. We do not save it to file.
# For 3) we consider the measurements associated to each feature, merged from 1)
# we add a new column with the activity name associate to each observation.
# For 4) we did not find any difference with 3, to do something different,
# we add feature labels as column names. We saved the sew data file
# For 5) we create a new directory and save new tidy data set containing the
# average for each subject and activity appropriately labeled with the activity
# name
#

#------------------------------------------------------------------------------
## Variables
# Directories
psep = "//"
dataDir = "data" #data directory, absolute or relative path
trainDir = paste(dataDir, "train", sep=psep) # train data (sub)directory
testDir = paste(dataDir, "test", sep=psep) # test data (sub)directory
mergedDir = paste(dataDir, "merged", sep=psep) # merged data (sub)directory
inertialDir = "Inertial Signals" #name of the inirtial Signal data

#prefix of the Inertial Signals file names
inertialPrefs = c('body_acc_x_', 'body_acc_y_', 'body_acc_z_',
                  'body_gyro_x_', 'body_gyro_y_', 'body_gyro_z_',
                  'total_acc_x_', 'total_acc_y_', 'total_acc_z_')
activityPref = 'y_' #prefix of the activiry index file name
subjectPref = 'subject_' #prefix of the subject index file name
dataPref = 'X_' #prefix of the features data file name
#suffixes
trainSuff = "train.txt"
testSuff = "test.txt"
mergedSuff = "merge.txt"

nFeature = 561 #number of features
nTime = 128 #number of variable in the inertial signal

###############################################################################
# 1) Merging the training and the test data sets
###############################################################################
##   Creating the directory for the merged dataset
if(!file.exists(mergedDir)){
  dir.create(mergedDir)
}
#Inertial signal subdir
mInertialDir = paste(mergedDir, inertialDir, sep=psep)
if(!file.exists( mInertialDir ) ){
  dir.create( mInertialDir )
}

#Reading the common data: feature and activity labels
#------------------------------------------------------------------------------
activityLabels = read.table( paste(dataDir,"activity_labels.txt",sep=psep ) )
featureLabels  = read.table( paste(dataDir,"features.txt",sep=psep ) )

#Reading and merging the subject and activity indexes
#------------------------------------------------------------------------------
#training data set
fName = paste(trainDir, paste(subjectPref, trainSuff, sep=""), sep=psep)
subject_train = scan(fName)
fName = paste(trainDir, paste(activityPref, trainSuff, sep=""), sep=psep)
activity_train = scan(fName)
#test data set
fName = paste(testDir, paste(subjectPref, testSuff, sep=""), sep=psep)
subject_test = scan(fName)
fName = paste(testDir, paste(activityPref, testSuff, sep=""), sep=psep)
activity_test = scan(fName)
#merging
subjects = c(subject_train, subject_test)
activities = c(activity_train, activity_test)


#saving to the new data set
fName=paste(mergedDir, paste(subjectPref, mergedSuff, sep=""), sep=psep)
write.table(data.frame(subjects),file=fName, row.names=FALSE, col.names = FALSE)

fName = paste(mergedDir, paste(activityPref, mergedSuff, sep=""), sep=psep)
write.table(data.frame(activities),file=fName, row.names=FALSE, col.names = FALSE)

#Reading and merging the Inertial signal
#------------------------------------------------------------------------------
for(fpref in inertialPrefs){
  #reading the training data
  fName = paste(trainDir,inertialDir, paste(fpref, trainSuff,sep=""), sep=psep)
  train <-read.table(fName, colClasses = c(rep("numeric", nTime)) )
  #reading the test data
  fName = paste(testDir,inertialDir, paste(fpref, testSuff, sep=""), sep=psep)
  test <-read.table(fName, colClasses = c(rep("numeric", nTime)) )
  #merging and saving
  merged <- rbind(train,test)
  fName = paste(mInertialDir, paste(fpref, mergedSuff, sep=""), sep=psep)
  print( fName )
  system.time( write.table(merged,file=fName, row.names=FALSE, col.names = FALSE) )
}

#Reading and merging the feature data
#------------------------------------------------------------------------------
#reading the training data
fName = paste(trainDir, paste(dataPref, trainSuff, sep=""), sep=psep)
train <-read.table(fName, colClasses = c(rep("numeric", nFeature)) )
fName = paste( testDir, paste(dataPref, testSuff, sep=""), sep=psep)
test <-read.table(fName, colClasses = c(rep("numeric", nFeature)) )
#merging and saving
merged = rbind(train, test)
fName = file=paste(mInertialDir, paste(dataPref, mergedSuff, sep=""), sep=psep)
write.table(merged,fName, row.names=FALSE, col.names = FALSE)


###############################################################################
# 2) Extracts only the measurements on the mean and standard deviation for each
#    measurement.
###############################################################################
# For this step, we use the sqldf package to extract the columns associated
# with features which labels contain "mean" or "std"

library("sqldf") #loading the sqldf package
#Adding column names to features table for SQL querying
colnames(featureLabels) <- c('fnum', 'fname')
mean_std_featuresLabels <- sqldf("select * from featureLabels where fname like 
                           '%-mean()%' or fname like '%-std()%'")
x_mean_std <- merged[,mean_std_featuresLabels[,1]]


###############################################################################
# 3) Uses descriptive activity names to name the activities in the data set
###############################################################################
# we did not find any difference between 3 and 4, to do something different
# we choose 3 to add column labels and 4 to add and extra column with activity
# labels

colnames(merged) <- featureLabels[,2]

###############################################################################
# 4) Appropriately labels the data set with descriptive activity names. 
###############################################################################
#adding a column for activity labels
merged[,"Activity"]<-activityLabels[activities,2]
#bringing the activity labels to the first column
merged <- merged[,c(nFeature+1, 1:nFeature)]

#saving the merge data file
fName=paste(mergedDir, paste(dataPref, 'merged_labeled.txt', sep=""), sep=psep)
write.table(merged, file=fName, row.names=FALSE)


###############################################################################
# 5) Creates a second, independent tidy data set with the average of each
#    variable for each activity and each subject
###############################################################################
#use sapply and transpose
#adding a subject column
merged[,"Subject"]<-subjects
#bringing the subject to the first column
merged <- merged[,c(nFeature+2, 1:(nFeature+1) )]

newData = sapply( split(merged[,3:(nFeature+2)], list(subjects, activities) ),
                  function(x) colMeans(x), simplify="data.frame" )
df= data.frame(subjects, activities)
tmp = sapply( split(df[,c(1,2)], list(subjects, activities) ),
              function(x) x[1,], simplify="data.frame" )
newData = cbind( t(tmp), t(newData) )

#directory for the new data
newDir = paste(dataDir, "new", sep=psep) # merged data (sub)directory
##   Creating the directory for the new dataset
if(!file.exists(newDir)){
  dir.create(newDir)
}
fName =  paste(newDir, paste(dataPref, 'ave.txt', sep=""), sep=psep)
write.table(newData,file=fName, row.names=FALSE)


#==============================================================================