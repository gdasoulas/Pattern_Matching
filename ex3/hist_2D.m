function hist_2D(val,act)
    for i=1:size(val,1) 
        X=[val(i,:)' act(i,:)']; 

        n = hist3(X);
%         n = zeros(5,5);
%         for j=1:size(X,1)
%             n(X(j,1),X(j,2))=n(X(j,1),X(j,2))+1;
%         end
        cooccurence{i}=n;
        xb = linspace(min(X(:,1)),max(X(:,1)),size(n,1));
        yb = linspace(min(X(:,2)),max(X(:,2)),size(n,1));
        figure;
        h = pcolor(xb,yb,n);
        xlabel('Valence');
        ylabel('Activation');
        title('2D Histogram of Labels for Final Annotator ');
        saveas(gcf,strcat('hist_2D_final.png'));
    end
end