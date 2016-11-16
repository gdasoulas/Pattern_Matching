names=dir('train/*.wav');
for i=1:133
    voice(i)=Sound(names(i).name);
    voice(i).preface;
end
