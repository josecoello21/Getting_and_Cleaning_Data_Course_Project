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

The dataset includes the following files:

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

## Project stages
1. First we download the dataset from the repository and then we unzip it.

2. We create two vectors that contain the path of both the training data and test data, then we concatenate both vectors into one called 'paths'.

3. We read each dataset and save it in a list called data.set.

4. Training, test and subject data are merged.

5. The mean and standard deviation of each measurement are extracted.

6. We label descriptive activity names for the activities in the data.

7. We label the data with descriptive variable names.

8. From the data set, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

9. We export the result to the working directory.
