clear all
clc
%% bhma 1 

names = dir('./PRcourse_Lab3_data/MusicFileSamples/*.wav');

%%
for i=1:412
    music_file(i)=Sound(names(i).name);
end

clear i 

%% bhma 2 


[val,act,cooccurence,labels]=stats();

for i=1:3
    mean_Valence(i) = mean(val(i,:));
    std_Valence(i) = std(val(i,:));
    mean_Activation(i) = mean(act(i,:));
    std_Activation(i) = std(act(i,:));
end

clear i 


%% bhma 3 

[agree_val,agree_act,diff_val,diff_act]= agreement(val,act);

for i=1:2
    for j=i+1:3
        figure;
        histogram(squeeze(diff_val(i,j,:)));
        xlabel('Difference I_{ij}-I{ik}');
        ylabel('Occurences');
        title(strcat('Histogram for Valence between No',num2str(i),' and No',num2str(j),' Annotators'));
        axis([-.5 4 0 inf]);
        saveas(gcf,strcat('diff_valence_',num2str(i),'_',num2str(j),'.png'));
        
        figure;
        histogram(squeeze(diff_act(i,j,:)));
        xlabel('Difference I_{ij}-I{ik}');
        ylabel('Occurences');
        title(strcat('Histogram for Activation between No',num2str(i),' and No',num2str(j),' Annotators'));
        axis([-.5 4 0 inf]);
        saveas(gcf,strcat('diff_activation_',num2str(i),'_',num2str(j),'.png'));
    end
end


%% bhma 4 - Knippendorf's alpha

alpha_val  = kriAlpha(val,'ordinal');
alpha_act  = kriAlpha(act,'ordinal');


%% bhma 5 - Telikes epishmeiwseis

final_val = mean(val,1);
final_act = mean(act,1);

hist_2D(final_val,final_act);


%% bhma 10 - katwfliwsi 

bad_indices1=find(final_val(:)==3);
bad_indices2=find(final_act(:)==3);
bad_indices=union(bad_indices1,bad_indices2);

final_val(:,bad_indices)=[];
final_act(:,bad_indices)=[];

for i=1:size(final_act,2)
    if final_act(i)<3
        final_act(i)=-1;
    else
        final_act(i)=1;
    end
    if final_val(i)<3
        final_val(i)=-1;
    else
        final_val(i)=1;
    end
end

%% bhma 11 - xwrismos set

for i=1:size(names,1)
    names_n{i}=names(i).name;
end    
[names_n,sort_ind]=sort_nat(names_n);
music_file = music_file(sort_ind);

music_file_rand=music_file;
music_file_rand(bad_indices)=[];

clear i


%% Bhma 11: 3-Fold Cross Validation 

for c=1:3

    music_file_rand =music_file_rand(randperm(size(music_file_rand,2)));
    
    split_orio  = int16(0.9*size(music_file_rand,2));
    
    TrainData = music_file_rand(1:split_orio); % 80% traindata
    TestData = music_file_rand((split_orio+1):end); % 20% testdata

    % Xaraktiristika apo bhma 6 
    for i=1:size(TrainData,2)
        TrainData_1(i,:) = TrainData(i).char;
    end
    for i=1:size(TestData,2)
        TestData_1(i,:) = TestData(i).char;
    end

    fprintf('--------------------------------\n Preprocessing 14th question ...\n Computing Eucleideian Distances \n');

    Eu_dist = pdist2(TestData_1(:,1:end),TrainData_1(:,1:end),'euclidean');

    [p_val,p_act]=k_nearest_neighbor(TrainData_1(:,1:end),TestData_1(:,1:end),Eu_dist,1,final_val,final_act);

    success_val(c) = size(p_val,1);
    success_act(c) = size(p_act,1);
    
end

fin_p_val = mean(success_val)/size(TestData_1,1);
fin_p_act=mean(success_act)/size(TestData_1,1);

clear c i j 