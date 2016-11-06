function res = bayes_classifier(TestData,m_all,s_all,apriori,Classes)
% computes the probality P(C|x) , from which we will derive the 
% classification for the computation of P(C|x) , we use the  
% formula : P(C|x) = P(x|C)*P(C)/P(x)

    Px_depC = dependent_prob(TestData,m_all,s_all);

    % computing P(x|C) = P(x1|C)*P(x2|C)*... 

    for c=Classes
        for x=1:size(TestData)
            Px_depC_updated(x,c) = prod(Px_depC(x,:,c));
        end
    end

    % computing Bayes formula 

    for i=1:size(TestData)
        Px(i) = sum(Px_depC_updated(i,:) * apriori');
        for c=Classes
            h_x(c,i) = apriori(c) * Px_depC_updated(i,c)/Px(i);
        end
    end
    res = h_x;
end