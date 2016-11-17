names=dir('train/*.wav');
for i=1:133
    voice(i)=Sound(names(i).name);
end
%toFrame1 is correct...
%remains: plots and k1,k2 .