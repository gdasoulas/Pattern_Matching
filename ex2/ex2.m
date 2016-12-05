clear
clc

%%
rmpath(genpath('../HMMall/'));

names=dir('./train/*.wav');
for i=1:133
    voice(i)=Sound(names(i).name);
end

clear i names
%%

data = class_divide(voice);
[TrainData,TestData]=dividett(data);
clear data

%% Ekpaideysi 9 montelwn 10 fores 

addpath(genpath('../HMMall/'));


States=6;
Mixtures=2;
Itters=10;


% ekpaideyoyme ta 9 montela 10 fores gia pio swsta apotelesmata , giati 
% oi times akriveias kymainontai

for i=1:10
classify_obj(i)= Classifier(Itters,States,Mixtures,TrainData);
end

%% Classification with voting 


counter=0;
for i=1:9
    for j=1:size(TestData{i},2)
        for k = 1:10
            prediction(k)=Classify(classify_obj(k),TestData{1,i}{1,j}); 
        end
        res{i}(j)= mode(prediction);
        counter = counter + (res{i}(j)==i);
    end
end

num = 45;  % plithos test data
fprintf('Accuracy rate: %f%%\n',(counter*1.0)/num*100); 

clear i Itters Mixtures States counter prediction j k num


%% Finding best classifier of 10
old_counter=0;
for k=1:10 
counter=0;
    for i=1:9
        for j=1:size(TestData{i},2)
            predicti=Classify(classify_obj(k),TestData{1,i}{1,j}); 
            counter = counter + (predicti==i);
        end
    end
    if (counter>old_counter)
        old_counter=counter;
        max_class=k;
    end
end

counter=old_counter;
num=45;
fprintf('Best accuracy rate from 10 classifiers: %f%%  for classifier %d\n',(counter*1.0)/num*100,max_class); 


clear i j old_counter num predicti k counter
%% bima 13
%k1=8

States=6;
Mixtures=2;

k1=8;
Train_k1{1} = TrainData{k1};

for Itters=5:15
    classi = Classifier(Itters,States,Mixtures,Train_k1);
    for j=1:5
        loglik(Itters,j) = classi.models(1).LL(j);
    end
end

for i=1:5
    plot(loglik(:,i));
    hold on;

end
 
clear i Train_k1 j loglik k1
 %% bima 14
 % Confusion matrix 
 % res{j}(i) = to apotelesma gia thn i-ekfwnisi toy psifiou j
 
 ConfMatrix = zeros(9,9);
 
 for i=1:9
     for j=1:size(TestData{i},2)
         ConfMatrix(i,res{i}(j))=ConfMatrix(i,res{i}(j))+1; 
     end
 end

 
 clear i j res
     
 
 %% Bhma 15 -Viterbi

 
k1=8;
wanted_classifier = classify_obj(1,max_class) ; % keeping best classifier

for i=1:9
    figure;
    for j=1:size(TrainData{1,i},2)
         model=wanted_classifier.models(1,i);
         obslik = mixgauss_prob(TrainData{1,i}{1,j},model.mu2,model.Sigma,model.mixmat2);
         viter_path=viterbi_path(model.prior,model.transmat,obslik);
         hold on;
         plot(viter_path);
         title(strcat('Viterbi path for digit=',num2str(i)));
    end
end
 
clear i k1 model obslik wanted_classifier