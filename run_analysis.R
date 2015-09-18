# Goals of this script are:
# 0. Downloads data (or reads from a local file)
# 1. Merget the training and the test sets to create one data set
# 2. Extracts only the measurements on the mean and standard deviation for
#    each measurement
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names
# 5. From the data in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.

## read data from Human Activity Recognition Dataset
"""
The dataset includes the following files:
        =========================================
                - 'README.txt'
        - 'features_info.txt': Shows information about the variables used on the feature vector.
        - 'features.txt': List of all features.
        - 'activity_labels.txt': Links the class labels with their activity name.
        - 'train/X_train.txt': Training set.
        - 'train/y_train.txt': Training labels.
        - 'test/X_test.txt': Test set.
        - 'test/y_test.txt': Test labels.
"""        
## assume it is located in the working directory and called HARData.
## X_test.txt data is fixed width of 17, 16, 16, 16, .... out to 8977
## so, it is 17, rep(16,560), index can be read from features.txt
## apply it to the dataset and then look for things that contain 
##    'mean()' and 'std()'
## subject_test.txt and y_test.txt are single columns
##  -these will have to be brought into the data as well, for later
##    sorting
## body_acc_x_test.txt is 2049 wide, so 17, rep(16,127)    




##### Step 5 #####
# Write the tidy data to a txt file
write.table(variable_name_here, file = "tidyData.txt", row.name = FALSE)
