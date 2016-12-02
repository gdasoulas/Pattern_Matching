classdef hmm_digit_fix
    %HMM_DIGIT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Itter
        Num_States
        Mt
        Mffcs
        prior
        initial_A
        initial_mu
        initial_sigma
        LL
        prior2
        transmat
        mu2 
        Sigma
        mixmat2
    end
    
    methods
        function obj = hmm_digit_fix(itters,states,MixNums,Mffcs)
            obj.Itter=itters;
            obj.Num_States=states;
            obj.Mt=MixNums;
            obj.Mffcs=Mffcs;
            [obj.initial_A,obj.initial_mu,obj.initial_sigma,obj.prior] = hmm_init(states,MixNums,Mffcs);
        end
        
        function obj= hmm_train_fix(obj)
            %I ekfonisi leei oti prepei na einai 12*Nm i paparies autes ,
            %apo oti epiasa
            mixmat = mk_stochastic(rand(obj.Num_States,obj.Mt));
            [obj.LL, obj.prior2, obj.transmat, obj.mu2, obj.Sigma, obj.mixmat2] = ...
                mhmm_em(obj.Mffcs, obj.prior, obj.initial_A, obj.initial_mu, obj.initial_sigma, mixmat, 'max_iter',obj.Itter);
        end
        function log_prob = logem_fix(obj,data)
            [log_prob,errors] = ...
                mhmm_logprob(data, obj.prior2, obj.transmat, obj.mu2, obj.Sigma, obj.mixmat2);
        end
    end
    
end

