classdef Sound  
    properties
        sample
    end
    
    methods
        function obj=Sound(name)
            [obj.sample,~]=audioread(strcat('./PRcourse_Lab3_data/MusicFileSamples/', name));
            obj.sample=preprocess(obj);
        end
        
        function obj=preprocess(obj)
            Fs=44100;  % arxiki Fs=44.1khz
            [P,Q]=rat(22050/Fs);
            obj.sample = resample(obj.sample,P,Q); % teliki Fs=22.05khz
            obj.sample = (obj.sample(:,1)+obj.sample(:,2))/2; %stereo to mono
        end
    end
end

