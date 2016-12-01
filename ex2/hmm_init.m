function [transmat,mu0,Sigma0,prior] = hmm_init(Q,M,data)
% Initialization of em
% Q = #states

    cov_type='diag';

    % Creation of Transition Matrix
    A=zeros(Q,Q);
    for i=1:Q
        A(i,i)=rand(1);
        A(i,i+1)=rand(1);
    end
    transmat=mk_stochastic(A(:,1:Q)); 
    
    
    % Mixture of Gaussians
    
    [mu0, Sigma0] = mixgauss_init(Q*M, data, cov_type);

    % Prior states
    
    prior = eye(Q,1);
    
end