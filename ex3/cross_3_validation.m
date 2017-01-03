function  [acc_val,acc_act,fsc_val,fsc_act]= cross_3_validation(music_file_rand,kat_val,kat_act,char_step)
    for c=1:3
        rand_indices=randperm(size(music_file_rand,2));
        music_file_rand =music_file_rand(rand_indices);
        kat_val = kat_val(rand_indices);
        kat_act = kat_act(rand_indices);

        Train_Ratio = 0.80;  % 80% traindata - 20% testdata
        split_orio  = int16(Train_Ratio*size(music_file_rand,2));

        TrainData = music_file_rand(1:split_orio); 
        TestData = music_file_rand((split_orio+1):end); 
        
        if (char_step == 1)
            % Xaraktiristika apo bhma 6 
            for i=1:size(TrainData,2)
                TrainData_1(i,:) = TrainData(i).char_arg;
            end
            for i=1:size(TestData,2)
                TestData_1(i,:) = TestData(i).char_arg;
            end
        elseif (char_step == 2)
            % Xaraktiristika apo bhma 7 
            for i=1:size(TrainData,2)
                TrainData_1(i,:) = TrainData(i).mffc_arg;
            end
            for i=1:size(TestData,2)
                TestData_1(i,:) = TestData(i).mffc_arg;
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
        
        [final_idx_val,final_idx_act]=k_nearest_neighbor(TrainData_1,TestData_1,Eu_dist,k,kat_val,kat_act);
        
        train_act = kat_act(1:size(TrainData_1,1));
        train_val = kat_val(1:size(TrainData_1,1));
        test_act = kat_act((size(TrainData_1,1)+1):end);
        test_val = kat_val((size(TrainData_1,1)+1):end);
        
        [acc_val(c),~,~,fsc_val(c)]=evaluate_func(final_idx_val,test_val');
        [acc_act(c),~,~,fsc_act(c)]=evaluate_func(final_idx_act,test_act');
        
    end

end