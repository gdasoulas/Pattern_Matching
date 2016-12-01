classdef Classifier
    %CLASSIFIER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        models
    end
    
    methods
        function obj = Classifier(Itters,states,mixtures,data)
                for i=1:9
                   models(i) = hmm_digit_fix(Itters,states,mixtures,data{i});
                end
                obj.models=models;
        end
        function res = Classify(obj,data)
            max_v=0;
            res=0;
            for i=1:9
                tmp=obj.models(i).logem(data);
                if tmp>max_v
                    max_v=tmp;
                    res=i;
                end
            end
        end
    end
    
end

