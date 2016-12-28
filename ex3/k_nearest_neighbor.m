function [p_nn_val,p_nn_act] = k_nearest_neighbor(TrainData,TestData,Eu,k,final_val,final_act)

clear c i j 
train_act = final_act(1:size(TrainData,1));
train_val = final_val(1:size(TrainData,1));
test_act = final_act((size(TrainData,1)+1):end);
test_val = final_val((size(TrainData,1)+1):end);

   [ED_sorted,I_ED_sorted] = sort(Eu,2);
   idx = I_ED_sorted(:,1:k);

   neighbors_val=reshape(train_val(idx(:,:)),size(TestData,1),k);
   neighbors_act=reshape(train_act(idx(:,:)),size(TestData,1),k);
   
   if (k==1)
       final_idx_val = neighbors_val; 
       final_idx_act = neighbors_act;
   else
       for i=1:size(TestData,1)
            if (length(unique(neighbors_val(i,:))) == length(neighbors_val(i,:)))
                final_idx_val(i) = neighbors_val(i,1);
            else
                final_idx_val(i) = mode(neighbors_val(i,:));
            end
            
            if (length(unique(neighbors_act(i,:))) == length(neighbors_act(i,:)))
                final_idx_act(i) = neighbors_act(i,1);
            else
                final_idx_act(i) = mode(neighbors_act(i,:));
            end
       end
        final_idx_val=final_idx_val';
        final_idx_act=final_idx_act';
   end
        assignin('base','indee',idx);

       assignin('base','neigh_val',neighbors_val);
      assignin('base','neigh_act',neighbors_act);
     assignin('base','train_val',train_val);
      assignin('base','test_act',test_act);
      
    p_nn_val = find(final_idx_val(:) == test_val(:));
    p_nn_act = find(final_idx_act(:) == test_act(:));

    
    
    
end