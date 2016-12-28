function [kat_val,kat_act,bad_indices]=thresholding(final_val,final_act)
    bad_indices=union(find(final_val(:)==3),find(final_act(:)==3));

    kat_val = final_val;
    kat_act = final_act;
    kat_val(:,bad_indices)=[];
    kat_act(:,bad_indices)=[];

    for i=1:size(kat_act,2)
        if kat_act(i)<3
            kat_act(i)=-1;
        else
            kat_act(i)=1;
        end
        if kat_val(i)<3
            kat_val(i)=-1;
        else
            kat_val(i)=1;
        end
    end
end