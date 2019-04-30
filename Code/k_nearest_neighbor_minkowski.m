% k_nearest_neighbor.m

function [Y_output] = k_nearest_neighbor_minkowski(X_train, Y_train, k, X_test, q);

% X_train is m x d
% Y_train is m x 1

% alpha is d x 1
% k = # of nearest neighbor

% X_test is m' x d
% Y_output is m' x 1

[m, ~] = size(X_test);
Y_output = zeros(m, 1);

for i = 1: m
    dist_to_all_datapoints = sum((abs(X_train - X_test(i, :))).^q, 2);
    
    [~, k_nearest_idx] = mink(dist_to_all_datapoints, k);
    
    sum_y = 0;

    for j = 1:k
        sum_y = sum_y + Y_train(k_nearest_idx(j)); 
    end
    
    avg_y = sum_y/k;
    
    Y_output(i) = avg_y;
end

end
