function res = apriori_comp(A,C)
%Computes apriori probabilities 
    for i=C
        apriori(i)=size(find(A(:)==i),1)/size(A,1);
    end
    res = apriori;
end