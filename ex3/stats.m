function [val,act,cooccurence,labels]=stats()
    dir_emotion = './PRcourse_Lab3_data/EmotionLabellingData/';
    labels(1) = load(strcat(dir_emotion,'Labeler1.mat'));
    labels(2) = load(strcat(dir_emotion,'Labeler2.mat'));
    labels(3) = load(strcat(dir_emotion,'Labeler3.mat'));

    for i=1:3
        for j=1:size(labels(i).labelList,1)
            val(i,j)=labels(i).labelList(j).valence;
            act(i,j)=labels(i).labelList(j).activation;
        end
    end

    for i=1:3 
        X=[val(i,:)' act(i,:)']; 
        n = zeros(5,5);
        for j=1:size(X,1)
            n(X(j,1),X(j,2))=n(X(j,1),X(j,2))+1;
        end
        cooccurence{i}=n;
        xb = linspace(min(X(:,1)),max(X(:,1)),size(n,1));
        yb = linspace(min(X(:,2)),max(X(:,2)),size(n,1));
        figure;
        h = pcolor(xb,yb,n);
        xlabel('Valence');
        ylabel('Activation');
        title(strcat('2D Histogram of Labels for Annotator No ',num2str(i)));
        saveas(gcf,strcat('hist_2D_',num2str(i),'.png'));
    end
end