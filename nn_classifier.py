from sknn.mlp import Classifier, Layer
import numpy as np
import logging

logging.basicConfig()

train_file_name = sys.argv[1]
test_file_name = sys.argv[2]

TrainData=[]
TestData=[]
Classes = range(0,10)

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

nn = Classifier(
    layers=[
        Layer("Sigmoid", units=100),
        Layer("Softmax")],
    learning_rate=0.02,
    n_iter=10)


X_train = TrainData[:,1:]
y_train = TrainData[:,0]

new_y_train = np.zeros((len(X_train),len(Classes)))

for i in range(0,len(TrainData)):
	new_y_train[i,int(y_train[i])]=1

nn.fit(X_train,y_train)


#y_valid = nn.predict(TestData[:,1:])

X_test = TestData[:,1:] 
y_test = TestData[:,0]

#score = nn.score(X_test, y_test)
X_test_pred = nn.predict(X_test)

counter=0
for i in range(0,len(X_test_pred)):
	if TestData[i,0]==X_test_pred[i]:
		counter = counter+1
	#else: 
	#	print "Error in i=",(i+1)," : TestData :",TestData[i,0]," and predictor : ",res[i]

print "Success rate for MLP classifier : ",counter/float(len(TestData))*100


