# CodeBook.md

This codebook details the transformations and work performed on cleaning up the data for analysis.

# Source Dataset

The source dataset is originally from the following location:

```
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
```

This is made available for Coursera students via an AWS CloudFront content delivery network, at the following location:

```
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
```

This file was downloaded via the following R command into the dataset.zip file:

```
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "dataset.zip")
```

Once unzipped, the data is contained in a directory with the following structure:

* UCI HAR Dataset
	* test
		* Inertial Signals
	* train
		* Inertial Signals

The data is described in the file "UCI HAR Dataset/README.txt" - which refers to other fiels such as features.txt, activity_labels.txt, etc.
	
	