function  [accuracy,fscore]= cross_3_validation2(music_file_rand,kat_label)
    for c=1:3
        rand_indices=randperm(size(music_file_rand,1));
        music_file_rand =music_file_rand(rand_indices,:);
%         kat_val = kat_val(rand_indices);
%         kat_act = kat_act(rand_indices);
        kat_label = kat_label(rand_indices);

        Train_Ratio = 0.85;  % 80% traindata - 20% testdata
        split_orio  = int16(Train_Ratio*size(music_file_rand,1));

        TrainData_1 = music_file_rand(1:split_orio,:); 
        TestData_1 = music_file_rand((split_orio+1):end,:); 
        
       
        Eu_dist = pdist2(TestData_1,TrainData_1,'euclidean');
        
        
        for k=1:4
      
            [final_idx_label]=k_nearest_neighbor(TrainData_1,TestData_1,Eu_dist,2*(k-1)+1,kat_label);

            train_label = kat_label(1:size(TrainData_1,1));
            test_label = kat_label((size(TrainData_1,1)+1):end);

            [accuracy(k,c),~,~,fscore(k,c)]=evaluate_func(final_idx_label,test_label');

        end
    
    end

end