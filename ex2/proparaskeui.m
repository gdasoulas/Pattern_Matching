%% Bhma 5 
% Plotting energy 

figure;
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


%% Bhma 8 

% Printing reconstructed

figure;
Frames=[1:24];
bar(Frames,[voice(1).fft_frames(1,7).Energy voice(1).fft_frames(1,10).Energy]);

title('Reconstructed energy diagram for sample 1 and frames 7,10');
legend('Frame 7','Frame 10');


% Printing spectrum 

figure;

spec1 = abs(voice(1).fft_frames(1,7).Framed(:)).^2./400;
spec2 = abs(voice(1).fft_frames(1,10).Framed(:)).^2./400;

plot(linspace(0,16000,400),spec1,linspace(0,16000,400),spec2);

title('Power Spectrum for sample 1 and frames 7,10');
legend('Frame 7','Frame 10');


%toFrame1 is correct...


%% Bhma 9 

a=1;
b=1;
for j=1:133
    for i=1:size(voice(1,j).fft_frames,2)
        cc_k1_n1(j,i) = voice(1,j).fft_frames(1,i).DCT_energy_init(n1,1);
        cc_k1_n2(j,i) = voice(1,j).fft_frames(1,i).DCT_energy_init(n2,1);
%         a=a+1;
    end 
    
end

symbols = ['o' '+' '*' '.' 'x' 's' 'd' '^' '>'];

for i=1:133
    cmean_n1(i) = mean(cc_k1_n1(i,:));
    cmean_n2(i) = mean(cc_k1_n2(i,:));
end


%%
figure;
% indices=[];
% for j=1:133
%     idx=find(names(j).name(:)=='.');
%     if names(j).name(idx-1)=='9'
%         indices = [indices j+1];
%     end
% end

symbols = ['o' '+' '*' '.' 'x' 's' 'd' '^' '>'];
for j=1:14
    scatter(cmean_n1(1:14),cmean_n2(1:14),symbols(1));
end

hold on;
for j=15:29
    scatter(cmean_n1(15:29),cmean_n2(15:29),symbols(2));
end

hold on;
for j=30:44
    scatter(cmean_n1(30:44),cmean_n2(30:44),symbols(3));
end
hold on;
for j=45:59
    scatter(cmean_n1(45:59),cmean_n2(45:59),symbols(4));
end
hold on;
for j=60:74
    scatter(cmean_n1(60:74),cmean_n2(60:74),symbols(5));
end
hold on;
for j=75:89
    scatter(cmean_n1(75:89),cmean_n2(75:89),symbols(6));
end
hold on;
for j=90:103
    scatter(cmean_n1(90:103),cmean_n2(90:103),symbols(7));
end
hold on;
for j=104:118
    scatter(cmean_n1(104:118),cmean_n2(104:118),symbols(8));
end
hold on;
for j=119:133
    scatter(cmean_n1(119:133),cmean_n2(119:133),symbols(9));
end




%%

scatter(cmean_n1,cmean_n2);
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
