%% First Lab - After first 9 questions ...

clear all;  clc;

fprintf('First Questions: Loading train.txt ,test.txt and computing m_all,s_all \n');

TrainData = load('train.txt');			% opening training file
Classes = [1:10];

for i=Classes
    temp = TrainData(find(TrainData(:,1)==(i-1)),:) ;	% finding all digits ,which correspond to digit i-1
    temp = temp(:,2:end);
    m_all(:,i) = mean(temp);
    s_all(:,i) = var(temp);
end


TestData = load('test.txt');

class3=zeros(3,2007);

 clear i temp;
 
%% Bhma 10

fprintf('--------------------------------\n 10th question ...\n Computing A priori Probabilities\n');

apriori = apriori_comp(TrainData,Classes);

%% Bhma 11


fprintf('--------------------------------\n 11th question ...\n Bayesian Classifier\n');

s_all_biased = s_all + (1/(4*pi+3)); % biased with 1/(4π+3) for better estimation 
%s_all_biased = s_all + (1/2*pi); % biased with 1/2π
    
h_x = bayes_classifier(TestData,m_all,s_all_biased,apriori,Classes);

% computing maximum h_x for classification 

for j=1:size(TestData,1)
	[~,idx(j)] = max(h_x(:,j));
    class3(1,j)=idx(j)-1;
end

Pred_bayes = (idx-1)';

p_bayes = find(TestData(:,1) == (idx(:)-1) );		% finding correct matches
bayes_failure= find(TestData(:,1) ~= (idx(:)-1) );		% finding wrong matches

bayes_success = size(p_bayes,1)/size(TestData,1);
fprintf('Success rate for Bayes : %f%%\n', bayes_success*100 );

clear j idx p_bayes;

%% Bhma 12

fprintf('--------------------------------\n 12th question ...\n Bayesian Classifier for Var=1\n');

s_all_one=ones(256,10);

h_x = bayes_classifier(TestData,m_all,s_all_one,apriori,Classes);

% computing maximum h_x for classification 

for j=1:size(TestData,1)
	[~,idx(j)] = max(h_x(:,j));
    end

p_bayes = find(TestData(:,1) == (idx(:)-1) );		% finding correct matches
bayes_success_var_1 = size(p_bayes,1)/size(TestData,1);
fprintf('Success rate for Bayes with Var=one : %f%%\n',bayes_success_var_1*100 );

clear j p_bayes s_all_one h_x idx

%% Bhma 13

%Nearest neighbor 

counter = 0;
lessTrain=A(1:1000,:);
lessTest=TestData(1:100,:);
for i=1:size(lessTest)
    [~,idx]= min(sum(bsxfun(@minus,lessTest(i,2:end),lessTrain(:,2:end)).^2 ,2));
    if A(idx,1) == TestData(i,1)
        counter=counter+1;
    end
end

fprintf('Success rate for 1nn with 100 test cases and 1000 train cases: %f%%\n',counter/size(lessTest,1)*100 );


%% Bhma 14
% Preprocess for NN
% Finding eucleideian distances 

fprintf('--------------------------------\n Preprocessing 14th question ...\n Computing Eucleideian Distances \n');

% for i=1:size(TestData)
%        Eu_dist(i,:)= sum(bsxfun(@minus,TestData(i,2:end),TrainData(:,2:end)).^2 ,2);
% end

Eu_dist = pdist2(TestData(:,2:end),TrainData(:,2:end),'euclidean');

clear i 

%% Bhma 14a
%Nearest neighbor 

fprintf('--------------------------------\n 14th question - a ...\n 1-Nearest Neighbor \n');


k=1;
p_1nn_success = k_nearest_neighbor(TrainData,TestData,Eu_dist,k);

fprintf('Success rate for k=%d-nn : %f%%\n',k,p_1nn_success*100 );


clear k idx counter
%% Bhma 14b

fprintf('--------------------------------\n 14th question - b ...\n k-Nearest Neighbor \n');

k=3;
p_nn_success = k_nearest_neighbor(TrainData,TestData,Eu_dist,k);
p_weighted_nn_success = k_weighted_nearest_neighbor(TrainData,TestData,Eu_dist,k);
fprintf('Success rate for k=%d-nn : %f%%\n',k,p_nn_success*100 );
fprintf('Success rate for weighted-k=%d-nn : %f%%\n',k,p_weighted_nn_success*100 );

