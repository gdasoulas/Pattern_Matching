classdef hmm_digit
    %HMM_DIGIT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Itter
        Num_States
        Mt
        Mffcs
        prior
        initial_A
        LL
        prior2
        transmat
        mu2 
        Sigma
        mixmat2
    end
    
    methods
        function obj = hmm_digit(itters,states,MixNums,Mffcs)
            obj.Itter=itters;
            obj.Num_States=states;
            obj.Mt=MixNums;
            obj.Mffcs=Mffcs;
            obj.prior = eye(states,states);
            A=rand(states,states);
            for i=1:states
                for j=1:i-1
                    A(i,j)=0;
                end
            end
            for i=1:states
                for j=i+1:states
                    A(i,j)=0;
                end
            end
            obj.initial_A=mk_stochastic(A);
        end
        function obj= train(obj)
            %I ekfonisi leei oti prepei na einai 12*Nm i paparies autes ,
            %apo oti epiasa
            [mu, sigma,w] = mixgauss_init(12*obj.Mt,obj.Mffcs,'diag','rnd');
            mixmat = mk_stochastic(rand(12,obj.Mt));
            [obj.LL, obj.prior2, obj.transmat, obj.mu2, obj.Sigma, obj.mixmat2] = ...
                mhmm_em(obj.Mffcs, obj.prior, obj.initial_A, mu, sigma, mixmat, 'max_iter',obj.Itter);
        end
    end
    
end

