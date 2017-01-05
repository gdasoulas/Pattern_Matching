classdef Sound  
    properties
        
        order
        object
        char
        mffcmean
        mffcstd
        mffcmean10
        mffcstd10
        mffc_arg
        char_arg
        
    end
    
    methods

        function obj=Sound(name)
            name=name;
            obj.object=miraudio(name,'Sampling',22050,'Frame',0.05,'s',0.025,'s');
            obj=obj.charact();
            %[obj.sample,~]=audioread(strcat('./PRcourse_Lab3_data/MusicFileSamples/', name));
             %obj.sample=preprocess(obj);
             tmp=miraudio(name,'Sampling',22050,'Frame',0.025,'s',0.01,'s');
             a=mirgetdata(mirmfcc(tmp,'Bands',26,'Delta',1));
             b=mirgetdata(mirmfcc(tmp,'Bands',26,'Delta',2));
             c=mirgetdata(mirmfcc(tmp,'Bands',26));
             a=a';
             b=b';
             c=c';
             obj.mffcmean= [mean(c) mean(a) mean(b)];
             obj.mffcstd =[std(c) std(a) std(b)];
             a = sort(a,1,'descend');
             b = sort(b,1,'descend');       
             c = sort(c,1,'descend');
             per=@(x) x(1:ceil(size(x,1)*0.1),:);
             obj.mffcmean10= [mean(per(c)) mean(per(a)) mean(per(b))];
             obj.mffcstd10 =[std((per(c))) std((per(a))) std(per(b))];
             obj.object=0;

        end
        function obj= charact(obj)
            %roughness
            f=mirfeatures(obj.object,'Stat');
            rou=mirgetdata( mirroughness(obj.object));
            m = median(rou);
            me=  mean (rou>m);
            me2= mean(rou<m);
            obj.char= [f.spectral.roughness.Mean,f.spectral.roughness.Std,me,me2, ...
                f.fluctuation.peak.PeakMagMean,mean(f.fluctuation.tmp.f.Mean),f.tonal.keyclarity.Mean,...
                f.tonal.mode.Mean,mirgetdata(mirmean( mirnovelty(obj.object))),f.tonal.hcdf.Mean];
            
            
        end
        function obj=preprocess(obj)
            Fs=44100;  % arxiki Fs=44.1khz
            [P,Q]=rat(22050/Fs);
            obj.sample = resample(obj.sample,P,Q); % teliki Fs=22.05khz
            obj.sample = (obj.sample(:,1)+obj.sample(:,2))/2; %stereo to mono
        end
    end
end

