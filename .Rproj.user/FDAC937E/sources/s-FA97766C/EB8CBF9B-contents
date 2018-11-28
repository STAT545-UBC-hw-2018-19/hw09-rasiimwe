# STAT 547M Homework 9 Repository of Rebecca Asiimwe 

## Theme: Automate Tasks and Pipelines
[<img align ="right" src="https://github.com/STAT545-UBC-students/hw09-rasiimwe/blob/master/plugins/pipelines.png" width="450" height="400"/>](https://github.com/STAT545-UBC-students/hw09-rasiimwe/blob/master/plugins/pipelines.png)

### Assignment overview

<p align = "justify">Pipelines are common in most walks of life, digital circuits, software, transportaion, industries, sales.... pipelines are almost everywhere! Pipelines used for data analysis take inputs which go through a number of processing steps that are chained together in some way to produce the desired output. They are sort of a chain of commands that can be run on one or more data sets - very helpful when we are going to have to rerun any analysis especially with multiple files. Makefiles are used to describe a pipeline of shell commands and the interdependencies of the input and output files of those commands.</p> 

### Benefits of automating analytics pipelines using R and Make:

* Automation helps us reproduce previous results and recreate deleted results. We can also rerun a pipeline with updated software or on a different dataset.
* Make can resume a pipeline after a failed command without needing to start over. It als has the ability to run independent jobs in parallel. 
* A Makefile can be easily displayed as a graphical flow chart of files and shell commands as a powerful way or interpreting and communicating pipelines.

### The developed pipeline:

**Problem at hand:**

I have a number of text files that contain words. Unfortunately, the files are disintegrated. They could have come from another pipeline as separate pieces of the same file and I would like to combine all of them into on large master file that I can use as my dataset.

**The Pipeline**

The pipeline starts with a [python component seed](https://github.com/STAT545-UBC-students/hw09-rasiimwe/blob/master/merger.py), `merger.py` that traverses the system directory tree of the specified path and looks for files with a certain pattern. The script then takes the files and concatenates them into one (Assuming that all files from a "prior" pipeline were put in one directory)

The output of `merger.py` file is [dataset_merge.txt](https://github.com/STAT545-UBC-students/hw09-rasiimwe/blob/master/files/dataset_merge.txt). This output file is then fed into the [trump_words.R](https://github.com/STAT545-UBC-students/hw09-rasiimwe/blob/master/trump_words.R) file that does required analyses on `dataset_merge.txt` and generates required plots as shown in the [md file](https://github.com/STAT545-UBC-students/hw09-rasiimwe/blob/master/trump_words.md). This md file was entirely generated for visualization.

### For the pipeline to run, please note the following: 

1. **Install python** using any of the methods specified [here](https://www.python.org) or [here](https://realpython.com/installing-python/) based on your operating system

2. Change the path in the `merger.py` file: `path="/Users/rasiimwe/hw09-rasiimwe/files/"` to align with your system environment.

### Install required packages
```r
install.packages("tm")  # to support text mining
install.packages("SnowballC") # to support text stemming
install.packages("wordcloud") # word-cloud generator 
```


### Repo Navigation:- Please visit the following main files :point_down::

|   **Homework Files**   | **Description** |
|----------------|------------|
|[Link to homework9](http://stat545.com/Classroom/assignments/hw09/hw09.html)|This file contains homework 09 tasks and their descriptions|
|[README.md](https://github.com/STAT545-UBC-students/hw09-rasiimwe/blob/master/README.md)|This readme.md file provides an overview of the ghist of this repo and provides useful pointers to key files in my homework-09 repo. Herein, are also links to past files that provide an introduction to data exploration and analysis |
|[Link to Makefile](https://github.com/STAT545-UBC-students/hw09-rasiimwe/blob/master/Makefile)|This file describes the  pipeline commands and the interdependencies of each of the input and output files|
|[Link to md file](https://github.com/STAT545-UBC-students/hw09-rasiimwe/blob/master/trump_words.md)|This file was rendered purposely for visualization|
|[Link to R script](https://github.com/STAT545-UBC-students/hw09-rasiimwe/blob/master/trump_words.R)|R source code that does the analyses on the merged dataset and provides required pipeline plots|
|[Files](https://github.com/STAT545-UBC-students/hw09-rasiimwe/tree/master/files)|Directory that contains the base files that were used for the merger done by the python script (\*.txt) |


### Sources to Acknowledge:
[STAT 5457M notes on automating Data-analysis Pipelines](http://stat545.com/automation04_make-activity.html)

[Text mining and word cloud fundamentals in R : 5 simple steps you should know](http://www.sthda.com/english/wiki/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know)

