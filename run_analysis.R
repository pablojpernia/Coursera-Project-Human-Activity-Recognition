#=========================================================
#    Human Activity Recognition Course Project           
#=========================================================

# Purpose: 

#       The script will execute an algorithm to test a Human Activity Recognition 
#       data set obtained from the recordings of 30 subjects performing activities 
#       of daily living. A waist-mounted smart phone (Samsung Galaxy S II) was 
#       carried in with an embedded accelerometer and gyroscope sensors to record 
#       the sensor signals. 

#       The algorithm has been divided for its execution in a series of stages: 
#       
#               1. Loading Data Files
#               2. Tidying Data
#               3. Generating Data File
 
#===============================================================================

#********************************
# 1. Loading Data Files:        *
#********************************

# 1.1 Download the zip data set, then unzip the data files   

        # To list files in the directory before downloading   

        list.files(".")   
        
        # To define variables for URL data sourc, data file for zipped file, and folder for unzipped data
         
        zipurlfile      <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        zipdatafile     <- "ZipFileProject.zip" 
        unzipfolder_datasets <- "UCI HAR Dataset"
        
        # Checking if data file exists        
        
        if (!file.exists (zipdatafile)) {  
            
            download.file(zipurlfile, zipdatafile, method = "curl")
          }

        # Checking if folder exists       
        
        if (!file.exists(unzipfolder_datasets)) { 
               unzip(zipdatafile) 
          }
        
        # To list files in the directory after downloading  
        
        list.files(".")   
        
# 1.2 Read imported data in data frame table structures to Set up data 
#     in a tidy format  
        
        #  Define a vector of file names  
        
        vect_file_names <- c("UCI HAR Dataset/features.txt",
                             "UCI HAR Dataset/activity_labels.txt",
                             "UCI HAR Dataset/test/subject_test.txt",
                             "UCI HAR Dataset/test/X_test.txt",
                             "UCI HAR Dataset/test/y_test.txt",
                             "UCI HAR Dataset/train/subject_train.txt",
                             "UCI HAR Dataset/train/X_train.txt",
                             "UCI HAR Dataset/train/y_train.txt"
                        )
        
        #  Read files to be moved to a table data frame format
        
        tbldf_features      <- read.table(vect_file_names[1], col.names = c("code", "signals"))  
        
        tbldf_activity      <- read.table(vect_file_names[2], col.names = c("code", "activity"))  
        
        tbldf_test_subject  <- read.table(vect_file_names[3], col.names = c("subject"))  
        
        tbldf_test_X        <- read.table(vect_file_names[4], col.names = c(tbldf_features$signals))  
        
        tbldf_test_y        <- read.table(vect_file_names[5], col.names = c("code"))  
        
        tbldf_train_subject <- read.table(vect_file_names[6], col.names = c("subject"))  
        
        tbldf_train_X       <- read.table(vect_file_names[7], col.names = c(tbldf_features$signals))  
        
        tbldf_train_y       <- read.table(vect_file_names[8], col.names = c("code"))  
        
# 1.3 Display the downloaded data files to know their contents 
        
        #  Display out some records from each data frame to see their contents 
        
        head(tbldf_features);      head(tbldf_activity)  
        
        head(tbldf_test_subject);  head(tbldf_test_X, n = 1);  head(tbldf_test_y)
        
        head(tbldf_train_subject); head(tbldf_train_X, n = 1); head(tbldf_train_y)
                
#***********************
# 2. Tidying Data:     *
#***********************      

        # To load packages
        
        library(dplyr)
        library(tidyr)
      
# 2.1.	Merges the training and the test sets to create one data set.  
        
        # Bind by columns the test datasets into a single table data frame set
        
        tbldf_test <- cbind.data.frame(tbldf_test_subject, 
                                       tbldf_test_y, 
                                       tbldf_test_X )
        
        # Bind by columns the train datasets into a single table data frame set
        
        tbldf_train <- cbind.data.frame(tbldf_train_subject, 
                                       tbldf_train_y, 
                                       tbldf_train_X )
          
        # Bind by rows the test and train datasets into a single table data frame set
        
        tbldf_merged <- rbind.data.frame(tbldf_train, tbldf_test) 
       
        # Release memory spaces by removing test/train table data sets not to be used for 
        
        remove(tbldf_test_subject,  tbldf_test_X,  tbldf_test_y,
               tbldf_train_subject, tbldf_train_X, tbldf_train_y)
     
# 2.2.	Extracts only the measurements on the mean and standard deviation
#       for each measurement.         

        tbldf_mean_std <- tbldf_merged %>% 
                                    select(subject, 
                                           code, 
                                           contains("mean"), 
                                           contains("std"))
        
# 2.3.	Uses descriptive activity names to name the activities in the data set
        
       # Match the activity code in the mean_std data set with the activity code 
       # from the activity data set and place the descriptive activity.
        
         tbldf_mean_std$code <- as.character(tbldf_activity[
                                match(tbldf_mean_std$code, tbldf_activity$code), 
                                "activity"])
         
        #  Change subject and code column name by appropriate ones
        
        tbldf_mean_std <-  tbldf_mean_std %>%
                rename (subject_id = subject,
                        activity_labels = code)
       
# 2.4.	Appropriately labels the data set with descriptive variable names.
        
#       Install.packages("colr") 
        
        library(colr) # Package with function csub() to Select and Rename Columns
                      # via regular expressions
       
        tbldf_mean_std <- csub(tbldf_mean_std, "Acc", "Accelerometer")
        tbldf_mean_std <- csub(tbldf_mean_std, "BodyBody", "Body")
        tbldf_mean_std <- csub(tbldf_mean_std, "angle", "Angle")
        tbldf_mean_std <- csub(tbldf_mean_std, "gravity", "Gravity")
        tbldf_mean_std <- csub(tbldf_mean_std, ".mean", "Mean")
        tbldf_mean_std <- csub(tbldf_mean_std, ".std", "STD")
        tbldf_mean_std <- csub(tbldf_mean_std, ".tBody", "TimeBody")
        tbldf_mean_std <- csub(tbldf_mean_std, "^t", "Time")
        tbldf_mean_std <- csub(tbldf_mean_std, "^f", "Frequency")
       
# 2.5.	From the data set in step 4, creates a second, independent tidy 
#       data set with the average of each variable for each activity and each subject..
        
        summary_by_subj_activ <- tbldf_mean_std %>%
                                    group_by(subject_id, activity_labels) %>%
                                             summarise_all(mean)
       
        View(summary_by_subj_activ )

#****************************
# 3. Generating Data File:  *
#**************************** 
             
# 3.1.	Write out the result data in text data format
        
        write.table(summary_by_subj_activ, "summary_by_subj_activ.txt", row.name=FALSE)
        