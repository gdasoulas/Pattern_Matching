function res = apriori_comp(A,C)
%Computes apriori probabilities 
    for i=C
        apriori(i)=size(find(A(:,1)==i-1),1)/size(A,1);
    end
    res = apriori;
end