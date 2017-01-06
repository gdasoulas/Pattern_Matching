classdef Sound  
    properties
        sample
    end
    
    methods
        function obj=Sound(name)
            obj.sample = miraudio(name,'Frame',0.05,'s',0.025,'s');
        end
                

        end
        
end

