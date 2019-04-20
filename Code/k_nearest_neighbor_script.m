get_data

d = size(X_10, 2);

k_values = [1,2,3,5,10]; 
q_values = [1,2,3]; 

err_nn = zeros(3, size(k_values,2)); 
err_cv_min = zeros(size(k_values,2), size(q_values,2));
err_min_train = zeros(size(k_values,2), size(q_values,2));
err_min_test = zeros(size(k_values,2), size(q_values,2));

for k = 1:size(k_values,2)
    k_val = k_values(k); 
    
    % k-NN via Eucledian distances
    
    % cross val
    err_sum_cv_nn = 0;
    for i = 1:length(x_folds)
        Y_pred = k_nearest_neighbor(x_folds{i}, y_folds{i}, k_val, x_tests{i});
        err_sum_cv_nn = err_sum_cv_nn + squared_error(Y_pred, y_tests{i});
    end
    err_nn(1, k) = err_sum_cv_nn/length(x_folds); 
    
    % training err
    Y_pred_train = k_nearest_neighbor(X_train, X_train, k_val, X_train);
    err_nn(2, k) = squared_error(Y_pred_train, Y_train);
    
    % testing error
    Y_pred_test = k_nearest_neighbor(X_train, X_train, k_val, X_test);
    err_nn(3, k) = squared_error(Y_pred_test, Y_test);
    
    for q = 1:size(q_values, 2)
        q_val = q_values(q); 
        
        % k-NN via Minkowski
        
        % cross-val
        err_sum_cv = 0;
        for i = 1:length(x_folds)
            Y_pred = k_nearest_neighbor_minkowski(x_folds{i}, y_folds{i}, k_val, x_tests{i}, q_val);
            err = squared_error(Y_pred, y_tests{i});
            err_sum_cv = err_sum_cv + err; 
        end
        err_cv_min(k, q) = err_sum_cv/length(x_folds); 
        
        % training error
        Y_pred_train = k_nearest_neighbor_minkowski(X_train, X_train, k_val, X_train, q_val);
        err_min_train(k, q) = squared_error(Y_pred_train, Y_train);
        
        % test error
        Y_pred_test = k_nearest_neighbor_minkowski(X_train, X_train, k_val, X_test, q_val);
        err_min_test(k, q) = squared_error(Y_pred_test, Y_test);
    end
    
end

figure
plot(k_values, err_nn(1, :),'-')
hold on; 
plot(k_values, err_nn(2, :),'-')
hold on;
plot(k_values, err_nn(3, :),'-')
title('k-Nearest Neighbors')
xlabel('Value of K') 
ylabel('Square Error') 
legend({'Cross Validation Error', 'Training Error','Test Error'})

figure
plot(k_values, min(err_cv_min.'),'-')
hold on; 
plot(k_values, min(err_min_train.'),'-')
hold on;
plot(k_values, min(err_min_test.'),'-')
title('k-Nearest Neighbors Using Minkowski Distance Formula')
xlabel('Value of K') 
ylabel('Square Error') 
legend({'Cross Validation Error', 'Training Error','Test Error'})

%{
A = [1, 2, 5, 10]; 
alphas = cartesian(A, d); 

err_cv = zeros(size(alphas,1), size(k_values,2));

for a = 1:size(alphas, 1)
    alpha = alphas(a, :);

    for k = 1:size(k_values,2)
        k_val = k_values(k); 

        for i = 1:length(x_folds)
            Y_pred = k_nearest_neighbor(x_folds{i}, y_folds{i}, alpha, k_val, x_tests{i});
            err = squared_error(Y_pred, y_tests{i});
            err_cv(a, k) = err_cv(a,k) + err;
        end
    end
end
err_cv = err_cv./length(x_folds);

foo_axis = 1:size(alphas);
foo_axis = foo_axis.';
foo_axis = repmat(foo_axis, 1, size(k_values,2));
foo_axis = foo_axis(:);

bar_axis = repmat(k_values,size(alphas,1),1);
bar_axis = bar_axis(:);

z_values = err_cv(:);

scatter3(foo_axis, bar_axis, z_values);
xlabel("alpha index");
ylabel("k value");
zlabel("average cv error");
title("stuff");
%TODO: holdout period
%}