function res = k_weigted_conf(A,TestData,k)
%     for i=1:size(TestData)
%        Eu_dist(i,:)= sum(bsxfun(@minus,TestData(i,2:end),A(:,2:end)).^2 ,2);
%     end
    Eu = pdist2(TestData(:,2:end),A(:,2:end),'euclidean');
   [ED_sorted,I_ED_sorted] = sort(Eu,2);
   idx = I_ED_sorted(:,1:k);

   neighbors=reshape(A(idx(:,:),1),size(TestData,1),k);
   Classevalues=zeros(size(TestData,1),10);
       for i=1:size(TestData)
            dist_k = sqrt(sum((TestData(i,2:end)-A(idx(i,k),2:end)).^2));
            dist_1 = sqrt(sum((TestData(i,2:end)-A(idx(i,1),2:end)).^2));
            for j=1:k
                dist_j = sqrt(sum((TestData(i,2:end)-A(idx(i,j),2:end)).^2));
                Classevalues(i,neighbors(i,j)+1) = Classevalues(i,neighbors(i,j)+1)+((dist_k-dist_j)/(dist_k-dist_1));
            end
            Classevalues(i,:)=Classevalues(i,:)./sum(Classevalues(i,:));
       end
 
    res= Classevalues;
end