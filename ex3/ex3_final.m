clear all
clc
%% bhmata 1-9 

[val,act,~,~]=stats(0);

% Telikes epishmeiwseis
 
final_val = mean(val,1);
final_act = mean(act,1);

clear act val

%% bhma 10 - katwfliwsi kai proetoimasia tou struct 

[kat_val,kat_act,bad_indices,bad_indices_val,bad_indices_act]=thresholding(final_val,final_act);

% swsti taksinomisi twn arxeiwn 
music_file_rand=files_preproc();
music_file_rand_val=files_preproc();
music_file_rand_act=files_preproc();
music_file_rand(bad_indices)=[];
music_file_rand_val(bad_indices_val)=[];
music_file_rand_act(bad_indices_act)=[];

clear bad_indices*


%% Bhma 11-13: 3-Fold Cross Validation 

cases = [1,2,3]; % feature cases
for i=1:3
%     [acc_fold_val(:,:,i),fsc_fold_val(:,:,i)]= cross_3_validation(music_file_rand_val,kat_val,i);
    [acc_fold_act(:,:,i),fsc_fold_act(:,:,i)]= cross_3_validation(music_file_rand_act,kat_act,i);
%     fprintf ('Case %d\n',i);
%     fprintf ('Accuracy rate for valence : %f%%\n',mean(succ_fold_val(:,i))*100);
%     fprintf ('Accuracy rate for activation : %f%%\n',mean(succ_fold_act(:,i))*100);
end

clear i cases



%% write to xls

filename = 'knnr_valence_acc.csv';
csvwrite(filename,acc_fold_val);


filename = 'knnr_valence_fsc.csv';
csvwrite(filename,fsc_fold_val);
%% Bayers?
cases = [1,2,3]; % feature cases
for i=1:3
%     [acc_fold_val(:,:,i),fsc_fold_val(:,:,i)]= cross_3_validation(music_file_rand_val,kat_val,i);
    [acc_fold_act(:,:,i)]= cross3bayers(music_file_rand_act,kat_act,i);
%     fprintf ('Case %d\n',i);
%     fprintf ('Accuracy rate for valence : %f%%\n',mean(succ_fold_val(:,i))*100);
%     fprintf ('Accuracy rate for activation : %f%%\n',mean(succ_fold_act(:,i))*100);
end

clear i cases

%% Bhma 14: PCA

for i=1:size(music_file_rand_act,2)
       TrainData_3(i,:) = music_file_rand_act(i).char_arg;
       TrainData_2(i,:) = music_file_rand_act(i).mffc_arg;
       TrainData_1(i,:) = [TrainData_3(i,:) TrainData_2(i,:)];
end
[cov data eigen]=myPCA(TrainData_1);
%eigenvalues 1-8 are aproximate 100% of variance
data=data(:,1:8);

 [acc_fold_act(:,:)]= cross_3_validation2(data,kat_act);
 [acc_fold_act2(:,:)]= cross3bayers2(data,kat_act);


%% Bhma 15: WEKA
% for i=1:size(music_file_rand_val,2)
%     inp_val(i,:)=[music_file_rand_val(i).char kat_val(i)];
%     arffwrite('valence',inp_val);
% end
% for i=1:size(music_file_rand_act,2)
%     inp_act(i,:)=[music_file_rand_act(i).char kat_act(i)];
%     arffwrite('activation',inp_act);
% end