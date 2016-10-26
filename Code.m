%% First Lab - After first 9 questions ...

fprintf('First Questions: Loading train.txt ,test.txt and computing m_all,s_all \n');

A = load('train.txt');			% opening training file

for i=1:10
	temp = A(find(A(:,1)==(i-1)),:) ;	% finding all digits ,which correspond to digit i-1
	temp = temp(:,2:end);			
	m_all(:,i) = mean(temp);
	s_all(:,i) = var(temp);	
end

TestData = load('test.txt');

%% Bhma 10

fprintf('--------------------------------\n 10th question ...\n Computing A priori Probabilities\n');

Classes = [0:9];

for i=1:10
    apriori(i)=size(find(A(:,1)==i-1),1)/size(A,1);
end
%% Bhma 11


fprintf('--------------------------------\n 11th question ...\n Bayesian Classifier\n');

%s_all_biased = s_all + (1/2*pi); % biased with 1/2π
s_all_biased = s_all + (1/(4*pi+3)); % biased with 1/(4π+3) for better estimation 

Px_depC = dependent_prob(TestData,m_all,s_all_biased);


% computing P(x|C) = P(x1|C)*P(x2|C)*... 

for c=1:10
    for x=1:size(TestData)
%         Px_depC_updated(x,c) = prod(Px_depC(x,:,c));
%     end
        Px_depC_updated(x,c) = prod(Px_depC(x,:,c));
    end
end

% computing Bayes formula 

for i=1:size(TestData)
    Px(i) = sum(Px_depC_updated(i,:) * apriori');
    for c=1:size(Classes,2)
        h_x(c,i) = apriori(c) * Px_depC_updated(i,c)/Px(i);
    end
end

% computing maximum h_x for classification 

for j=1:size(TestData,1)
	[~,idx(j)] = max(h_x(:,j));
    end

p_bayes = find(TestData(:,1) == (idx(:)-1) );		% finding correct matches
p_fail = find(TestData(:,1) ~= (idx(:)-1) )
fprintf('Success rate for Bayes : %f%%\n',size(p_bayes,1)/size(TestData,1)*100 );

%% Bhma 12

s_all_one=ones(256,10);

fprintf('--------------------------------\n 12th question ...\n Bayesian Classifier for Var=1\n');

Px_depC = dependent_prob(TestData,m_all,s_all_one);


% computing P(x|C) = P(x1|C)*P(x2|C)*... 

for c=1:10
    for x=1:size(TestData)
%         Px_depC_updated(x,c) = prod(Px_depC(x,:,c));
%     end
        Px_depC_updated(x,c) = prod(Px_depC(x,:,c));
    end
end

% computing Bayes formula 

for i=1:size(TestData)
    Px(i) = sum(Px_depC_updated(i,:) * apriori');
    for c=1:size(Classes,2)
        h_x(c,i) = apriori(c) * Px_depC_updated(i,c)/Px(i);
    end
end

% computing maximum h_x for classification 

for j=1:size(TestData,1)
	[~,idx(j)] = max(h_x(:,j));
    end

p_bayes = find(TestData(:,1) == (idx(:)-1) );		% finding correct matches
fprintf('Success rate for Bayes with Var=one : %f%%\n',size(p_bayes,1)/size(TestData,1)*100 );

%% Bhma 13

%Nearest neighbor 

counter = 0;
for i=1:size(TestData)
    [~,idx]= min(sum(bsxfun(@minus,TestData(i,2:end),A(:,2:end)).^2 ,2));
    if A(idx,1) == TestData(i,1)
        counter=counter+1;
    end
end

fprintf('Success rate for 1nn : %f%%\n',counter/size(TestData,1)*100 );