clear k;

%% Bhma 15 -Good
%  running SVM script 
fprintf('--------------------------------\n 15th question ...\n 1st classifier : SVM implementation in python \n');

!python svmclass.py linear train.txt test.txt
Pred_svm_linear = load('predictions_svm_linear.txt');	

!python svmclass.py poly train.txt test.txt
Pred_svm_poly = load('predictions_svm_poly.txt');	

!python svmclass.py lin-rest train.txt test.txt
Pred_svm_lin_rest = load('predictions_svm_poly.txt');	

%%

fprintf('--------------------------------\n 15th question ...\n 2st classifier : MLP implementation in python \n');
!python nn_classifier.py train.txt test.txt

%% Bhma 15
filter_categories_2 =@(x) (@(y)(x==y) + (-1)*(x~=y));
opt=statset('MaxIter',500000); %it covergesssss
opt2=statset('MaxIter',100000); 
for i=1:10 
    SvnStruct_linear(i) = svmtrain(TrainData(:,2:end),arrayfun(filter_categories_2(i-1),TrainData(:,1)),'options',opt);
    SvnStruct_poly(i) = svmtrain(TrainData(:,2:end),arrayfun(filter_categories_2(i-1),TrainData(:,1)),'kernel_function','polynomial','polyorder',3,'options',opt2); %test order
end
%%
counter=0;
counter2=0;
for i=1:10
    G_l=svmclassify(SvnStruct_linear(i),TestData(:,2:end));
    G_p=svmclassify(SvnStruct_poly(i),TestData(:,2:end));
    for j=1:size(G_l)
        if(G_l(j)==1 && (i-1)==TestData(j,1))
            counter=counter+1;
        end
        if(G_p(j)==1 && (i-1)==TestData(j,1))
            counter2=counter2+1;
        end
        if(G_p(j)==1)
            class3(3,j)=i-1;
        end
    end
end
%maybe we need to check if it is clasified as 2 categories?
fprintf('Success rate for 1inear : %f%%\n',counter/size(TestData,1)*100 );
fprintf('Success rate for poly : %f%%\n',counter2/size(TestData,1)*100 );

%% Bhma 16
% Combining Bayes , NNR , SVM(poly)

comb_predictions=[Pred_3_nn Pred_bayes Pred_svm_poly];
Pred_comb1 = mode(comb_predictions,2);

p_comb1_success = find(TestData(:,1) == Pred_comb1(:));
p_comb1_success = size(p_comb1_success,1)/size(TestData,1);

fprintf('Success rate for combining Bayes,SVM(poly),3-NNR : %f%%\n',p_comb1_success*100 );

% Combining SVM(linear) , NNR , SVM(poly)

comb_predictions=[Pred_3_nn Pred_svm_linear Pred_svm_poly];
Pred_comb2 = mode(comb_predictions,2);

p_comb2_success = find(TestData(:,1) == Pred_comb2(:));
p_comb2_success = size(p_comb2_success,1)/size(TestData,1);

fprintf('Success rate for combining SVM(linear),SVM(poly),3-NNR : %f%%\n',p_comb2_success*100 );


clear comb_predictions






%% bima 16 a
% We are going to use Svn poly and bayers and NNR-1
counter=0;
Most_Freq=mode(class3);
for i=1:2007
    if(TestData(i,1)==Most_Freq(i))
        counter=counter+1;
    end
end
fprintf('Success rate for 3 class : %f%%\n',counter/size(TestData,1)*100 );
%% bima 17b
    indi_i=find(TrainData(:,1)==0);
    percent_i= ceil(size(indi_i)*0.8);
    A_80=[TrainData(indi_i(1:percent_i),:)];
    A_20=[TrainData(indi_i(percent_i+1:end),:)];
for i=2:10
    indi_i=find(TrainData(:,1)==i-1);
    percent_i= ceil(size(indi_i)*0.8);
    A_80=[A_80;TrainData(indi_i(1:percent_i),:)];
    A_20=[A_20;TrainData(indi_i(percent_i+1:end),:)];
