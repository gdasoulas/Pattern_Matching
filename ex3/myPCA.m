function [V newX D] = myPCA(X) %from stackoverflow as 2016b editions pca didnt work for some reason
    X = bsxfun(@minus, X, mean(X,1));           %# zero-center
    C = (X'*X)./(size(X,1)-1);                  %'# cov(X)

    [V D] = eig(C);
    [D order] = sort(diag(D), 'descend');       %# sort cols high to low
    V = V(:,order);

    newX = X*V(:,1:end);
end