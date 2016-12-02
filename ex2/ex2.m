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

%%

addpath(genpath('../HMMall/'));

States=6;
Mixtures=2;
Itters=10;

classify_obj= Classifier(Itters,States,Mixtures,TrainData);
%%
counter=0;
for i=1:9
    for j=1:size(TestData{i},2)
        res=Classify(classify_obj,TestData{1,i}{1,j});
        counter = counter + (res==i);
    end
end

num = 45;  % plithos test data
fprintf('Accuracy rate: %f%%\n',(counter*1.0)/num*100); 

clear i Itters Mixtures States



%% bima 13

States=6;
Mixtures=2;
var_digit8=hmm_digit(15,States,Mixtures,train{8});
 data_for_plot = var_digit_plot.LL;
 plot(data_for_plot,[1,..,15]) ; % i oti thelei
 
 %% Viterbi

 for i=1:length(data{8})
     obslik = multinomial_prob(train{8}(i,:),var_digit8.mixmax2);
     viter_path=viterbi_path(var_digit8.prior2,var_digit8.transmat,obslik);
     hold on;
     add_to_plot(viter_path); %????
 end
 