Codebook for Samsung Galaxy S accelerometer data analysis
==================

Original data
-------------------
Te script works with the data collected from the accelerometers from the Samsung Galaxy S smartphones.
It was obtained from  
* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
A full description of te data used:
* http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones      

Script
-------------------
The script `run_analysis.R` does several things to get a clean dataset:
* Original training data is loaded from raw data `train/X_train.txt` file. Activities and subjects for each row in training dataset are loaded from files `train/Y_train.txt` and `train/subject_train.txt`
* Original testing data is loaded from raw data `test/X_test.txt` file.  Activities and subjects  each row in training dataset are loaded from files `test/Y_test.txt` and `test/subject_test.txt`
* Training and testing datasets are merged
* Names of each column of both training and testing datasets are retrieved from file `features.txt`. These column names are applied to the merged dataset.
* To extract only the measurements on the mean and standard deviation for each measurement, all the features (columns) which do not contain text "-mean" or "-std" are removed from the merged dataset.
* Activities and subjects added for each row using previously loaded activity and subject information. Activity column is filled with descriptive names (using activity number to label mapping extracted from file `activity_labels.txt`)

Additionally the script creates another dataset which contains the average of each variable for each activity and each subject calculated from the previous merged dataset

Author
-------------------

The script was created by Andrius R. on 2016-01-31 in Vilnius, Lithuania.
