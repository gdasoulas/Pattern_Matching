function [music_file]=files_preproc()
    names = dir('./PRcourse_Lab3_data/MusicFileSamples/*.wav');
    for i=1:size(names,1)
        names_n{i}=names(i).name;
    end

    [names_n,sort_ind]=sort_nat(names_n);

    load('file_chars_correct.mat');
    music_file = music_file(sort_ind); 
end