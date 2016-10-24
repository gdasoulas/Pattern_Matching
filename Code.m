fprintf('1st question ...\n Loading train.txt and printing 131-th digit\n');

A = load('train.txt');			% opening training file
B = reshape(A(131,2:end),16,16);	
figure;	
imagesc(B);	
		
title ('Image of 131-th Digit');

fprintf('--------------------------------\n 2nd question ...\n');

C = A(find(A(:,1)==0),:) ;		% finding digits , which correspond to 0
C = C(:,2:end);				% eliminating first column , which indicates the number and keeping the other 256 features-pixels

m1 = mean( C(:,154));      		%Pixel 10x10 is 15*9+10 in one line 	

fprintf('Mean of (10,10) pixel of 0s : %f\n' , m1);

fprintf('--------------------------------\n 3rd question ...\n');

s1 =  var( C(:,154));

fprintf('Variance of (10,10) pixel of 0s : %f\n' , s1);

fprintf('--------------------------------\n 4th question ...\n');

m2 = mean(C);
s2 = var(C);
fprintf('Mean of pixel of 0s in vector m2\n');
fprintf('Variance of pixel of 0s in vector s2\n');

fprintf('--------------------------------\n 5th question ...\n');

figure;
imagesc(reshape(m2,16,16)');

title('Image of digit 0 from mean values');

fprintf('6th question ...\n');

figure;
imagesc(reshape(s2,16,16)');

title('Image of digit 0 from var values');


fprintf('--------------------------------\n 7th question ...\n');
fprintf('Printing all 10 digits from mean values\n');

figure;
for i=1:10
	temp = A(find(A(:,1)==(i-1)),:) ;	% finding all digits ,which correspond to digit i-1
	temp = temp(:,2:end);			
	m_all(:,i) = mean(temp);
	s_all(:,i) = var(temp);
	subplot(2,5,i);			
	imagesc(reshape(m_all(:,i)',16,16)');
		
	title(['Digit ',num2str(i-1)])	;
	
end

fprintf('--------------------------------\n 8th question ...\n Loading test.txt and computing Eucleidian Distances for 101th digit \n');

TestData = load('test.txt');

for i=1:10
	EuDist_131(i) = sqrt(sum((TestData(101,2:end) - m_all(:,i)').^2));  % Eucleidian Distance through vectorization
end

[a_,idx] = min(EuDist_131);

fprintf('Digit in place 101 is mapped with digit : %d\n', (idx-1) );

fprintf('--------------------------------\n 9th question ...\n Computing Eucleidian Distances for all digits');

for j=1:size(TestData,1)
	for i=1:10
		EuDist_all(j,i) = sqrt(sum((TestData(j,2:end) - m_all(:,i)').^2)); % Eucleidian Distance through vectorization
    end
	[b_,idx(j)] = min(EuDist_all(j,:)');
    end

p = find(TestData(:,1) == (idx(:)-1) );		% finding correct matches
fprintf('Success rate : %f%%\n',size(p,1)/size(TestData,1)*100 );

%%

%Bhma 10

fprintf('--------------------------------\n 10th question ...\n Computing A priori Probabilities\n');

Classes = [0:9];

for i=1:10
    apriori(i)=size(find(A(:,1)==i-1),1)/size(A,1);
end
%% 

%%Bhma 11


fprintf('--------------------------------\n 11th question ...\n Bayesian Classifier\n');

s_all = s_all + (1/(2*pi)); % biased 

for i=1:10
    Px_depC = dependent_prob(TestData,m_all,s_all,i);
end

%h_x = apriori * 



