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

##setwd('d:/Coursera.Data.Science/GetCleanAssign/GettingCleaningAssignment')
library(dplyr)

##### Steps 0 and 2 #####
#library(data.table)

# Read in the column names
column.names <- read.table('UCI HAR Dataset/features.txt', header = F)

# Read in the dataset
colsClass <- c(rep("numeric",561))

trainX <- read.table('UCI HAR Dataset/train/X_train.txt', sep = "", header = F,
                   colClasses= colsClass, col.names = column.names[,2])

## convert to data table and select mean and std rows
trnX <- tbl_df(trainX)
trnX <- select(trnX, contains(".mean.", ignore.case = F), 
               contains(".std.", ignore.case = F))

## free up some memory
rm("trainX")

## read in the other data and add in to the data table
subject.train <- read.table('UCI HAR Dataset/train/subject_train.txt',
                            header = F, col.names = "Subject")
subj.trn <- tbl_df(subject.train)
rm("subject.train")

labels.train <- as.matrix(read.table('UCI HAR Dataset/train/y_train.txt', header = F,
                                     col.names = "Labels"))

# read activity labels
activity.labels <- read.table('UCI HAR Dataset/activity_labels.txt', sep = "",
                              header = F, col.names = c("number", "label"))

labels.train <- as.data.frame(mapvalues(labels.train, from = activity.labels$number,
                          to = activity.labels$label))

labels.trn <- tbl_df(labels.train)
#rm("labels.train")



## do the same for test data
testX <- read.table('UCI HAR Dataset/test/X_test.txt', sep = "", header = F,
                     colClasses= colsClass, col.names = column.names[,2])

tstX <- tbl_df(testX)
tstX <- select(tstX, contains(".mean.", ignore.case = F), 
               contains(".std.", ignore.case = F))
rm("testX")

subject.test <- read.table('UCI HAR Dataset/test/subject_test.txt',
                            header = F, col.names = "Subject")
subj.tst <- tbl_df(subject.test)
rm("subject.test")

labels.test <- as.matrix(read.table('UCI HAR Dataset/test/y_test.txt', header = F,
                                    col.names = "Labels"))
labels.test <- as.data.frame(mapvalues(labels.test, from = activity.labels$number,
                          to = activity.labels$label))
labels.tst <- tbl_df(labels.test)
rm("labels.test")

##### Step 1 ##### Merge the Dataset

# Column bind the train data
train.index <- cbind(subj.trn, labels.trn)
train <- cbind(train.index, trnX)


# Column bind the test data
test.index <- cbind(subj.tst, labels.tst)
test <- cbind(test.index, tstX)


# column bind the test and train
big_data <- tbl_df(rbind(train,test))

##### Step 3 ##### Descriptive Activity Names
# remove underscores and force to lowercase, then map to the dataset
activity.labels$label <- tolower(activity.labels$label)
activity.labels$label <- gsub("_","",activity.labels$label)
big_data$Labels <- activity.labels$label[big_data$Labels]

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

# input Subject and Activity labels directly (this is faster than fixing code)
names(big_data)[1] <- "subject"
names(big_data)[2] <- "activity"

##### Step 5 #####
# create a second, independent tidy data set with the average of each variable
# for each activity and each subject

result <- big_data %>% group_by(subject, activity) %>% summarize(mean)



# Write the tidy data to a txt file

#write.table(variable.name.here, file = "tidyData.txt", row.name = FALSE)
