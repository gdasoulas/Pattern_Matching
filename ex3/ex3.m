clear all
clc

%%

names = dir('./PRcourse_Lab3_data/MusicFileSamples/*.wav');
for i=1:10
    music_file(i)=Sound(names(i).name);
end

clear i 