# Coursera Getting and Cleaning Data Week 4 Assignment Script

This repository contains the 'Human Activity Recognition Using Smartphones' dataset taken from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and R scripts for cleaning the data as specified in the [Cleaning Data Week 4 Coursera assignment](https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project).

## The script

The run_analysis.R script combines the data in the training and test data sets and adds human-readable lables indicating the metric definitions and both the subject ID and activity type for each record. The complete, final dataset is stored to the variable all_df. A subset of this with columns relating only to the mean and standard deviation aggregations of the collected data is then stored to df_final. From here, the df_averages table summarises the mean of all the remaining data, grouped by subject ID and activity type.
