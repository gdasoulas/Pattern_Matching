function [kat_val,kat_act,bad_indices]=thresholding(final_val,final_act)
    bad_indices=[];
    bad_indices=union(find(final_val(:)==3),find(final_act(:)==3));

    final_val(:,bad_indices)=[];
    final_act(:,bad_indices)=[];
    kat_val = final_val;
    kat_act = final_act;
    
    for i=1:size(kat_act,2)
        if final_act(i)<3
            kat_act(i)=-1;
        else
            kat_act(i)=1;
        end
        if final_val(i)<3
            kat_val(i)=-1;
        else
            kat_val(i)=1;
        end
    end
end