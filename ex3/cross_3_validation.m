function  [fin_p_val,fin_p_act]= cross_3_validation(music_file_rand,final_val,final_act,char_step)
    for c=1:3
        music_file_rand =music_file_rand(randperm(size(music_file_rand,2)));

        Train_Ratio = 0.8;  % 80% traindata - 20% testdata
        split_orio  = int16(Train_Ratio*size(music_file_rand,2));

        TrainData = music_file_rand(1:split_orio); 
        TestData = music_file_rand((split_orio+1):end); 

        if (char_step == 1)
            % Xaraktiristika apo bhma 6 
            for i=1:size(TrainData,2)
                TrainData_1(i,:) = TrainData(i).char;
            end
            for i=1:size(TestData,2)
                TestData_1(i,:) = TestData(i).char;
            end
        elseif (char_step == 2)
            % Xaraktiristika apo bhma 7 
            for i=1:size(TrainData,2)
                TrainData_1(i,:) = TrainData(i).mffcmean;
            end
            for i=1:size(TestData,2)
                TestData_1(i,:) = TestData(i).mffcmean;
            end
        else
            % Syndyasmos xarakthristikwn 6 k 7 
            for i=1:size(TrainData,2)
                TrainData_1(i,:) = TrainData(i).char;
            end
            for i=1:size(TestData,2)
                TestData_1(i,:) = TestData(i).char;
            end
        end
             
        Eu_dist = pdist2(TestData_1,TrainData_1,'euclidean');
        
        [p_val,p_act]=k_nearest_neighbor(TrainData_1,TestData_1,Eu_dist,1,final_val,final_act);

        success_val(c) = size(p_val,1);
        success_act(c) = size(p_act,1);
        
    end
    
    
    fin_p_val = mean(success_val)/size(TestData_1,1);  
    fin_p_act = mean(success_act)/size(TestData_1,1);

end