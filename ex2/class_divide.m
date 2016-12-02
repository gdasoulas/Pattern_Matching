function [Classes_voi]=class_divide(samples)
%Diaxwrismos twn 9 klasewn

    Classes_voice_temp{8}=samples(1:14);
    Classes_voice_temp{5}=samples(15:29);
    Classes_voice_temp{4}=samples(30:44);
    Classes_voice_temp{9}=samples(45:59);
    Classes_voice_temp{1}=samples(60:74);
    Classes_voice_temp{7}=samples(75:89);
    Classes_voice_temp{6}=samples(90:103);
    Classes_voice_temp{3}=samples(104:118);
    Classes_voice_temp{2}=samples(119:133);
    
    for i=1:9
        for j=1:size(Classes_voice_temp{i},2)
            tmp=cell(1);
            tmp{1}= Classes_voice_temp{i}(j).mffc_fframes;
            Classes_voice{i}(j) = tmp;
        end
    end
    
%     for i=1:size(Classes_voice,2)
%         for j=1:10
%             TrainData{1,i}{j}=Classes_voice{1,i}{j};
%         end
%         for j=11:size(Classes_voice{i},2)
%             TestData{1,i}{j-10}=Classes_voice{1,i}{j};
%         end
%     end

    
end

