#get help on unzip to get an idea of what is expected

help(unzip)

#get the url of the zipped file

myzippedurl<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#pass the the url to the download.file function

download.file(myzippedurl,destfile="Dataset.zip")

#list the files in the current working directory
list.files()
#create a directory where files will be unzipped to
dir.create("zipped")
#unzip files to the created directory
unzipped=unzip(zipfile="Dataset.zip",exdir="zipped")
#set working directory to train directory so as to be able to import datasets
setwd("d://CHS/TB Program/Ref/Cleaning Data/zipped/UCI HAR Dataset/train")
#list the files in the directory
list.files()
# first read the files from "train" into R, assigning them to uniquely named objects
subjectTrain=read.table("subject_train.txt",header=FALSE)
	dim(subjectTrain)
Xtrain=read.table("X_train.txt",header=FALSE,sep="", stringsAsFactors=FALSE,dec=".")
	dim(Xtrain)
ytrain=read.table("y_train.txt",header=FALSE)
	dim(ytrain)
#next, combine the three files column wise using cbind
#you get a data frame of 7352 rows and 563 columns. A column from subjectTrain, a column from ytrain and 563 columns from Xtrain
traindataset=cbind(subjectTrain,ytrain,Xtrain)
	dim(traindataset)
#change directory to test so as to read datasets from this directory
setwd("d://CHS/TB Program/Ref/Cleaning Data/zipped/UCI HAR Dataset/test")
#list files in the directory to know if the files you need are in the directory
list.files()
# import the three files of interest into r getting their dimension in the process 
subjectTest=read.table("subject_test.txt",header = FALSE)
	dim(subjectTest)

Xtest=read.table("X_test.txt",header=FALSE,sep="", stringsAsFactors=FALSE,dec=".")
	dim(Xtest)

yTest=read.table("y_test.txt",header=FALSE)
	dim(yTest)

#now cbind the three datasets into one, ensuring the order of the combination so as to match the earlier cbind with the first set of datasets
# you get a data frame with 2947 rows and 563 columns

testdataset=cbind(subjectTest,yTest,Xtest)
	dim(testdataset)

#now you are ready to rbind the two datasets obtained through cbind. the new dataset will have 10299 rows and 563 columns

newdataset=rbind(traindataset,testdataset)
	dim(newdataset)

#provide descriptive names for the columns of the newdataset
#the names will come from the features file so that each measurement is a column name in the dataset
#first import the features file into r
headers=read.table("features.txt",header=FALSE,row.names=1)
#headers is a data frame with 561 rows and 1 column
#Transpose headers to make it into a dataframe with 1 row and 561 columns

headers2=t(headers)
	dim(headers2)
#set the col names of the newdataset based on the first row of the headers2 data frame.
#the fisrt two names of the newdataset are set to "subject" and "activities" to correspond to subjects involved in the experiment and activities they were involved in

names(newdataset)=c("subjects","activities",headers2[1,])

#subset the dataset so that you only get the columns for mean and standard deviation for each measurement
# extract only columns whose names contain eith "mean" or "std"
newdataset2=newdataset[,c("subjects","activities","tBodyAcc-mean()-X","tBodyAcc-mean()-Y","tBodyAcc-mean()-Z","tBodyAcc-std()-X","tBodyAcc-std()-Y","tBodyAcc-std()-Z","tGravityAcc-mean()-X","tGravityAcc-mean()-Y","tGravityAcc-mean()-Z","tGravityAcc-std()-X","tGravityAcc-std()-Y","tGravityAcc-std()-Z","tBodyAccJerk-mean()-X","tBodyAccJerk-mean()-Y","tBodyAccJerk-mean()-Z","tBodyAccJerk-std()-X","tBodyAccJerk-std()-Y","tBodyAccJerk-std()-Z")]

#use descriptive activity names to name the activity in dataset
newdataset2$activities[newdataset2$activities==1]="Walking"
newdataset2$activities[newdataset2$activities==2]="Walking upstairs"
newdataset2$activities[newdataset2$activities==3]="Walking downstairs"
newdataset2$activities[newdataset2$activities==4]="Sitting"
newdataset2$activities[newdataset2$activities==5]="Standing"
newdataset2$activities[newdataset2$activities==6]="Laying"

#lastly get the average of each variable in the dataset for each activity and each subject



