function  [fin_p_val,fin_p_act]= cross_3_validation(music_file_rand,final_val,final_act,char_step)
    for c=1:3
        rand_indices=randperm(size(music_file_rand,2));
        music_file_rand =music_file_rand(rand_indices);
        final_val = final_val(rand_indices);
        final_act = final_act(rand_indices);

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
                TrainData_3(i,:) = TrainData(i).char;
                TrainData_2(i,:) = TrainData(i).mffcmean;
                TrainData_1(i,:) = [TrainData_3(i,:) TrainData_2(i,:)];
            end
            for i=1:size(TestData,2)
                TestData_3(i,:) = TestData(i).char;
                TestData_2(i,:) = TestData(i).mffcmean;
                TestData_1(i,:) = [TestData_3(i,:) TestData_2(i,:)];
           
            end
        end
       
             
        Eu_dist = pdist2(TestData_1,TrainData_1,'euclidean');
        
        k=1;  % plithos neighbors pou koitame
        [p_val,p_act]=k_nearest_neighbor(TrainData_1,TestData_1,Eu_dist,k,final_val,final_act);

        success_val(c) = size(p_val,1);
        success_act(c) = size(p_act,1);
        
    end
    
    
    fin_p_val = mean(success_val)/size(TestData_1,1);  
    fin_p_act = mean(success_act)/size(TestData_1,1);

end