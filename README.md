##Summary of Data From Human Activity Recognition Dataset
### content by: Michael Crocco
### for:        Getting and Cleaning Data course by Coursera and Johns Hopkins

A large dataset of calculated values is provided by Samsung to be tidied and summarized.

This dataset exists across a number of files representing two sets (test and train) as well as individual files for test subject number and the test type (the activity conducted).

Assuming the directory provided '''UCI HAR Dataset''' is in the working directory, the uploaded R script '''run_analysis.R''' will download the provided data, combine the data and tidy the variable names, summarize the mean of the data by subject and activity (individual tests), and output to '''tidyData.txt''' file in the working directory.
The variables in the tidied data, in addition to the '''subject''' and '''activity''' details use the following naming convention, more detail is provided in '''CodeBook.md''' in this repository.

Naming of variables:
***

###mean[Reference][Measurement][Magnitude][Calculation][Axis]-[Domain]

Reference: Body or Gyro
Measurement: Acceleration or Jerk
Magnitude: if it is the Scalar total value
Calculation: Mean or Std. Deviation
Axis: X, Y or Z axis (if not Magnitude)
Domain: Time domain values or Frequency domain (result of FFT calculation)