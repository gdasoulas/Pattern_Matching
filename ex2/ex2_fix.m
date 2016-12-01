clear
clc

names=dir('./train/*.wav');
for i=1:133
    voice(i)=Sound(names(i).name);
end

clear i names
%%

data = class_divide(voice);
[train,test]=dividett(data);
%%

States=6;
Mixtures=2;
Itters=10;

classify_obj= Classifier(Itters,States,Mixtures,train);

% for i=1:9
%     model(i) = hmm_train(model(i));
% end

clear i Itters Mixtures States
%% bima 13

States=6;
Mixtures=2;
var_digit8=hmm_digit_fix(15,States,Mixtures,train{8});
 data_for_plot = var_digit_plot.LL;
 plot(data_for_plot,[1,..,15]) ; % i oti thelei
 
 %% Viterbi

 for i=1:length(data{8})
     obslik = multinomial_prob(train{8}(i,:),var_digit8.mixmax2);
     viter_path=viterbi_path(var_digit8.prior2,var_digit8.transmat,obslik);
     hold on;
     add_to_plot(viter_path); %????
 end
 