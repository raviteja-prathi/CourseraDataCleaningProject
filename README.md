# CourseraDataCleaningProject


This code assumes that all the samsung data is under "FUCI Har Dataset" folder in the main directory.
Contains only one file run_analysis.R which has all the operations

The script achieves the following tasks
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement.
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names.
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

In the first part we load all the data into the memory and then merge the training and test data.
After that we merge the training and test data by calling rbind function

Then we take a subset by columns of the dataframe which has only mean() or std() in its column names. Since we need only those measurements to perform the analysis

Then the script merges the activity labels with the combined data frame and select the activity name as part of the data frame.

It then modifies the names of the columns i.e. removes the function mean() or std() from the names and prepends the mean or std to the columnNames

Then we summarise over all the columns of the data frame.





