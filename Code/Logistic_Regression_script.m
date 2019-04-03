% Unregularized Logistic Regression
[w, b] = LogisticRegression(X_train, Y_train);
Y_pred = w' * X_test' + b; 

unreg_err = classification_error(Y_pred, Y_actual);

% L2 Logistic Regression
lambda_values = [10^(-7), 10^(-6), 10^(-5), 10^(-4), 10^(-3), 10^(-2), 10^(-1), 1];

[m, d] = size(X_train); 

L2_err = zeros(m, 8); 

for l = 1: size(lambda_values)    
    [w, b] = LogisticRegressionL2(X_train, Y_train, lambda_values(l));

    Y_pred = w' * X_test' + b; 
    
    err = classification_error(Y_pred, Y_actual); 
    L2_err(:, l) = err;
end
