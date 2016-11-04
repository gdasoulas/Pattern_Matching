import numpy as np
from sklearn import svm

TrainData=[]
TestData=[]
Classes = range(0,10)
with open("train.txt") as textFile:
    lines = [line.split() for line in textFile]
    for line in lines:
    	int_line=[float(x) for x in line]
	TrainData.append(int_line)

TrainData = np.array(TrainData)

with open("test.txt") as textFile:
    lines = [line.split() for line in textFile]
    for line in lines:
    	int_line=[float(x) for x in line]
	TestData.append(int_line)

TestData = np.array(TestData)

clf = svm.SVC(kernel='linear')
clf.fit(TrainData[:,1:], TrainData[:,0])

samp=TestData[17,1:]

res=[]
for i in range(0,len(TestData)):
	res.append(clf.predict([TestData[i,1:]]))
 
counter=0

for i in range(0,len(res)):
	counter = counter + (TestData[i,0]==res[i])


print "Success rate for SVM : ",counter[0]/float(len(TestData))*100



 
