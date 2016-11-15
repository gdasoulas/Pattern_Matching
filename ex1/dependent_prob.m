function res= dependent_prob(test,mu,sig)
        for i=1:10
            for x=1:size(test,1)
                res(x,:,i) = normprob(test(x,2:end),mu,sig,i);
        
            end
        end
end