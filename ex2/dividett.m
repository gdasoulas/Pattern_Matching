function [ train,test ] = dividett(data)
%DIVIDETT Summary of this function goes here
%   Detailed explanation goes here
    d7 = @(x) floor((size(x,2)*0.7));
    for i=1:9
        tmp=data{i};
        for j=1:d7(tmp)
        train{i}{j} = tmp{j};
        end
        for j=d7(tmp)+1:size(tmp,2)
        test{i}{(j-d7(tmp))} =tmp{j};
        end
    end
end

