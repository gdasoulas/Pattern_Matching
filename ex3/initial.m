% Initially loading train.txt and test.txt
% and computing means and variances 
function res = initial()
    A = load('train.txt');			% opening training file

    for i=1:10
        temp = A(find(A(:,1)==(i-1)),:) ;	% finding all digits ,which correspond to digit i-1
        temp = temp(:,2:end);
        m_all(:,i) = mean(temp);
        s_all(:,i) = var(temp);
    end

    TestData = load('test.txt');
    class3=zeros(3,2007);
end