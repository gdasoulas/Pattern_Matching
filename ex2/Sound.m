classdef Sound  
    properties
        sample
        frames
        fft_frames
    end
    
    methods
        function obj=Sound(name)
            [obj.sample,a_ ]=audioread(strcat('train/', name));
            % let's automize it;
            obj=obj.preface;
            obj=obj.toframes1;
            size(obj.frames);
            obj=obj.toframes3;
            size(obj.frames);
            obj.frames=obj.frames';
            obj=obj.fft_of_frames;

        end
        function obj = fft_of_frames(obj)
            for i=1:size(obj.frames,1)
             fft_frames(i)=Frames(fft(obj.frames(i,:)));
            end
            obj.fft_frames=fft_frames;
        end
        function [mean1,mean2]=getDCTMean(obj,k1,k2)
            mean1=0;
            mean2=0;
            for i=1:size(obj.fft_frames,1)
                mean1=mean1+obj.fft_frames(i).DCT_energy(k1);
                mean2=mean2+obj.fft_frames(i).DCT_energy(k2);

            end
            mean1=mean1/size(obj.fft_frames,1);
            mean2=mean2/size(obj.fft_frames,1);
        end
        function res= preface1(n)
            res=kroneckerDelta(n,0) - (9409*kroneckerDelta(n-1,0)/1000)
        end
        function obj =preface(obj)
              %second=[1,-0.9409];
              second=[1,-0.97]; % I like it better
              obj.sample=conv(obj.sample,second); 
        end
        function obj= toframes3(obj)
            f=16000; %16khz
            T=0.025;
            sample=obj.sample;
            T_over=0.010;
            rate= floor(T*f);
            rate2=floor(T_over*f);
            frames=buffer(sample,rate,rate2);
            w=hamming(rate);
            frames=frames';
%             size(frames)
            size(w');
           % for i=1:size(frames,1)
           %     frames(i,:)=frames(i,:).*(w');
           % end
            for j=1:size(frames,1)
                for k=1:size(frames,2)
                    frames(j,k)=frames(j,k)* (0.54-0.46*cos((2*pi*(k*(j-1)*rate))/(rate-1)));
                end
            end
            obj.frames=frames';
        end
        function obj =toframes1(obj)
            f=16000; %16khz
            T=0.025;
            sample=obj.sample;
            T_over=0.010;
            rate= floor(T*f);
            rate2=floor(T_over*f);
            frames=zeros(number_frames(obj),rate);
            i=1;
            start=1;
            while start<size(sample,1)
                k=start+rate-1;
                frames(i,1:rate)=sample(start:k);
                start=start+rate-rate2;
                i=i+1;
                if start+rate>size(sample,1)
                    if start-size(sample,1)>0
                        frames(i,1:(rate-size(sample,1)))=sample(start:end);
                        i=i+1;
                    end
                    break
                end
            end
            i=i-1;
            for j=1:i
                for k=1:size(frames,2)
                    frames(j,k)=frames(j,k)* (0.54-0.46*cos((2*pi*(k*(j-1)*rate))/(rate-1)));
                end
            end
            obj.frames=frames;      
        end
        function i=number_frames(obj)
            f=16000; %16khz
            T=0.025;
            sample=obj.sample;
            T_over=0.010;
            rate= T*f;
            rate2=T_over*f;
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
        end
        function obj=toframes2(obj) %ena apo ta 2 einai to sosto
            i=number_frames(obj);
            rate=0.025*16000;
            frames=zeros(i,size(sample,1));
            for j=1:i
                for k=1:size(frames,2)
                    frames(j,k)=samples(j,k)* (0.54-0.46*cos((2*pi*(k*(j-1)*rate))/(rate-1)));
                end
            end
            obj.frames=frames;
        end
    end
end

