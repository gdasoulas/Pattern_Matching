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
class3=zeros(3,2007); 
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
    class3(1,j)=idx(j)-1;
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
lessTrain=A(1:1000,:);
lessTest=TestData(1:100,:);
for i=1:size(lessTest)
    [~,idx]= min(sum(bsxfun(@minus,lessTest(i,2:end),lessTrain(:,2:end)).^2 ,2));
    if A(idx,1) == TestData(i,1)
        counter=counter+1;
    end
end

fprintf('Success rate for 1nn with 100 test cases and 1000 train cases: %f%%\n',counter/size(lessTest,1)*100 );


%% Bhma 14a
%Nearest neighbor 

counter = 0;
for i=1:size(TestData)
    [~,idx]= min(sum(bsxfun(@minus,TestData(i,2:end),A(:,2:end)).^2 ,2));
    class3(2,i)=A(idx,1); %take NNR1 res
    if A(idx,1) == TestData(i,1)
        counter=counter+1;
    end
end

fprintf('Success rate for 1nn : %f%%\n',counter/size(TestData,1)*100 );


%% Bhma 14b

for i=1:size(TestData)
    Eu_dist(i,:)= sum(bsxfun(@minus,TestData(i,2    :end),A(:,2:end)).^2 ,2);
end

%%
[ED_sorted,I_ED_sorted] = sort(Eu_dist,2);

k=3;

idx = I_ED_sorted(:,1:k);

neighbors=reshape(A(idx(:,:),1),size(TestData,1),k);
neighbors=sort(neighbors,2);

for i=1:2007
    final_idx(i)=test1(neighbors(i,:),k);
end

p_nn = find(TestData(:,1) == final_idx(:));		% finding correct matches

p_ll = find(TestData(:,1) ~= final_idx(:) );		% finding correct matches


% p_nn = find(TestData(:,1) == A(idx(:,k),1) );		% finding correct matches

fprintf('Success rate for k=%d -nn : %f%%\n',k,size(p_nn,1)/size(TestData,1)*100 );
%% Bhma 15
filter_categories_2 =@(x) (@(y)(x==y) + (-1)*(x~=y)); %lambda just because I have a biggg DICK
opt=statset('MaxIter',500000); %it covergesssss
opt2=statset('MaxIter',100000); 
for i=1:10 %SLOW BUT PEOS M
    SvnStruct_linear(i) = svmtrain(A(:,2:end),arrayfun(filter_categories_2(i-1),A(:,1)),'options',opt);
    SvnStruct_poly(i) = svmtrain(A(:,2:end),arrayfun(filter_categories_2(i-1),A(:,1)),'kernel_function','polynomial','polyorder',3,'options',opt2); %test order
end
%%
counter=0;
counter2=0;
for i=1:10
    G_l=svmclassify(SvnStruct_linear(i),TestData(:,2:end));
    G_p=svmclassify(SvnStruct_poly(i),TestData(:,2:end));
    for j=1:size(G_l)
        if(G_l(j)==1 && (i-1)==TestData(j,1))
            counter=counter+1;
        end
        if(G_p(j)==1 && (i-1)==TestData(j,1))
            counter2=counter2+1;
        end
        if(G_p(j)==1)
            class3(3,j)=i-1;
        end
    end
end
%maybe we need to check if it is clasified as 2 categories?
fprintf('Success rate for 1inear : %f%%\n',counter/size(TestData,1)*100 );
fprintf('Success rate for poly : %f%%\n',counter2/size(TestData,1)*100 );

%% bima 16 a
% We are going to use Svn poly and bayers and NNR-1
counter=0;
Most_Freq=mode(class3);
for i=1:2007
    if(TestData(i,1)==Most_Freq(i))
        counter=counter+1;
    end
end
fprintf('Success rate for 3 class : %f%%\n',counter/size(TestData,1)*100 );
%% bima 17b
    indi_i=find(A(:,1)==0);
    percent_i= ceil(size(indi_i)*0.8);
    A_80=[A(indi_i(1:percent_i),:)];
    A_20=[A(indi_i(percent_i+1:end),:)];
for i=2:10
    indi_i=find(A(:,1)==i-1);
    percent_i= ceil(size(indi_i)*0.8);
    A_80=[A_80;A(indi_i(1:percent_i),:)];
    A_20=[A_20;A(indi_i(percent_i+1:end),:)];
end
%Rest = ;
