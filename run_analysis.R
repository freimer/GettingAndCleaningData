# run_analysis.R

# Load dplyr package required in step 5
library(dplyr)

# Step 1 - Merge the training and the test sets to create one data set
# In order to complete this step it is first necessary to extract the data, then read
# the different components of the test and train data sets and combine them, then
# actually merge the training and test data sets.  Unfortunately, the each of the test
# and train statsets are broken up into several different files, so we have some work
# to do before they are ready for merging.

# Unzip the dataset and extract all files
unzip("dataset.zip")

# Read information on data

## features.txt contains the feature name for each element in the vector X_text.txt
## it will be used as teh descriptive column names for the tidy data set
feature_names <- read.table("UCI HAR Dataset/features.txt", col.names=c("element","name"), stringsAsFactors=FALSE)

## activity_lablels.txt is a short table that contains the activite codes and names
## like features, it will be used to label the activities with descriptive names
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("code","activity"))

# Read test data

## subject_test.txt contains the subject number for each corresponding row in X_text.txt
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

## y_test.txt contains the activity code for each corresponding row in X_text.txt
test_activity <- read.table("UCI HAR Dataset/test/y_test.txt")

## X_test.txt is the 561 element vector, one per row, for each test performed
test_feature <- read.table("UCI HAR Dataset/test/X_test.txt")

# Read the train data

## subject_train.txt contains the subject number for each corresponding row in X_train.txt
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

## y_train.txt contains the activity code for each corresponding row in X_train.txt
train_activity <- read.table("UCI HAR Dataset/train/y_train.txt")

## X_train.txt is the 561 element vector, one per row, for each train performed
train_feature <- read.table("UCI HAR Dataset/train/X_train.txt")

# Actually merge the test and train data sets
subject <- rbind(test_subject, train_subject)
activity <- rbind(test_activity, train_activity)
feature <- rbind(test_feature, train_feature)

# Delete component parts, no longer needed
rm(train_subject, train_activity, train_feature, test_subject, test_activity, test_feature)

# Step 2 - Extract only the measurements on the mean and standard deviation for each
# measurement / feature.  Since the featuers.txt from the original data set says that the mean
# and standard deviation contain mean() and std() in the feature names, we can use that fact
# in determining which of the columns we need to extract.  grepl provides a logical vector of
# whether a particular element matches or not.  Since the feature names directly correspond
# to the vector position in the feature table, we can use grepl to select which columns to keep
feature <- feature[ , grepl("(mean|std)\\(", feature_names$name)]

# We also don't need to keep the feature_names that we no longer need, so we can drop them
feature_names <- feature_names[grepl("(mean|std)\\(", feature_names$name), c("name")]


# Step 3 - Use descriptive names to name the activities in the data set
# For this step we need to replace the activity code with the activity name
# We can then delete the activities codes, as we no longer need them
activity <- sapply(activity$V1, function(f) activities[activities$code == f, c("activity")])
rm(activities)

# Step 4 - Appropriately label the data set with descriptive variable names
# We can combine the feature, activity, and subject now, and label the varaiables appropriately
data <- cbind(feature, activity, subject)
colnames(data) <- c(feature_names, "activity", "subject")
rm(feature,activity,subject,feature_names)
write.csv(data, file="tidy_data.csv")

# We have now tidied up our data set!
#
# Each variable measured is in one column
# Each different observation is in a different row
# One table for each "kind" of variable
# We don't need multiple tables.  The activity and the subject are the "primary key" to the
# table as with a database.  If there were additional information about the subject, such as name,
# address, phone number, etc, then that would be in a separate table.  If there were additional
# data about each activity, such as the documentation for performing the activity or who is the
# designated author of the activity, then that would be in a separate table.

# Step 5 - Create a second, independent tidy data set with the average of each variable for each
# activity and subject


