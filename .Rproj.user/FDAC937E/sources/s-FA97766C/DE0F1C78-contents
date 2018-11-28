#!/usr/bin/python
import glob #finds path names matching specific pattern
import sys #provides access to system based functions especially those used at the console
import csv #module to support csv file operations
import os #supports os dependant functions

path="/Users/rasiimwe/hw09-rasiimwe/files/"  #change to your respective path
os.chdir(path) #change directory to file path

with open("dataset_merge.txt", "w") as out_file: #open file for writing - all files should be open
	os.chdir(path)
	for root, dirs, files in os.walk(path): #path crawl through the directory tree
		for file in files:
			if file.endswith("f.txt"): #interested in files that end with run.txt
        			#x = os.path.join(root, file)
				z = open(file,"r") #open the specific file
				for i in z: # for every line
                			out_file.write(i) #write the line to the outfile all.txt
out_file.close()
