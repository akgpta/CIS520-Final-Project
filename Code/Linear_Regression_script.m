get_data

d = size(X_10, 2);

err_cv = zeros(length(x_folds), 1);

for i = 1:length(x_folds)
    [w, b] = LinearLeastSquareRegression(x_folds{i}, y_folds{i}, 0);
    Y_pred = w' * x_tests{i}' + b; 
    err_cv(i) = squared_error(Y_pred', y_tests{i});
end

[w, b] = LinearLeastSquareRegression(X_train, Y_train, 0);
Y_pred_train = w' * X_train' + b; 
y_train_err = squared_error(Y_pred_train', Y_train);

Y_pred_test = w' * X_test' + b; 
y_test_err = squared_error(Y_pred_test', Y_test);
       
% Linear Regression Regularized
lambda_values = [0.001, 0.01, 0.1, 1, 10, 100, 500, 1000];

err_cv_L2 = zeros(length(x_folds), size(lambda_values, 2)); 
err_L2 = zeros(4, size(lambda_values, 2)); 

err_L2(1, :) = log10(lambda_values);

for l = 1:size(lambda_values, 2)
    for i = 1:length(x_folds)
        [w, b] = LinearLeastSquareRegression(x_folds{i}, y_folds{i}, lambda_values(l));
        Y_pred = w' * x_tests{i}' + b; 
        err_cv_L2(i, l) = squared_error(Y_pred', y_tests{i});
    end
    
    err_L2(2,l) = mean(err_cv_L2(:, l));
    
    [w, b] = LinearLeastSquareRegression(X_train, Y_train, lambda_values(l));
    Y_pred_train = w' * X_train' + b; 
    err_L2(3, l) = squared_error(Y_pred_train', Y_train);
    
    Y_pred_test = w' * X_test' + b; 
    err_L2(4, l) = squared_error(Y_pred_test', Y_test);
end

%plot training, test, cross-validation error
figure
plot(err_L2(1, :), err_L2(2, :),'g-')
hold on; 
plot(err_L2(1, :), err_L2(3, :),'b-')
hold on; 
plot(err_L2(1, :), err_L2(4, :),'r-')
title('Squared Error of L_2 Regularized Linear Regression')
xlabel('Lambda Values') 
ylabel('Square Error') 
legend({'cross-validation error', 'training error','test error', })
