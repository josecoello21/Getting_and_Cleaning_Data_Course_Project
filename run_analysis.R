library(tidyverse)
library(readr)

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if(!file.exists('dataset.zip')){
    download.file(url = url, destfile = 'dataset.zip')
}

if(!file.exists('UCI HAR Dataset')){
    unzip(zipfile = 'dataset.zip', exdir = getwd())
}

# 1. Merges the training and the test sets to create one data set.

# data reading function
dataset <- function(path, delim = '\\s', pattern = '\\s'){
    
    data <- read_delim(path, delim = delim, col_names = F) %>% 
        suppressMessages()
    
    data <- data$X1 %>% 
        str_split(pattern = pattern) %>% 
        unlist()
    
    data <- data[grepl(pattern = "\\S", x = data)] %>% 
        as.numeric()
}

# training and test data names
test_sets <- dir('UCI HAR Dataset/test/Inertial Signals')
train_sets <- dir('UCI HAR Dataset/train/Inertial Signals')

# training and test data path
test_path <- file.path('UCI HAR Dataset/test/Inertial Signals', test_sets)
train_path <- file.path('UCI HAR Dataset/train/Inertial Signals', train_sets)

paths <- c(test_path, train_path)

# data reading
data_sets <- lapply(X = paths, FUN = dataset)

names(data_sets) <- c(test_sets, train_sets) %>% 
    gsub(pattern = '[.].+', replacement = '')

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# mean calculation function and standard deviation
summ <- function(x, set = 'train'){
    # average calculation
    avg <- sapply(X = x, FUN = mean)
    
    # calculation of standard deviation
    s_d <- sapply(X = x, FUN = sd)
    
    # descriptive activity names to name the activities in the data set
    row_names <- names(x) %>% 
        gsub(pattern = '_test|_train', replacement = '')
    
    # data set with descriptive variable names. 
    colum_names <- paste(set, c('mean','sd'), sep = '_')
    
    # mean and standard deviation results
    matrix(data = c(avg, s_d), 
           nrow = c(length(avg), 2), 
           dimnames = list(row_names, colum_names) 
           )
}

# training and test subset
data_train <- data_sets[grep(pattern = 'train', x = names(data_sets))]
data_test <- data_sets[grep(pattern = 'test', x = names(data_sets))]

train_summ <- summ(x = data_train)
test_summ <- summ(x = data_test, set = 'test')
total_summ <- cbind(train_summ, test_summ)
total_summ

# 5. From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.
total_summ %>% 
    as.data.frame %>% 
    select(ends_with('mean'))
