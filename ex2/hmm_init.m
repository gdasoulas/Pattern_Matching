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
    % we append all samples of the same category 
    
    data_tmp=[];
    for i=1:size(data,2)
        data_tmp = [data_tmp data{i}];
    end
    
    mu0 = [];
    Sigma0 = [];
%     for i=1:Q
%         [mu_tmp, Sigma_tmp] = mixgauss_init(M, data_tmp, cov_type);
%         mu0(:,i,:) = mu_tmp;
%         Sigma0(:,:,i,:) = Sigma_tmp;
%     end
    
    [mu_tmp, Sigma_tmp] = mixgauss_init(M, data_tmp, cov_type);    
    mu_tmp = repmat(mu_tmp,[1 1 6]);
    mu0 = permute(mu_tmp,[1 3 2]);
    Sigma_tmp = repmat(Sigma_tmp,[1 1 1 6]);
    Sigma0 = permute(Sigma_tmp,[1 2 4 3]);
    
    
    % Prior states
    
    prior = eye(Q,1);
    
end