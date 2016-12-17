clear all
clc

%% bhma 1 

names = dir('./PRcourse_Lab3_data/MusicFileSamples/*.wav');
for i=1:10
    music_file(i)=Sound(names(i).name);
end

clear i names

%% bhma 2 


[val,act,cooccurence,~]=stats();

for i=1:3
    mean_Valence(i) = mean(val(i,:));
    std_Valence(i) = std(val(i,:));
    mean_Activation(i) = mean(act(i,:));
    std_Activation(i) = std(act(i,:));
end

clear i 




