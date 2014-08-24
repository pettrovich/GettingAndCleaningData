setwd("C:/Users/Andrés/Documents/coursera")

#Download and unzip the data if needed
if (!file.exists("UCI HAR Dataset")) {
  fileURL <- paste0("http://d396qusza40orc.cloudfront.net/",
                  "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
  zipfile <- ("rawdata.zip")
  download.file(fileURL,zipfile)
  unzip(zipfile)
  unlink(zipfile)
}

#Load the Trainig Data
training_data <- cbind(read.table("UCI HAR Dataset/train/subject_train.txt"),
                       read.table("UCI HAR Dataset/train/Y_train.txt"),
                       read.table("UCI HAR Dataset/train/X_train.txt"))

#Load the Test Data
test_data <- cbind(read.table("UCI HAR Dataset/test/subject_test.txt"),
                   read.table("UCI HAR Dataset/test/Y_test.txt"),
                   read.table("UCI HAR Dataset/test/X_test.txt"))

#Merge Training and Test into one data set
data <- rbind(training_data,test_data)

#Label the columns with the names taken from features.txt
names(data) <- c("Subject","Activity",
            as.character(read.table("UCI HAR Dataset/features.txt")$V2))

#Select only the columns with names including "mean()" or "std()"
needed_columns <- c(1,2,grep("mean\\(\\)|std\\(\\)", names(data)))
data <- data[needed_columns]

#Change the format of the column names
means <- names(data)[grep("mean\\(\\)", names(data))]
means <- paste(gsub("-mean\\(\\)", "", means),"Mean")
names(data)[grep("mean\\(\\)", names(data))] <- means

SDs <- names(data)[grep("std\\(\\)", names(data))]
SDs <- paste(gsub("-std\\(\\)", "", SDs),"SD")
names(data)[grep("std\\(\\)", names(data))] <- SDs

#Replace the code numbers for the activities with the names taken from activity_labels.txt
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
data$Activity <- activities[data$Activity,]$V2

#Creates a tidy data set with the average of each variable for each activity and each subject. 
tidy_data <- aggregate(data[,3:68],by=list(data$Subject,data$Activity),mean)
names(tidy_data)[1:2] <- c("Subject","Activity")

#Write the tidy data set to a file (tidy_data.txt)
write.table(tidy_data, row.name=FALSE, file="tidy_data.txt")
