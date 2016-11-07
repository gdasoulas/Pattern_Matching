import numpy as np
import sys
from sklearn import svm

if len(sys.argv)<4:
	print "Give an option for kernels: linear or poly , train file , test file?"
	exit()
TrainData=[]
TestData=[]
Classes = range(0,10)
train_file_name = sys.argv[2]
test_file_name = sys.argv[3]
with open(train_file_name) as textFile:
    lines = [line.split() for line in textFile]
    for line in lines:
    	int_line=[float(x) for x in line]
	TrainData.append(int_line)

TrainData = np.array(TrainData)

with open(test_file_name) as textFile:
    lines = [line.split() for line in textFile]
    for line in lines:
    	int_line=[float(x) for x in line]
	TestData.append(int_line)

TestData = np.array(TestData)

if sys.argv[1] == 'lin-rest':
	clf = svm.LinearSVC()
else:
	clf = svm.SVC(kernel=sys.argv[1],probability=True)

clf.fit(TrainData[:,1:], TrainData[:,0])

samp=TestData[17,1:]

res=[]
for i in range(0,len(TestData)):
	res.append(clf.predict([TestData[i,1:]]))
conf=[]
for i in range(0,len(TestData)):
	conf.append(clf.predict_proba([TestData[i,1:]]))
filename ="predictions_svm_"+str(sys.argv[1])+".txt"
with open(filename,"w") as resFile:	 
	for i in range(0,len(TestData)):
		resFile.write(str(int(res[i]))+"\n")
filename = "confidence_smv"+str(sys.argv[1])+".txt"
print np.array(conf)
conf=[np.ravel(i) for i in conf]
print conf
#conf = map()
np.savetxt(filename,np.array(conf),'%1.5f',delimiter=' ')
counter=0
for i in range(0,len(res)):
	if TestData[i,0]==res[i]:
		counter = counter+1
	#else: 
	#	print "Error in i=",(i+1)," : TestData :",TestData[i,0]," and predictor : ",res[i]

print "Success rate for SVM - ",str(sys.argv[1])," : ",counter/float(len(TestData))*100



 
