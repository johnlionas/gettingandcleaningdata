library(dplyr)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "getdata-projectfiles-UCI HAR Dataset.zip", method = "curl")
unzip("getdata-projectfiles-UCI HAR Dataset.zip")
startwd <- getwd()

#Features
setwd("UCI HAR Dataset")
ft <- read.csv("features.txt", header = FALSE, sep = " ", col.names = c("No", "feature"))
features <- as.character(ft[,2])
features <- gsub("\\(\\)", "", features)

#Activities
activities <- read.csv("activity_labels.txt", header = FALSE, sep = " ", col.names = c("No", "Activity"))
activities <- as.character(activities[,2])

#Test Data
setwd("test")
testValues <- read.table("X_test.txt", col.names = features, check.names = FALSE)
subjects <- read.csv("subject_test.txt", header = FALSE, col.names = "subject")
activityIDs <- read.csv("y_test.txt", header = FALSE, col.names = "activityID")
testData <- cbind(subjects, activityIDs, testValues)
setwd(startwd)

#Train Data
setwd("UCI HAR Dataset/train")
trainValues <- read.table("X_train.txt", col.names = features, check.names = FALSE)
subjects <- read.csv("subject_train.txt", header = FALSE, col.names = "subject")
activityIDs <- read.csv("y_train.txt", header = FALSE, col.names = "activityID")
trainData <- cbind(subjects, activityIDs, trainValues)
setwd(startwd)

#Merge data
fullData <- rbind(testData, trainData)
activityFrame <- data.frame(activities[as.numeric(fullData[,"activityID"])])
names(activityFrame) <- "activity"
fullData <- cbind(fullData, activityFrame)

#Select variables that conatin mean or std function
colInd <- (grepl("mean()", colnames(fullData)) | grepl("std()", colnames(fullData)) 
           | colnames(fullData) == "activity" | colnames(fullData) == "subject") & 
          !grepl("meanFreq()", colnames(fullData))
data <- fullData[,colInd]

#Summarizing
by_actandsubj <- group_by(data, activity, subject)
avgValues <- data.frame(summarise_each(by_actandsubj, funs(mean)))
write.table(avgValues, file = "data.txt", row.names = FALSE)