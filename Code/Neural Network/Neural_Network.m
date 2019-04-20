get_data()

num_features = 8;

activation_function_string = "logistic";
num_iters = 5000;
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

num_hiddens = [1, 5, 10, 15, 25, 50, 100];
cv_errors = [];
training_errors = [];
testing_errors = [];

for num_hidden = num_hiddens
    
    cv_error = 0;
    W1 = rand(num_hidden, num_features);
    b1 = rand(1);
    W2 = rand(1, num_hidden);
    b2 = rand(1);
    
    train_W1 = W1;
    train_b1 = b1;
    train_W2 = W2;
    train_b2 = b2;

for fold = 1:4
    X_train_cv = [cv_data_x{fold}];
    y_train_cv = [cv_data_y{fold}];
    X_test_cv = [x_tests{fold}];
    y_test_cv = [y_tests{fold}];
        
    [W1, b1, W2, b2] = TrainNetwork(X_train_cv, y_train_cv, W1, b1, W2, b2, activation_function, activation_function_derivative, num_iters, learning_rate);
    
    y_hat_test = predict(X_test_cv, W1, W2, b1, b2, activation_function);
    
    error = mean_squared_error(y_hat_test, y_test_cv);
    
    cv_error = cv_error + error;
    
    
end

cv_error = cv_error / 5;

disp("Done with network with hidden layer size: " + num_hidden);
disp("Average CV error: " + cv_error);

cv_errors = [cv_errors, cv_error];

[train_W1, train_b1, train_W2, train_b2] = TrainNetwork(X_train, Y_train, train_W1, train_b1, train_W2, train_b2, activation_function, activation_function_derivative, num_iters, learning_rate);
y_hat_train = predict(X_train, train_W1, train_W2, train_b1, train_b2, activation_function);

train_error = mean_squared_error(y_hat_train, Y_train);

y_hat_test = predict(X_test, train_W1, train_W2, train_b1, train_b2, activation_function);
test_error = mean_squared_error(y_hat_test, Y_test);

disp("Training Error: " + train_error);
disp("Testing Error: " + test_error);
training_errors = [training_errors, train_error];
testing_errors = [testing_errors, test_error];

end


plot(num_hiddens, cv_errors, num_hiddens, training_errors, num_hiddens, testing_errors);

legend({'CV Error', 'Training Error', 'Testing Error'},'Location','northeast')
title('Error vs. Hidden Layer Size with Activation Function: ' + activation_function_string);
xlabel('Num Hidden Units')
ylabel('Classification Error');


