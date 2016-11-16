classdef Sound  
    properties
        sample
        frames
    end
    
    methods
        function obj=Sound(name)
            [obj.sample,a_ ]=audioread(strcat('train/', name));

        end
        function res= preface1(n)
            res=kroneckerDelta(n,0) - (9409*kroneckerDelta(n-1,0)/1000)
        end
        function obj =preface(obj)
              second=[1,-0.9409];
              obj.sample=conv(obj.sample,second); %maybe?
        end
        function obj =toframes1(obj)
            f=16000; %16khz
            T=0.25;
            sample=obj.sample
            T_over=0.10;
            rate= T/f;
            rate2=T_over/f;
            start=1;
            i=1;
            while start<size(sample,1)
                frames(i,:)=sample(start:rate);
                start=start+rate-rate2;
                i=i+1;
                if start+rate>size(sample,1)
                    if start-size(sample,1)>0
                        frames(i,:)=zeros(rate);
                        frames(i,0:(rate-size(sample,1)))=sample(start:end);
                        i=i+1;
                    end
                    break
                end
            end
            i=i-1;
            for j=1:i
                for k=1:size(frames,2)
                    frames(j,k)=frames(j,k)* (0.54-0.46*cos((2*pi*(k*(j-1)*i))/(i-1)));
                end
            end
            obj.frames=frames;      
        end
        function obj=toframes2(obj) %ena apo ta 2 einai to sosto
            f=16000; %16khz
            T=0.25;
            sample=obj.sample
            T_over=0.10;
            rate= T/f;
            rate2=T_over/f;
            i=1;
            start=1;
            while start<size(sample,1)
                start=start+rate-rate2;
                i=i+1;
                if start+rate>size(sample,1)
                    if start-size(sample,1)>0
                        i=i+1;
                    end
                    break
                end
            end
            i=i-1;
            frames=zeros(i,size(sample,1));
            for j=1:i
                for k=1:size(frames,2)
                    frames(j,k)=samples(j,k)* (0.54-0.46*cos((2*pi*(k*(j-1)*i))/(i-1)));
                end
            end
            obj.frames=frames;
        end
    end
end

