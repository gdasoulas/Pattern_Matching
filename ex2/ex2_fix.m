clear
clc

names=dir('./train/*.wav');
for i=1:133
    voice(i)=Sound(names(i).name);
end

clear i names
%%

data = class_divide(voice);

%%

States=6;
Mixtures=2;
Itters=10;

classify_obj= Classifier(Itters,States,Mixtures,data);

% for i=1:9
%     model(i) = hmm_train(model(i));
% end

clear i Itters Mixtures States
