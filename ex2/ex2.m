clear
clc

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


%% Classification 


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

%%
for i=1:5
    plot(loglik(:,i));
    hold on;

end

%%

States=6;
Mixtures=2;
var_digit8=hmm_digit(15,States,Mixtures,train{8});
 data_for_plot = var_digit_plot.LL;
 plot(data_for_plot,[1,..,15]) ; % i oti thelei
 
 
 
 
 
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
     
 
 %% Viterbi

 for i=1:length(data{8})
     obslik = multinomial_prob(train{8}(i,:),var_digit8.mixmax2);
     viter_path=viterbi_path(var_digit8.prior2,var_digit8.transmat,obslik);
     hold on;
     add_to_plot(viter_path); %????
 end
 