function [W1, b1, W2, b2] = TrainNetwork(x, y, W1, b1, W2, b2, activation_function, activation_function_derivative, num_iter, learning_rate)
%TRAINNETWORK Returns the final weights and biases of one hidden layer
%network

for iter = 1:num_iter
    [J, w1_grad, w2_grad, b1_grad, b2_grad] = cost(x, y, W1, W2, b1, b2, activation_function, activation_function_derivative);
    W1 = W1 - learning_rate * w1_grad;
    W2 = W2 - learning_rate * w2_grad;
    b1 = b1 - learning_rate * b1_grad; 
    b2 = b2 - learning_rate * b2_grad;
end

end

