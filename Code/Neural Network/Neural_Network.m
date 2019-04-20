get_data()

num_features = 8;

activation_function_string = "relu";
num_iters = 20000;
learning_rate = 0.001;

if (strcmp(activation_function_string,"relu"))
    activation_function = @relu;
    activation_function_derivative = @relu_derivative;
else
    activation_function = @logistic_sigmoid;
    activation_function_derivative = @logistic_sigmoid_derivative;
end

cv_data_x = x_folds;
cv_data_y = y_folds;

num_hiddens = [1, 5, 10, 15, 25, 50];
cv_errors = [];

for num_hidden = num_hiddens
    
    cv_error = 0;
    W1 = rand(num_hidden, num_features);
    b1 = 0.5;
    W2 = rand(1, num_hidden);
    b2 = 0.5;

for fold = 1:4
    X_train_cv = [];
    y_train_cv = [];
    X_test_cv = cv_data_x{fold};
    y_test_cv = cv_data_y{fold};
    
    for idx = 1:4
            if idx ~= fold
                X_train_cv = [X_train_cv; cv_data_x{idx}];
                y_train_cv = [y_train_cv; cv_data_y{idx}];
            end
    end
    
    disp("Training neural network of size: " + num_hidden);
    
    [W1, b1, W2, b2] = neural_network_2(X_train_cv, y_train_cv, learning_rate, num_iters, W1, W2, b1, b2, 'relu');
    
    y_hat_test = predict(X_test_cv, W1, W2, b1, b2, activation_function);
    
    error = mean_squared_error(y_hat_test, y_test_cv);
    
    disp("Error on this fold: " + error);
    cv_error = cv_error + error;
    
    
end

cv_error = cv_error / 5;

disp("Done with network with hidden layer size: " + num_hidden);
disp("Average CV error: " + cv_error);

cv_errors = [cv_errors, cv_error];

end

