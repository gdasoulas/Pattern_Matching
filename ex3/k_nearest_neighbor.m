function [final_idx_val,final_idx_act] = k_nearest_neighbor(TrainData,TestData,Eu,k,kat_val,kat_act)

train_act = kat_act(1:size(TrainData,1));
train_val = kat_val(1:size(TrainData,1));
test_act = kat_act((size(TrainData,1)+1):end);
test_val = kat_val((size(TrainData,1)+1):end);

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
end