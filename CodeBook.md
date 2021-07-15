------------------------------------------------------------------------

---
output: html_document
---

# ***Cleaning and Getting Data*** **Code Book Project**

# ***EXECUTION FILE***

run_analysis.R : The R script that executes the algorithm to load the data files from internet, to transfer the data to memory to be cleaned, transformed, merged, summarized and prepared the final output file to be be used for later analysis.

The algorithm has been divided for its execution in a series of stages:

1.  Loading Data Files

2.  Tidying Data

3.  Generating Data File

4.  Loading Data Files:

1.1 Download the zip data set, then unzip the data files

1.2 Read imported data in data frame table structures to set up data in a tidy format

1.3 Display the downloaded data files to know their contents

2.  Tidying Data:

2.1 Merges the training and the test sets to create one data set.

2.2 Extracts only the measurements on the mean and standard deviation for each measurement.

2.3 Uses descriptive activity names to name the activities in the data set

2.4 Appropriately labels the data set with descriptive variable names.

2.5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

3.  Generating Data File

3.1 Write out the data results in text data format.

Reference the file for more detailed information on each stage.

# ***DATA FILES***

1.  ZipFileProject.zip : It contains all the data files under a zip format that was loaded from the web site:

    <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

2.  summary_by_subj_activ.txt : The output file that contains a summarized mean of each variable grouped by subject and activity

3.  UCI HAR Dataset : This a folder that contains all data files already unzipped.

    1.  activity_labels.txt : It represents the 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) that each subject must perform in the study.

    2.  features_info.txt : It gives information of the features used to register the signals for each variable name used in the study. Please, refer to the file to obtain more information.

    3.  features.txt : It shows the entire set of variable names (561)

    4.  README.txt : It give an overall description of each file under the folder: UCI HAR Dataset

    5.  train and test folders : they contains the data files that will be merged as part of the process. The "train" folder represents 70% of the volunteers selected for generating the data while the "test" folder represents the 30% of the volunteers.

        1.  subject_test.txt : It contains the id numbers that represent each of the 30 volunteers selected.

        2.  X_test.txt : Test set

        3.  y_test.txt : Test labels

        4.  subject_train.txt : Equivalent to the test data file

        5.  X_train.txt : Equivalent to the test data file

        6.  y_train.txt : Equivalent to the test data file
