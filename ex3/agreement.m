function [agree_val,agree_act,diff_val,diff_act]= agreement(val,act)
    for i=1:2
        for j=i+1:3
            diff_val(i,j,:)=abs(val(i,:)-val(j,:));
            diff_act(i,j,:)=abs(act(i,:)-act(j,:));
            agree_val(i,j)=1 - mean(abs(diff_val(i,j,:))./4);
            agree_val(j,i)=agree_val(i,j);
            agree_act(i,j)=1 - mean(abs(diff_act(i,j,:))./4);
            agree_act(j,i)=agree_act(i,j);
        end
    end
end