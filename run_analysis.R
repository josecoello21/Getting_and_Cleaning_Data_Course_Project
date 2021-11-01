library(tidyverse)
library(readr)
source('functions.R')

if(!file.exists('dataset.zip')){
    url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
    download.file(url = url, destfile = 'dataset.zip')
}

if(!file.exists('UCI HAR Dataset')){
    unzip(zipfile = 'dataset.zip', exdir = getwd())
}

# 1. Merges the training and the test sets to create one data set.

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

total_summ <- summ(x = data_sets)
total_summ

# 5. From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.
total_summ %>% 
    as.data.frame %>% 
    select(contains('mean')) -> var_mean

# write output
files <- all(!file.exists('measurements.txt') & !file.exists('mean.txt'))
if(files){
    measurements <- total_summ %>% 
        as.data.frame(row.names = rownames(total_summ)) %>% 
        rownames_to_column(var = 'datasets')
    
    mean_df <- measurements %>% 
        select(datasets, mean)
    
    write_delim(x = measurements, file = 'measurements.txt',delim = ',')
    write_delim(x = mean_df, file = 'mean.txt', delim = ',')
}
