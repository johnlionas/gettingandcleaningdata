## Getting and Cleaning Data Course Project
## Code and Variables explanation

The code is composed of the following steps:

* The compressed file is downloaded.
* The file is decompressed.
* The features from the "features.txt" file are stored into a separate data frame.
* The names contained in the features data frame are modified by removing the parentheses so that they are valid variables names.
* The avtivities from the "activities.txt" file are loaded into separate vector.
* Test data is loaded from "X_test.txt" into a data frame.
* The collumn names of the test data are set equal to the features vector.
* Subject data and activityIDs are loaded from "subject_test.txt" file and "y_test.txt" file and stored in separate data frames.
* Test data, subjects and activityIDs are combined to one data frame using cbind function.
* A data frame containing the train data is formed in the same way using "X_train.txt", "subject_train.txt" and "y_train.txt" files.
* Test and train data frames are merged using rbind function
* An new collumn is added in the data frame with the activity descriptions that correspond to the activity IDs. The activities vector is used for this purpose.
* A new data frame is formed by selecting the columns that contain mean or std in their name along with the subject and activity (description not ID) columns. Variables that contain meanFreq substring are excluded.
* The data are grouped by activity and subject using group_by function contained in the dplyr library.
* The data are summarized using summarise_each function contained in the dplyr library. A new data frame is produced that lists all the mean values for every possible combination of subject and activity.
* The result is stored in the file "data.txt" using write.table function.

The basic variables of the script are the following:

* fileUrl: The url from which the compressed file is downloaded.
* features: A character vector containing the names of all the variables that were measured. The parentheses contained in the names are removed. 
* activities: A character vector containing the names of the 6 activities that were performed.
* subjects: A data frame with the numbers of the subjects that correspond to the records of the testValues or trainValues data frame.
* activityIDs: A data frame with the IDs of the activities that correspond to the records of the testValues or trainValues data frame.
* testValues: A data frame with all the test set measurements.
* trainValues: A data frame with all the training set measurements.
* testData: The test set data produced from merging testValues with subjects and activityIDs.
* trainData: The training set data produced from merging trainValues with subjects and activityIDs.
* fullData: A data frame that contains all the measurements (both test and training set) with an additional collumn that contains the names of the activities for each record.
* collInd: A vector containg the indices of the collumns that will be selected from the fullData data frame.
* data: The data frame that contains the desired variables (collumns).
* by_actandsubj: The data grouped by subject and activity.
* avgValues: A data frame where each record containg the average measuremens for a specific combination of subject and activity.
