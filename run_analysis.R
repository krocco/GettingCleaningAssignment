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
##        - 'features_info.txt': Shows information about the variables used on the feature vector.
#        - 'features.txt': List of all features.
#        - 'activity_labels.txt': Links the class labels with their activity name.
#        - 'train/X_train.txt': Training set.
#        - 'train/y_train.txt': Training labels.
#        - 'test/X_test.txt': Test set.
#        - 'test/y_test.txt': Test labels.
       
## assume it is located in the working directory and called HARData.
## X_test.txt data is fixed width of 17, 16, 16, 16, .... out to 8977
## so, it is 17, rep(16,560), index can be read from features.txt
## apply it to the dataset and then look for things that contain 
##    'mean()' and 'std()'
## subject_test.txt and y_test.txt are single columns
##  -these will have to be brought into the data as well, for later
##    sorting
## body_acc_x_test.txt is 2049 wide, so 17, rep(16,127)    

##setwd('d:/Coursera_Data_Science/GetCleanAssign/GettingCleaningAssignment')
library(dplyr)
library(plyr)
##### Steps 0 and 2 #####
#library(data.table)
# Read in the column names
column_names <- read.table('UCI HAR Dataset/features.txt', header = F)
# Read in the dataset
colsClass <- c(rep("numeric",561))
print(length(colsClass))
##del widths <- c(17, rep(16,560))
trainX <- read.table('UCI HAR Dataset/train/X_train.txt', sep = "", header = F,
                   colClasses= colsClass, col.names = column_names[,2])
#trainX <- trainX[,grep("mean()",colnames(trainX))] #this will subset for mean only, need to include std()

## convert to data table and select mean and std rows
trnX <- tbl_df(trainX)
trnX <- select(trnX, contains(".mean.", ignore.case = F), 
               contains(".std.", ignore.case = F))
## free up some memory
rm("trainX")
## read in the other data and add in to the data table
subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt',
                            header = F, col.names = "Subject")
subj_trn <- tbl_df(subject_train)
rm("subject_train")



labels_train <- as.matrix(read.table('UCI HAR Dataset/train/y_train.txt', header = F,
                                     col.names = "Labels"))
labels_train <- as.data.frame(mapvalues(labels_train, from = activity_labels$number,
                          to = activity_labels$label))
labels_trn <- tbl_df(labels_train)
#rm("labels_train")

activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt', sep = "",
                              header = F, col.names = c("number", "label"))
print("train data ok")
## do the same for test data
testX <- read.table('UCI HAR Dataset/test/X_test.txt', sep = "", header = F,
                     colClasses= colsClass, col.names = column_names[,2])
print("74")
tstX <- tbl_df(testX)
tstX <- select(tstX, contains(".mean.", ignore.case = F), 
               contains(".std.", ignore.case = F))
rm("testX")
print("79")
subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt',
                            header = F, col.names = "Subject")
subj_tst <- tbl_df(subject_test)
rm("subject_test")
print("84")
labels_test <- as.matrix(read.table('UCI HAR Dataset/test/y_test.txt', header = F,
                                    col.names = "Labels"))
labels_test <- as.data.frame(mapvalues(labels_test, from = activity_labels$number,
                          to = activity_labels$label))
labels_tst <- tbl_df(labels_test)
rm("labels_test")
print("89")


##### Step 1 ##### Merge the Dataset
# Column bind the train data
train_index <- cbind(subj_trn, labels_trn)
print("first row bind OK")
train <- cbind(train_index, trnX)
print("second row bind ok")
print(dim(train))
# Column bind the test data
test_index <- cbind(subj_tst, labels_tst)
test <- cbind(test_index, tstX)
print(dim(test))
# column bind the test and train
big_data <- tbl_df(rbind(train,test))

##### Step 2 ##### Extract mean and std dev only
#small_data <- select(big_data, contains(".mean.", ignore.case = F), 
#                     contains(".std.", ignore.case = F))

##### Step 3 ##### Descriptive Activity Names
#big_data$Labels <- activity_labels$label[big_data$Labels]

##### Step 4 ##### Appropriately Label Columns



##### Step 5 #####
# Write the tidy data to a txt file

#write.table(variable_name_here, file = "tidyData.txt", row.name = FALSE)
