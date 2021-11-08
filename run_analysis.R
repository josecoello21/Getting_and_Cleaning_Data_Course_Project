library(tidyverse)
library(reshape2)

if(!file.exists('dataset.zip')){
    url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
    download.file(url = url, destfile = 'dataset.zip')
}

if(!file.exists('UCI HAR Dataset')){
    unzip(zipfile = 'dataset.zip', exdir = getwd())
}

# 1. Merges the training and the test sets to create one data set.

# training and test data names
data_test <- dir('UCI HAR Dataset/test')[grepl(pattern = 'txt', x = dir('UCI HAR Dataset/test'))]
data_train <- dir('UCI HAR Dataset/train')[grepl(pattern = 'txt', x = dir('UCI HAR Dataset/train'))]

# training and test data path
path_test <- file.path('UCI HAR Dataset/test',data_test)
path_train <- file.path('UCI HAR Dataset/train',data_train)
paths <- c(path_test, path_train)

# data reading
data.set <- lapply(X = paths, FUN = read.table)
names(data.set) <- c(data_test, data_train)

# data mergers (test and train)
df_x <- bind_rows(data.set$X_test.txt, data.set$X_train.txt)
df_y <- bind_rows(data.set$y_test.txt, data.set$y_train.txt)
df_sub <- bind_rows(data.set$subject_test.txt, data.set$subject_train.txt)

# reading data activity labels and mean and std columns
paths2 <- file.path('UCI HAR Dataset', dir('UCI HAR Dataset')[1:2])
data.set2 <- lapply(X = paths2, FUN = read.table)
names(data.set2) <- dir('UCI HAR Dataset')[1:2]

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_sd <- data.set2$features.txt$V2 %>% 
    grep(pattern = 'mean()|std()', x = .)

df_x <- df_x %>% 
    select(mean_sd)

# 3. Uses descriptive activity names to name the activities in the data set
label <- c('WALKING','WALKING_UPSTAIRS','WALKING_DOWNSTAIRS',
           'SITTING','STANDING','LAYING')
df_y <- df_y %>% 
    mutate(V1 = factor(x = V1, levels = 1:6, labels = label))

# 4. Appropriately labels the data set with descriptive variable names. 
all_dat <- bind_cols(df_x, df_y, df_sub)

names_var <- data.set2$features.txt$V2[mean_sd] %>% 
    gsub(pattern = '(-mean.+-){1}', replacement = '_mean_') %>% 
    gsub(pattern = '(-mean.+){1}', replacement = '_mean') %>% 
    gsub(pattern = '(-std.+-){1}', replacement = '_std_') %>% 
    gsub(pattern = '(-std.+){1}', replacement = '_std')

names(all_dat) <- c(names_var, "Activity", "Subject")

# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject.
mean_data <- melt(all_dat, id = c("Subject", "Activity")) %>% 
    dcast(data = ., variable ~ Subject + Activity, fun.aggregate = mean)

# write output
files <- all(!file.exists('tidy_datasets.txt') & !file.exists('mean_data.txt'))
if(files){
    write.table(x = all_dat, file = 'tidy_datasets.txt')
    write.table(x = mean_data, file = 'mean_data.txt')
}
