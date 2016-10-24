function res= dependent_prob(test,mu,sig,c)
        for x=1:size(test,1)
            res(x,:,c) = normprob(test(x,2:end),mu,sig,c);
        end
end