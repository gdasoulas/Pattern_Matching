classdef Classifier 
    properties
        models
    end
    
    methods
        function obj = Classifier(Itters,states,mixtures,data)
                for i=1:size(data,2)
                   models(i) = hmm_digit(Itters,states,mixtures,data{1,i});
                end
                
                for i=1:size(data,2)
                    models(i) = hmm_train(models(i));
                end
                
                obj.models=models;
        end
        
        function res = Classify(obj,data)
            max_v=-200000;
            res=0;
            for i=1:size(data,2)
                tmp=obj.models(i).logem(data);
                if tmp>max_v
                    max_v=tmp;
                    res=i;
                end
            end
        end
    end
    
end

