names=dir('train/*.wav');
for i=1:133
    voice(i)=Sound(names(i).name);
end

%% Bhma 5 
% Plotting energy 

Frames=[1:24];
bar(Frames,[voice(1).fft_frames(1,7).Energy voice(1).fft_frames(1,10).Energy]);

title('Energy diagram for sample 1 and frames 7,10');
legend('Frame 7','Frame 10');

%% Bhma 7
% Plotting cepstrum coefficients C_i(n)

% For our implementation we used :
% k1 =8 , k2=7 , n1=1 , n2=5

k1=8;
k2=7;
n1=1;
n2=5;

a=1;
%k1 -> maps to first 14 samples
for j=1:14
    for i=1:size(voice(1,j).fft_frames,2)
        coeff_k1_n1(a) = voice(1,j).fft_frames(1,i).DCT_energy_init(n1,1);
        coeff_k1_n2(a) = voice(1,j).fft_frames(1,i).DCT_energy_init(n2,1);
        a=a+1;
    end   
end

figure;
hist(coeff_k1_n1);
title('Coefficients for k1=8 and n1=1');
figure;
hist(coeff_k1_n2);
title('Coefficients for k1=8 and n1=5');

%k2 -> maps to 75-89 samples
for j=75:89
    for i=1:size(voice(1,j).fft_frames,2)
        coeff_k2_n1(a) = voice(1,j).fft_frames(1,i).DCT_energy_init(n1,1);
        coeff_k2_n2(a) = voice(1,j).fft_frames(1,i).DCT_energy_init(n2,1);
        a=a+1;
    end   
end

figure;
hist(coeff_k2_n1);
title('Coefficients for k2=7 and n1=1');
figure;
hist(coeff_k2_n2);
title('Coefficients for k2=7 and n2=5');
clear coeff

%toFrame1 is correct...



%remains: plots and k1,k2 .
%k1 =8 k2=7 , n1=1 , n2=5
%1-14 ->8
%15-29 ->5
%30-44 ->6
%45-59 -> 9
%60-74 -> 1
%75-89 ->7
%90-103 ->6
%104-118 -> 3
%119-133 -> 2
