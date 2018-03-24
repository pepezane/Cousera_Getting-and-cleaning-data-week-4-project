  ##read source data
  features <- read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/features.txt")
  activitylabels <- read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
  
  subtest <- read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
  xtest <- read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
  ytest <- read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
  
  subtrain <-read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
  xtrain <- read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
  ytrain <- read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")
  
  ##Add packages
  library(plyr)
  library(dplyr)
  
  #descriptive activity names 
  colnames(ytrain) <-"actID"
  colnames(ytest) <-"actID"
  colnames(subtrain) <-"subID"
  colnames(subtest) <-"subID"
  colnames(xtrain) <- features[,2]
  colnames(xtest) <- features[,2]
  
  #get mean and std measurements
  train <-xtrain[,grep("mean\\(|std\\(",names(xtrain))]
  test <-xtest[,grep("mean\\(|std\\(",names(xtest))]
  
  #merge data set
  xmerged <- cbind(subtrain,ytrain,train)
  ymerged <- cbind(subtest,ytest,test)
  final <- rbind(xmerged,ymerged)
  
  final$actlabel <- factor(final[,2],labels = activitylabels$V2)
  

  #tidy table
  
tidy <- aggregate(.~ (subID+actID+actlabel),final,mean)
  write.table(tidy,file = "./tidydata.txt", row.names = F, col.names = T)
  
  
