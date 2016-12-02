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

for i=1:9
    model(i) = hmm_digit_fix(Itters,States,Mixtures,data{i});
end

%%

for i=1:9
    model(i) = hmm_train_fix(model(i));
end

clear i Itters Mixtures States
