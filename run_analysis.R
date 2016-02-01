trainData <-read.csv("FUCI Har Dataset/train/X_train.txt", sep = "", header = F)
testData <- read.csv("FUCI Har Dataset/test/X_test.txt", sep = "", header = F)
trainActivities <- read.csv("FUCI Har Dataset/train/Y_train.txt", sep = "\t", header = F)
testActivities <- read.csv("FUCI Har Dataset/test/Y_test.txt", sep = "\t", header = F)
columnNames <- read.csv("FUCI Har Dataset/features.txt", sep = "", header = F,
                                col.names = c("Id", "colNames"), stringsAsFactors = F)
activityLabels <- read.csv("FUCI Har Dataset/activity_labels.txt", sep = "", header = F,
                           col.names = c("Id", "Name"), stringsAsFactors = F)

testSubjects <- read.csv("FUCI Har Dataset/test/subject_test.txt", sep = "", 
                            header = F, col.names = c("SubjectId"))

trainSubjects <- read.csv("FUCI Har Dataset/train/subject_train.txt", sep = "", 
                         header = F, col.names = c("SubjectId"))

library(dplyr)

#merge all the activities
allActivities <- rbind(trainActivities, testActivities)

#Solution to problem 1
#merge all the measurements data..
allData <- rbind(trainData, testData)

#merge all the subjects
allSubjects <- rbind(trainSubjects, testSubjects)

#Begin 2
names(allData) <- columnNames$colNames
meanOrStdDeviationCols <- 
    columnNames$colNames[grepl(".*((mean)|(std))\\(\\).*", columnNames$colNames)]
#filter out only the mean or std deviation columns..
meanOrStdallData <- allData[, meanOrStdDeviationCols]

nrow(allActivities)

#3: Adding a column called activityname to name the activity in a row. 
activityLabelName <- merge(allActivities, activityLabels, by.x=c("V1"), by.y = "Id")$Name
meanOrStdAllDataWithActivity <- cbind.data.frame(meanOrStdallData, 
                                                        activityLabelName, allSubjects)

#4 Modifying the labels so that they are readable
names(meanOrStdAllDataWithActivity) <- 
    sub("^([a-zA-Z])(.*)\\-((mean)|(std))\\(\\)(-)?(.*)", 
                "\\3\\U\\1\\E\\2\\7", 
            names(meanOrStdAllDataWithActivity),perl = T)

#5: Summarising the data. i.e. finding the means of all the columns..
summarisedData <-  meanOrStdAllDataWithActivity %>%
                        group_by(SubjectId, activityLabelName) %>%
                            summarise_each(funs(mean(., na.rm = T)))

write.table(summarisedData, 'summary.txt', row.name=FALSE)