end
dlmwrite('train_80.txt',A_80,'delimiter',' ','precision','%.4f');
dlmwrite('train_20.txt',A_20,'delimiter',' ','precision','%.4f');

!python svmclass.py poly train_80.txt train_20.txt
confidece_smv = load('confidence_smvpoly.txt');

for i=Classes
    temp = A_80(find(A_80(:,1)==(i-1)),:) ;	% finding all digits ,which correspond to digit i-1
    temp = temp(:,2:end);
    m_all1(:,i) = mean(temp);
    s_all1(:,i) = var(temp);
end
apriori = apriori_comp(A_80,Classes);
s_all_biased1 = s_all1 + (1/(4*pi+3));
h_x1 = bayes_classifier(A_20,m_all1,s_all_biased1,apriori,Classes)';

k=8;
nnr_conf= k_weigted_conf(A_80,A_20,k);

!python nn_classifier.py train_80.txt train_20.txt
confidece_nn = load('confidence_nn.txt');

!python svmclass.py linear train_80.txt train_20.txt
confidece_smvl = load('confidence_smvlinear.txt');
%%
clear total_conf;
total_conf(1,:,:)=nnr_conf;
total_conf(2,:,:)=confidece_smv;
total_conf(3,:,:)=confidece_smvl;

min_conf = min(total_conf);
max_conf = max(total_conf); 

means=(nnr_conf + confidece_smv+confidece_smvl)/3;
multt=(nnr_conf.*confidece_smv.*confidece_smvl);

succ_means=0;
succ_mult=0;
succ_min=0;
succ_max=0;


for i=1:size(A_20,1)
    [~,idx] = max(means(i,:));
    if(idx-1 == A_20(i,1))
        succ_means=succ_means+1;
    end
     [~,idx] = max(multt(i,:));
    if(idx-1 == A_20(i,1))
        succ_mult=succ_mult+1;
    end
     [~,idx] = max(min_conf(1,i,:));
    if(idx-1 == A_20(i,1))
        succ_min=succ_min+1;
    end
    [~,idx] = max(max_conf(1,i,:));
    if(idx-1 == A_20(i,1))
        succ_max=succ_max+1;
    end
    
end

fprintf('Success rate for mean : %f%%\n',succ_means/size(A_20,1)*100 );
fprintf('Success rate for mult : %f%%\n',succ_mult/size(A_20,1)*100 );
fprintf('Success rate for min : %f%%\n',succ_min/size(A_20,1)*100 );
fprintf('Success rate for max : %f%%\n',succ_max/size(A_20,1)*100 );


%%
k=8;
!python svmclass.py poly train.txt test.txt
confidece_smv_test = load('confidence_smvpoly.txt');
nnr_conf_test= k_weigted_conf(TrainData,TestData,k);
!python nn_classifier.py train.txt test.txt
confidece_nn_test = load('confidence_nn.txt');

!python svmclass.py linear train.txt test.txt
confidece_smvl_test = load('confidence_smvlinear.txt');
%%
clear total_conf;
total_conf(1,:,:)=nnr_conf_test;
total_conf(2,:,:)=confidece_smv_test;
total_conf(3,:,:)=confidece_smvl_test;

min_conf = min(total_conf);

succ_min=0;


A_20=TestData;
for i=1:size(A_20,1)

     [~,idx] = max(min_conf(1,i,:));
    if(idx-1 == A_20(i,1))
        succ_min=succ_min+1;
    end
    
end

fprintf('Success rate for min : %f%%\n',succ_min/size(A_20,1)*100 );

%%
a1=100;
a2=25;
a3=50;
a4=12;
New_train_data(:,2:11)= a1*nnr_conf + a2*confidece_smvl + a3*confidece_smv + a4*confidece_nn;
New_test_data(:,2:11)= a1*nnr_conf_test + a2*confidece_smvl_test + a3*confidece_smv_test + a4*confidece_nn_test;
New_train_data(:,1)=A_20(:,1);
New_test_data(:,1)=TestData(:,1);
dlmwrite('train_teleuteo.txt',New_train_data,'delimiter',' ','precision','%.4f');
dlmwrite('test_teleuteo.txt',New_test_data,'delimiter',' ','precision','%.4f');
!python nn_classifier.py train_teleuteo.txt test_teleuteo.txt


