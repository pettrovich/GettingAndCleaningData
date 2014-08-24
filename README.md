## Getting and Cleaning Data Course Project

This repository contains a script (run_analysis.R) that processes the Samsung Galaxy S accelerometer data taken from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip". If the data has already been downloaded, it should be unzipped and stored in a folder called "UCI HAR Dataset", in the R working directory. If it isn't found in that location, the script will download the data.

When you run the script, using source("run_analysis.R"), it will create 4 data frame variables within R, containing different processed data sets:

* training_data (7352 rows): contains the full training data, including subject, activity, and all the statistical data for the 33 main features (561 total).
* test_data (2947 rows): contains the full test data, including subject, activity, and all the statistical data for the 33 main features (561 total)
* data (10299 rows): contains all the rows of the combined training and test data, including subject, activity, and the means and standard deviations of all 33 main features (66 total).
* tidy_data (180 rows): contains the combined training and test data, including subject, activity, and the means and standard deviations of all 33 main features (66 total), averaged for each subject/activity pair.

Finally, the script generates a text file with the tidy_data.


