d = size(X_train, 2);

% standardizing X_train
X_stan = (X_train - mean(X_train))./std(X_train);

A = [1, 2, 5, 10, 100]; 

alphas = cartesian(A, d); 

k_values = [1, 2, 5, 10]; 

err_cv = zeros(cv_size, 3);

for i = 1:cv_size
    errors = zeros(size(alphas, 2), 4);

    for a = 1:size(alphas, 2)
        alpha = alphas(a, :);

        for k = 1:4
            k_val = k_values(k); 

            % gotta get folds for X_stan and Y_train
            Y_pred = k_nearest_neighbor(X_stan, Y_train, alpha, k_val, X_test);

            err = squared_error(Y_pred, Y_actual);
            errors(a, k) = err;
        end
    end

    min_err = min(errors, [], 'all');
    max_err = max(errors, [], 'all');
    avg_err = sum(sum(errors))/(size(errors) * size(errors, 2));
    
    err_cv(i, 1) = min_err;
    err_cv(i, 2) = max_err;
    err_cv(i, 3) = avg_err;
end