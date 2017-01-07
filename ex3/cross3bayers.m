function  [accuracy]= cross3bayers(music_file_rand,kat_label)
kat_label(find(kat_label(:)==-1))=2;
 for c=1:3
        rand_indices=randperm(size(music_file_rand,2));
        music_file_rand =music_file_rand(rand_indices);
        kat_label = kat_label(rand_indices);

        Train_Ratio = 0.85;  % 80% traindata - 20% testdata
        split_orio  = int16(Train_Ratio*size(music_file_rand,2));

        TrainData = music_file_rand(1:split_orio); 
        kat_label_train = kat_label(1:split_orio);
        TestData = music_file_rand((split_orio+1):end);
        kat_label_test = kat_label((split_orio+1):end);

            % Xaraktiristika apo bhma 6 
            for i=1:size(TrainData,2)
                TrainData_1(i,:) = TrainData(i).char_arg;
            end
            for i=1:size(TestData,2)
                TestData_1(i,:) = TestData(i).char_arg;
            end
            
            for i=1:size(music_file_rand,2)
                inp_lab(i,:)=[music_file_rand(i).char_arg kat_label(i)];
                arffwrite(strcat('activation',num2str(char_step)),inp_lab);
            end     
            
            
        
        elseif (char_step == 2)
            % Xaraktiristika apo bhma 7 
            for i=1:size(TrainData,2)
                TrainData_1(i,:) = TrainData(i).mffc_arg;
            end
            for i=1:size(TestData,2)
                TestData_1(i,:) = TestData(i).mffc_arg;
            end
            
            for i=1:size(music_file_rand,2)
                inp_lab(i,:)=[music_file_rand(i).mffc_arg kat_label(i)];
                arffwrite(strcat('activation',num2str(char_step)),inp_lab);
            end     
            
            
        else
            % Syndyasmos xarakthristikwn 6 k 7 
            for i=1:size(TrainData,2)
                TrainData_3(i,:) = TrainData(i).char_arg;
                TrainData_2(i,:) = TrainData(i).mffc_arg;
                TrainData_1(i,:) = [TrainData_3(i,:) TrainData_2(i,:)];
            end
            for i=1:size(TestData,2)
                TestData_3(i,:) = TestData(i).char_arg;
                TestData_2(i,:) = TestData(i).mffc_arg;
                TestData_1(i,:) = [TestData_3(i,:) TestData_2(i,:)];
           
            end
             
        end
                for i=1:2
                     temp = TrainData_1(find(kat_label_train(:)==i),:) ;	
                      m_all(:,i) = mean(temp);
                      s_all(:,i) = var(temp);
                end
                apriori = apriori_comp(kat_label_train,[1 2]);
                s_all_biased = s_all ;%+ (1/(4*pi+3));
                h_x = bayes_classifier(TestData_1,m_all,s_all_biased,apriori,[1 2]);

                for j=1:size(TestData_1,1)
                    [~,idx(j)] = max(h_x(:,j));
                end


                p_bayes = find(kat_label_test(:) == (idx(:)) );		% finding correct matches

            accuracy = size(p_bayes,1)/size(TestData_1,1);
            fprintf('Success rate for Bayes : %f%%\n', accuracy*100 );

  
    
    end

