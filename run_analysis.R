## Final assignment Coursera course "Getting and Cleaning Data"
## Starting material: unzipped files in folder "UCI HAR_Dataset" in working directoy.

# Step 1: merge Train and Tex data sets
library(dplyr)
library(data.table)
#library(dtplyr)
#library(matrixStats)
library(reshape)

# first read in codes for activity:
features <- read.table("./UCI HAR_Dataset/features.txt")

# Read in train data:
subject_train <- read.table("./UCI HAR_Dataset/train/subject_train.txt")
names(subject_train) <- "participant"

# read in the big data set of train:
X_train <- read.table("./UCI HAR_Dataset/train/X_train.txt") 
# replace column name V2 to feature names
names(X_train) <- features$V2

y_train <- read.table("./UCI HAR_Dataset/train/y_train.txt")
names(y_train) <- "activity"

# cbind train data:
train_data <- cbind(subject_train, y_train, X_train)

#### now process tests: 
# Read in test data:
subject_test <- read.table("./UCI HAR_Dataset/test/subject_test.txt")
names(subject_test) <- "participant"

X_test <- read.table("./UCI HAR_Dataset/test/X_test.txt")
names(X_test) <- features$V2

y_test <- read.table("./UCI HAR_Dataset/test/y_test.txt")
names(y_test) <- "activity"

# cbind test data:
test_data <- cbind(subject_test, y_test, X_test)

## merge train and test:
merged_data <- rbind(train_data, test_data)

#### Step 2: add column "mean" and "sd" for each variable (according to name)
all_col <- names(merged_data)
col_mean_sd <- grepl("mean", all_col) | grepl("std", all_col) 
#  to get the participant and activity columns
col_mean_sd[1] <- TRUE
col_mean_sd[2] <- TRUE  

## subset columns:
merged_data_subset <- merged_data[, col_mean_sd]

#### Step 3: modify column names (use descriptive activity names)
### Step 4: Appropriately labels the data set with descriptive variable names
# both done.

# Step 5: in-depth data analysis: generate a result table with 
#         the average of each variable for each subject.
melted <- melt(merged_data_subset, id=c("participant", "activity"))
analysed <- dcast(melted, participant+activity ~ variable, mean)

# write ouput into result. omit the row.names, otherwise extra column for nothing.
write.csv(analysed, file="tidy.csv", row.names = FALSE)
