classdef Sound  
    properties
        sample
        frames
        fft_frames
    end
    
    methods
        function obj=Sound(name)
            [obj.sample,a_ ]=audioread(strcat('train/', name));

        end
        function obj = fft_of_frames(obj)
            obj.fft_frames=fft(obj.frames);
        end
        function obj = mel(obj)
            nyquist=16000/2;
            low_h=20; % 20hz is lowest hz we can hear, in mel is near zero so, lets take it as zero
            mel_up= 1127*log(1+nyquist/700);
            
            for i=1:24
                freq_array(i)= 700*( exp(((i-1)*mel_up/23)/1127 )-1); %inverse
            end
            my_filter= 
            %next steps:
            %apply filter to fft
            %H_i(f)=(f-freq_array(i-1))/(freq_array(i)-freq_Array(i-1))
            %freq(i)<f<freq(i+1)
            % (abs(fft_fnames).^2)./lenght(fft_fnames) Energy per result 
            
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
            sample=obj.sample;
            T_over=0.10;
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
            T=0.25;
            sample=obj.sample;
            T_over=0.10;
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
            rate=0.25*16000;
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

