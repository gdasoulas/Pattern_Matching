function [kat_val,kat_act,bad_indices,bad_indices_val,bad_indices_act]=thresholding(final_val,final_act)
    bad_indices=[];
    bad_indices_val=find(final_val(:)==3);
    bad_indices_act=find(final_act(:)==3);
    bad_indices=union(bad_indices_val,bad_indices_act);

    final_val(:,bad_indices_val)=[];
    final_act(:,bad_indices_act)=[];
    kat_val = final_val;
    kat_act = final_act;
    
    for i=1:size(kat_act,2)
        if final_act(i)<3
            kat_act(i)=-1;
        else
            kat_act(i)=1;
        end
    end
    
    for i=1:size(kat_val,2)
        if final_val(i)<3
            kat_val(i)=-1;
        else
            kat_val(i)=1;
        end
    end
end