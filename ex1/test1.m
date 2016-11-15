function res= test1(tst,k)

max_counter=1;
max_id=1;
counter=1;

for i=1:(k-1) 
     if tst(i) == tst(i+1) 
         counter=counter+1;
     else
         if counter > max_counter
             max_counter=counter;
             max_id=i;
         end
         counter=1;
     end
end
if counter> max_counter
    max_counter=counter;
    max_id=k-1;
end
res=tst(max_id);
end
