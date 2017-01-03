function [accuracy,precision,recall,f_score]=evaluate_func(output,test)
    true_matches = find(output(:) == test(:));
    accuracy = size(true_matches,1)/size(test,1);
    precision = size(find(output(true_matches(:)) == 1),1) / size(find(output(:) == 1),1);
    recall = size(find(output(true_matches(:)) == 1),1) / size(find(test(:) == 1),1);
    f_score = precision * recall / (precision + recall);
end