function res = k_nearest_neighbor(A,TestData,Eu,k)
%     for i=1:size(TestData)
%        Eu_dist(i,:)= sum(bsxfun(@minus,TestData(i,2:end),A(:,2:end)).^2 ,2);
%     end
   [ED_sorted,I_ED_sorted] = sort(Eu,2);
   idx = I_ED_sorted(:,1:k);

   neighbors=reshape(A(idx(:,:),1),size(TestData,1),k);
   %neighbors=sort(neighbors,2);
   
   if (k==1)
       final_idx = neighbors;
   else
       for i=1:size(TestData)
    %          [~ ,~,fin] = longest_seq(neighbors(i,:));
    %          if (size(fin) == 0)
    %              final_idx(i) = neighbors(i,1);
    %          else
    %             final_idx(i)=fin;
    %          end
            if (length(unique(neighbors(i,:))) == length(neighbors(i,:)))
                final_idx(i) = neighbors(i,1);
            else
                final_idx(i) = mode(neighbors(i,:));
            end
       end
        final_idx=final_idx';
   end
    assignin('base','neigh',neighbors);
    var_name = strcat('Pred_',num2str(k),'_nn');
    assignin('base',var_name,final_idx);

    p_nn = find(TestData(:,1) == final_idx(:));		% finding correct matches
    p_ll = find(TestData(:,1) ~= final_idx(:));		% finding wrong matches
    assignin('base','p_nn_failure',p_ll);

    p_nn_success = size(p_nn,1)/size(TestData,1);
    res = p_nn_success;
end