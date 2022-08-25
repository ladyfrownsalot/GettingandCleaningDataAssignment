# Thu Aug 25 14:50:14 2022 ------------------------------


library(dplyr)
library(data.table)

#bring in activity labels. These will be used to join names with the type of activity
act_labs<-read.table("UCI HAR Dataset/activity_labels.txt")
#bring in the feature lables. These will used to join names with the data types
feature<-read.table("UCI HAR Dataset/features.txt")
#bring in the test labels. These will be used to join activity type to the results in the test table
test_labs<-read.table("UCI HAR Dataset/test/Y_test.txt")
#bring in the test data
test=read.table("UCI HAR Dataset/test/X_test.txt")
#bring in subject test table
test_sub<-read.table("UCI HAR Dataset/test/subject_test.txt")
#bring in the train labels. These will be used to join activity type to the results in the train table
train_labs=read.table("UCI HAR Dataset/train/Y_train.txt")
#bring in the train data
train=read.table("UCI HAR Dataset/train/X_train.txt")
#bring in subject traintable
train_sub<-read.table("UCI HAR Dataset/train/subject_train.txt")

# 1. Merges the training and the test sets to create one data set.

#test data
#merge test data with label tables
test_labs2<-merge(test_labs, act_labs) %>% select(activity = V2)
#ensure the tables we want to merge next have the same number of rows
nrow(test) == nrow(test_labs2)
#they do!
test2<-cbind(test_labs2, test)
#bind with subject data
test3<-cbind(test2, test_sub)
#create list of features to add as column names in test dataframe
feature_list<-c("activity", feature$V2, "subject")
colnames(test3)<-feature_list
#create new column that says this is test data
test3$datatype<-"test"

#train data
#merge train data with label tables
train_labs2<-merge(train_labs, act_labs) %>% select(activity = V2)
#ensure the tables we want to merge next have the same number of rows
nrow(train) == nrow(train_labs2)
#they do!
train2<-cbind(train_labs2, train)
#bind with subject data
train3<-cbind(train2, train_sub)
#create list of features to add as column names in train dataframe
feature_list<-c("activity", feature$V2,"subject")
colnames(train3)<-feature_list
train3$datatype<-"train"

#bind train and test data together
data_all<-rbind(test3, train3)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
mean<-data_all[grep("[Mm]ean|activity|datatype|subject", names(data_all))]
std<- data_all[grep("[Ss]td|activity|datatype|subject", names(data_all))]
data2<-cbind(mean, std)

# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 3 and 4 were done in the merging steps above

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
cols=c(feature$V2)
data_all<-data.table(data_all)
d1<-melt(data_all, id.vars = c("subject", "datatype", "activity"), measure.vars=cols)
d1$subject<-as.character(d1$subject)

d2=d1
d2=d2[ , .(mean(value)),by=.(subject, activity, variable)]
rename(d2,average=V1)

