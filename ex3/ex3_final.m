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

cases = [1,2,3]; % feature cases
for i=1:3
    [acc_fold_val(:,i),acc_fold_act(:,i),fsc_fold_val(:,i),fsc_fold_act(:,i)]= cross_3_validation(music_file_rand,kat_val,kat_act,i);
%     fprintf ('Case %d\n',i);
%     fprintf ('Accuracy rate for valence : %f%%\n',mean(succ_fold_val(:,i))*100);
%     fprintf ('Accuracy rate for activation : %f%%\n',mean(succ_fold_act(:,i))*100);
end

clear i cases
