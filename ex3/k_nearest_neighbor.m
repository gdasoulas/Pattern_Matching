function [p_nn_val,p_nn_act] = k_nearest_neighbor(A,TestData,Eu,k,final_val,final_act)

train_act = final_act(1:250);
train_val = final_val(1:250);
test_act = final_act(251:end);
test_val = final_val(251:end);


%     for i=1:size(TestData)
%        Eu_dist(i,:)= sum(bsxfun(@minus,TestData(i,2:end),A(:,2:end)).^2 ,2);
%     end
   [ED_sorted,I_ED_sorted] = sort(Eu,2);
   idx = I_ED_sorted(:,1:k);

   neighbors_val=reshape(train_val(idx(:,:)),size(TestData,1),k);
   neighbors_act=reshape(train_act(idx(:,:)),size(TestData,1),k);
   
   %neighbors=sort(neighbors,2);
   
   if (k==1)
       final_idx_val = neighbors_val; 
       final_idx_act = neighbors_act;
%    else
%        for i=1:size(TestData)
%             if (length(unique(neighbors(i,:))) == length(neighbors(i,:)))
%                 final_idx(i) = neighbors(i,1);
%             else
%                 final_idx(i) = mode(neighbors(i,:));
%             end
%        end
%         final_idx=final_idx';
   end
%     assignin('base','neigh',neighbors);
%     var_name = strcat('Pred_',num2str(k),'_nn');
%     assignin('base',var_name,final_idx);
% 
%     p_nn = find(TestData(:,1) == final_idx(:));		% finding correct matches
%     p_ll = find(TestData(:,1) ~= final_idx(:));		% finding wrong matches
%     assignin('base','p_nn_failure',p_ll);
% 
%     p_nn_success = size(p_nn,1)/size(TestData,1);
%     res = p_nn_success;



    p_nn_val = find(final_idx_val(:) == test_val(:));
    p_nn_act = find(final_idx_act(:) == test_act(:));

end