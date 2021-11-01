---
title: "CodeBook"
output: github_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Data sets

Here are the data for the project:

 [data_sets](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 

## The dataset

The following files are available for the train and test data. Their descriptions are equivalent.

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_y_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. The same description applies for the 'body_acc_y_train.txt' and 'body_acc_z_train.txt' files for the Y and Z axis.

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. The same description applies for the 'body_gyro_y_train.txt' and 'body_gyro_z_train.txt' files for the Y and Z axis.

## Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

## Project stages
1. First we download the dataset from the repository and then we unzip it.

2. we create two vectors that contain the path of both the training data and test data, then we concatenate both vectors into one called 'paths'.

3. In a separate script we develop two functions called:

- dataset function
- summ function

The first reads the data set, each record represents a numeric vector in text format, we separate each element and only extract the numbers and change to numeric format.

The second function calculates the average and standard deviation for each of the supplied data (body_acc_x_train.txt, body_acc_x_test.txt, ...) and returns a matrix with the average and deviation of each of the data.

4. We read each dataset and save it in a list called datasets.

5. We call the 'summ function' and supply the 'data_sets' list that contains each of the data sets, in order to obtain the mean and deviation.

6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

7. Finally we write both data and call it 'measurements.txt' and 'mean.txt'.






