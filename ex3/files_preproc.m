function [music_file]=files_preproc()
%%    
names = dir('./PRcourse_Lab3_data/MusicFileSamples/*.wav');
    for i=1:size(names,1)
        names_n{i}=names(i).name;
    end

    names_old = names_n;
    [names_n,sort_ind]=sort_nat(names_old);

    load('file_chars_correct.mat');

    for i=1:size(names_old,2)
        tmp=strsplit(names_old{i}(5:end),'.');
        music_file(i).order=str2num(tmp{1});
    end

    for i=1:size(music_file,2)
        ord(i)=music_file(i).order;
    end
    
    music_file = music_file(sort_ind); 
    
    load('preqel.mat');
    for i=1:size(music_file,2)
        music_file(i).char_arg = feature(i,:);
        music_file(i).mffc_arg = mfcc(i,:);        
    end
    
    
end