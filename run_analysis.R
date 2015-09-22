# Goals of this script are:
# 0./Downloads data (or reads from a local file)
# 1./Merges the training and the test sets to create one data set
# 2./Extracts only the measurements on the mean and standard deviation for
#    each measurement
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names
# 5. From the data in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.

## read data from Human Activity Recognition Dataset

##The dataset includes the following files:
##        =========================================
##                - 'README.txt'
##        - 'features.info.txt': Shows information about the variables used on the feature vector.
#        - 'features.txt': List of all features.
#        - 'activity.labels.txt': Links the class labels with their activity name.
#        - 'train/X.train.txt': Training set.
#        - 'train/y.train.txt': Training labels.
#        - 'test/X.test.txt': Test set.
#        - 'test/y.test.txt': Test labels.
       
## assume it is located in the working directory and called HARData.
## X.test.txt data is fixed width of 17, 16, 16, 16, .... out to 8977
## so, it is 17, rep(16,560), index can be read from features.txt
## apply it to the dataset and then look for things that contain 
##    'mean()' and 'std()'
## subject.test.txt and y.test.txt are single columns
##  -these will have to be brought into the data as well, for later
##    sorting
## body.acc.x.test.txt is 2049 wide, so 17, rep(16,127)    


library(dplyr)

##### Steps 0 and 2 #####
# read in the data AND just take in the mean and stdDev columns
#library(data.table)

# Read in the column names
column.names <- read.table('UCI HAR Dataset/features.txt', header = F)


# specify the column classes
colsClass <- c(rep("numeric",561))

# Read in the dataset
X_train <- read.table('UCI HAR Dataset/train/X_train.txt', sep = "", header = F,
                   colClasses= colsClass, col.names = column.names[,2])

## convert to data table and select mean and std rows
trnX <- tbl_df(X_train)
trnX <- select(trnX, contains(".mean.", ignore.case = F), 
               contains(".std.", ignore.case = F))

## free up some memory
rm("X_train")

## read in the other data and add in to the data table
subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt',
                            header = F, col.names = "subject")

y_train <- read.table('UCI HAR Dataset/train/y_train.txt', header = F,
                                     col.names = "activity")

# read activity labels
activity.labels <- read.table('UCI HAR Dataset/activity_labels.txt', sep = "",
                              header = F, col.names = c("number", "label"))

## do the same for test data
X_test <- read.table('UCI HAR Dataset/test/X_test.txt', sep = "", header = F,
                     colClasses= colsClass, col.names = column.names[,2])

tstX <- tbl_df(X_test)
tstX <- select(tstX, contains(".mean.", ignore.case = F), 
               contains(".std.", ignore.case = F))
rm("X_test")

subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt',
                            header = F, col.names = "subject")

y_test <- read.table('UCI HAR Dataset/test/y_test.txt', header = F,
                                    col.names = "activity")

##### Step 1 ##### Merge the Dataset
# row bind the test and train data as three separate sets

big_data <- tbl_df(rbind(trnX,tstX))
big_subject <- tbl_df(rbind(subject_train,subject_test))
big_labels <- rbind(y_train,y_test)

##### Step 3 ##### Descriptive Activity Names
# remove underscores and force to lowercase, then map to the dataset

activities <- activity.labels$label
activities <- tolower(activities)
activities <- gsub("_","",activities)
big_labels[,1] <- activities[big_labels[,1]]

##### Step 4 ##### Appropriately Label Columns
# change t to suffix: -time, f to suffix -frequency, 
# remove the t or f prefix
# remove duplicate "Body" and replace "BodyGyro" with "Gyro"
# replace "AccJerk" with "Jerk" as this is redundant
# replace "Acc" with "Acceleration" and "Mag" with "Magnitude"
# replace "std" with "StdDev" and "mean" with "Mean"
# remove all dots (.) and any spaces

domainSuffix <- function(x) if(grepl("t",substr(x,1,1))) paste0(x,"-time") else if(grepl("f",substr(x,1,1))) paste(x,"-frequency")
names(big_data) <- sapply(names(big_data), domainSuffix)
removePrefix <- function(x) substr(x,2,nchar(x))
names(big_data) <- sapply(names(big_data), removePrefix)
names(big_data) <- gsub("BodyBody","Body", names(big_data))
names(big_data) <- gsub("BodyGyro","Gyro", names(big_data))
names(big_data) <- gsub("AccJerk", "Jerk", names(big_data))
names(big_data) <- gsub("Acc", "Acceleration", names(big_data))
names(big_data) <- gsub("Mag", "Magnitude", names(big_data))
names(big_data) <- gsub("std", "StdDev", names(big_data))
names(big_data) <- gsub("mean", "Mean", names(big_data))
names(big_data) <- gsub("\\.","", names(big_data))
names(big_data) <- gsub(" ", "", names(big_data))



##### Step 5 #####
# create a second, independent tidy data set with the average of each variable
# for each activity and each subject

# bind the subject, activity, and mean/stddev information in one big table
all_data <- tbl_df(cbind(big_subject,big_labels, big_data))

summary_data <- all_data %>% group_by(subject, activity) %>% summarize_each(funs(mean))

# rewrite variable names to be prefixed by "mean"
meanPrefix <- function(x) paste0("mean",x)
names(summary_data) <- sapply(names(summary_data), meanPrefix)
names(summary_data)[c(1,2)] <- c("subject","activity")


# Write the tidy data to a txt file

write.table(summary_data, file = "tidyData.txt", row.name = FALSE)
