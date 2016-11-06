function [M,I,V] = longest_seq(A)
    [M,V] = regexp(sprintf('%i',[0 diff(A)==0]),'1+','match');
    [M,I] = max(cellfun('length',M));
    M = M + 1;  % Holds the max length.
    I = V(I) - 1;  % Holds the starting index of first run of length M.
    V = A(I);  % The value of the run.
end
