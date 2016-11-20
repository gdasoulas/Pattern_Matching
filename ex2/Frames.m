classdef Frames
    %FRAMES Summary of this class goes here
    %   Detailed explanation goes here
    properties
        Framed
        Filtered
        Energy
        Log_energy;
        DCT_energy;
        Reconstruct;
    end
    
    methods
        function obj=Frames(fourier)
            obj.Framed=fourier;
            obj=obj.mel;
            obj=obj.Matlab_dct;
            obj.DCT_energy(15:end)=0;
            obj=obj.IMatlab_dct;
            obj.Reconstruct=idct(obj.DCT_energy); %reverse
        end
        function obj=Matlab_dct(obj)
            obj.DCT_energy(2:end)=obj.DCT_energy(2:end).*sqrt(2/size(obj.DCT_energy,1));
            obj.DCT_energy(1)=obj.DCT_energy(1).*sqrt(1/size(obj.DCT_energy,1));
        end
        function obj=IMatlab_dct(obj)
            obj.DCT_energy(2:end)=obj.DCT_energy(2:end)./sqrt(2/size(obj.DCT_energy,1));
            obj.DCT_energy(1)=obj.DCT_energy(1)./sqrt(1/size(obj.DCT_energy,1));
        end
         function obj = mel(obj)
            nyquist=16000/2;
            low_h=100; % 20hz is lowest hz we can hear, in mel is near zero so, lets take it as zero
            low_h=1127*log(1+low_h/700);
            mel_up= 1127*log(1+nyquist/700);
            mels=linspace(low_h,mel_up,24);
            fft_frames=obj.Framed;
            for i=1:24
               freq_array(i)= 700*( exp(mels(i)/1127 )-1); %inverse
            end
            %next steps:
            %apply filter to fft
            %H_i(f)=(f-freq_array(i-1))/(freq_array(i)-freq_Array(i-1))
            %freq(i)<f<freq(i+1)
            % (abs(fft_fnames).^2)./lenght(fft_fnames) Energy per result 
            %let's try something from this point and down is a test...
            freq_array=floor(freq_array.* (size(fft_frames,2))/(16000));
            
            H=zeros(24,size(fft_frames,2));
            for j=1:freq_array(1)
                    H(1,j)=j/(freq_array(1));
            end
            for j=freq_array(1):freq_array(2)
                   H(1,j)=(freq_array(2)-j)/(freq_array(2)-freq_array(1));
            end
            for j=freq_array(23):freq_array(24)
                    H(23,j)=(j-freq_array(23))/(freq_array(24)-freq_array(23));
            end
            for i=2:23
                for j=freq_array(i-1):freq_array(i)
                    H(i,j)=(j-freq_array(i-1))/(freq_array(i)-freq_array(i-1));
                end
                 for j=freq_array(i):freq_array(i+1)
                    H(i,j)=(freq_array(i+1)-j)/(freq_array(i+1)-freq_array(i));
                end
            end
            %filters are ready
            filtered=zeros(24,size(obj.Framed,2));
            for i=1:24
                filtered(i,:)=obj.Framed(1,:) .* H(i,:);
            end
            obj.Filtered=filtered;
            %energy=zeroes(24,1);
            energy=sum(abs(filtered).^2)/size(filtered,2);
            obj.Energy=energy; %maybe lathos? alios me for
            obj.Log_energy=log10(energy);
            obj.DCT_energy=dct(obj.Log_energy);
        end
    end
    
end

