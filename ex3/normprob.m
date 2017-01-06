function res = normprob(X,mu,sig,C)
    res=normpdf(X(:),mu(:,C),sqrt(sig(:,C)));
end
