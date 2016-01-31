# A script which
#  - looks for data collected from the accelerometers from the Samsung Galaxy S
#    smartphone (it must be located in "UCI HAR Dataset" directory, which is
#    created in current working directory )
#  - Merges the training and the test sets to create one data set
#  - Extracts the measurements on the mean and standard deviation for each measurement
#  - Uses descriptive activity names to name the activities in the data set
#  - Appropriately labels the data set with descriptive variable names
#  - From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject

# Main function (script entry point)
run_analysis <- function (subdir = "UCI HAR Dataset") {
    library (dplyr);

    # read training dataset activity labels
    activityLabels <-
        read.table(paste(subdir, "activity_labels.txt", sep='/'), sep = "")
    activityLabels <- as.character(activityLabels$V2)

    # read feature name for each column
    features <- read.table(paste(subdir, "features.txt", sep='/'), sep = "")
    fieldNames <- as.character(features[[2]])

    # read training dataset and add activity and subject columns
    trainActivities <- read.table(paste(subdir, "train", "Y_train.txt", sep='/'), sep = "")
    trainSubjects <- read.table(paste(subdir, "train", "subject_train.txt", sep='/'), sep = "")
    trainDataSet <- read.table(paste(subdir, "train", "X_train.txt", sep='/'),sep = "")

    # read testing dataset and add activity and subject columns
    testActivities <- read.table(paste(subdir, "test", "Y_test.txt", sep='/'), sep = "")
    testSubjects <- read.table(paste(subdir, "test", "subject_test.txt", sep='/'), sep = "")
    testDataSet <- read.table(paste(subdir, "test", "X_test.txt", sep='/'),sep = "")

    # merge training and test datasets
    mergedActivities <- rbind(trainActivities, testActivities)
    mergedSubjects <- rbind(trainSubjects, testSubjects)
    mergedDataSet <- rbind(trainDataSet, testDataSet)

    # labels columns
    names(mergedDataSet) <- fieldNames

    # extracts mean and standard deviations for each measurement
    requiredColumns <- grep('\\-(mean|std)', fieldNames, ignore.case=TRUE)
    dataSet <- mergedDataSet[,requiredColumns]
    #View (fieldNames)
    
    # add activity names and subjects (did not add to unmerged datasets to make feature filtering simpler)
    dataSet$activity <- as.factor(mergedActivities[[1]])
    levels(dataSet$activity) <- activityLabels
    dataSet$subject <- mergedSubjects[[1]]

    tidy <- aggregate(. ~ subject+activity, data = dataSet, FUN=mean, na.rm=TRUE)
    write.table(tidy, "tidy.txt", row.names=FALSE)
    tidy
}

run_analysis()