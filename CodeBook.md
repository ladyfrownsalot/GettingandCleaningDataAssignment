---
title: "CodeBook"
output: html_notebook
---

## Data Set

### Files

| Filename.ext        | Description                                                                                                   |
|---------------------|---------------------------------------------------------------------------------------------------------------|
| features.txt        | List of all features (what I called variables)                                                                |
| activity_labels.txt | Links the class labels with their activity name                                                               |
| X_train.txt         | Training data set                                                                                             |
| y_train.txt         | Training labels                                                                                               |
| X_test.txt          | Test data set                                                                                                 |
| y_test.txt          | Test labels                                                                                                   |
| subject_train.txt   | Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. |
| subject_test.txt    | Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. |

## Transformations

The order of operations of this dataset was as follows:

1.  Load tables
2.  Join/bind tables
    -   Test data with test labels

    -   Train data with train labels

    -   Other attributes (activity/variables) with test and train data
3.  Convert data from wide to narrow
4.  Subset data for only those columns containing mean and std data
5.  Create a final table from the subset of data that calculated the mean of each variable by subject and activity

(For more detailed steps please see the R script or the RMD.)

Final list of deliverables include the following:

-   run_analysis.R

    -   R script with original script

-   run_analysis.RMD

```{=html}
<!-- -->
```
    -    R Markdown that goes through script in chunks

    -    Very detailed walk-through notes

-   Week4_run_analysis_assignment_FINAL.csv

```{=html}
<!-- -->
```
    -    Final output from original script

-   CodeBook.md

```{=html}
<!-- -->
```
    -    This document
