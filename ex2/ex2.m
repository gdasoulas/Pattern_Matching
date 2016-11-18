names=dir('train/*.wav');
for i=1:133
    voice(i)=Sound(names(i).name);
end
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
