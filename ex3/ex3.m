clear all
clc

%% bhma 1 

names = dir('./PRcourse_Lab3_data/MusicFileSamples/*.wav');
for i=1:10
    music_file(i)=Sound(names(i).name);
end

clear i names

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
%         figure;
        hist(squeeze(diff_val(i,j,:)));
        xlabel('Difference I_{ij}-I{ik}');
        ylabel('Occurences');
        title(strcat('Histogram for Valence between No',num2str(i),' and No',num2str(j),' Annotators'));
        saveas(gcf,strcat('diff_valence_',num2str(i),'_',num2str(j),'.png'));
        
%         figure;
        hist(squeeze(diff_val(i,j,:)));
        xlabel('Difference I_{ij}-I{ik}');
        ylabel('Occurences');
        title(strcat('Histogram for Activation between No',num2str(i),' and No',num2str(j),' Annotators'));
        saveas(gcf,strcat('diff_activation_',num2str(i),'_',num2str(j),'.png'));

    end
end



