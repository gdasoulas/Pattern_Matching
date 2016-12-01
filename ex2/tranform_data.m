function [ ret] = tranform_data( data )
%TRANFORM_DATA Summary of this function goes here
%   Detailed explanation goes here
    for i=1:size(data,1)
        ret{i}=data{i}.mffc_fframes;
    end

end

