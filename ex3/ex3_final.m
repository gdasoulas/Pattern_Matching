clear all
clc
%% bhmata 1-9 

[val,act,~,~]=stats(0);

% Telikes epishmeiwseis

final_val = mean(val,1);
final_act = mean(act,1);

clear act val

%% bhma 10 - katwfliwsi kai proetoimasia tou struct 

[kat_val,kat_act,bad_indices]=thresholding(final_val,final_act);

% swsti taksinomisi twn arxeiwn 
music_file_rand=files_preproc();
music_file_rand(bad_indices)=[];

clear bad_indices


%% Bhma 11: 3-Fold Cross Validation 


[fin_p_val,fin_p_act]= cross_3_validation(music_file_rand,kat_val,kat_act,1);

