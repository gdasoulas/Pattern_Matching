function res= dependent_prob(test,mu,sig)
        for i=1:2
            for x=1:size(test,1)
                res(x,:,i) = normprob(test(x,:),mu,sig,i);
        
            end
        end
end