function res = k_weighted_nearest_neighbor(A,TestData,Eu,k)
%     for i=1:size(TestData)
%        Eu_dist(i,:)= sum(bsxfun(@minus,TestData(i,2:end),A(:,2:end)).^2 ,2);
%     end
   [ED_sorted,I_ED_sorted] = sort(Eu,2);
   idx = I_ED_sorted(:,1:k);

   neighbors=reshape(A(idx(:,:),1),size(TestData,1),k);
   
   if (k==1)
       final_idx = neighbors;
   else
       for i=1:size(TestData)
            Classevalues= zeros(1,10); 
            dist_k = sqrt(sum((TestData(i,2:end)-A(idx(i,k),2:end)).^2));
            dist_1 = sqrt(sum((TestData(i,2:end)-A(idx(i,1),2:end)).^2));
            for j=1:k
                dist_j = sqrt(sum((TestData(i,2:end)-A(idx(i,j),2:end)).^2));
                Classevalues(neighbors(i,j)+1) = Classevalues(neighbors(i,j)+1)+((dist_k-dist_j)/(dist_k-dist_1));
            end
            [~,finidx]=max(Classevalues);
            final_idx(i) = finidx-1;
   end
    assignin('base','neigh',neighbors);
    assignin('base','final',final_idx);

    p_nn = find(TestData(:,1) == final_idx(:));		% finding correct matches
    p_ll = find(TestData(:,1) ~= final_idx(:));		% finding wrong matches
    assignin('base','p_nn_failure',p_ll);

    p_nn_success = size(p_nn,1)/size(TestData,1);
    res = p_nn_success;
end