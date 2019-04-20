function [J, w1_grad, w2_grad, b1_grad, b2_grad] = cost(x, y, W_1, W_2, b_1, b_2, activation_function, activation_function_derivative)
%COST computes the cost and gradients of a neural network with one layer

b_1_add = repmat(b_1, 1, size(x, 1))';
z1 = x * W_1' + b_1_add;
a1 = activation_function(z1);

fw_b = a1 * W_2' + b_2;
mu_hat = fw_b;
m = length(y);
J = (1/m) * sum(sum((mu_hat - y) .^ 2));

w1_grad = zeros(size(W_1));
w2_grad = zeros(size(W_2));
b1_grad = zeros(size(b_1));
b2_grad = zeros(size(b_2));

for i = 1 : m
    
    this_example = x(i,:);
    z1 = W_1 * this_example' + b_1;
    a1 = activation_function(z1);
    z2 = W_2 * a1 + b_2;
    a2 = z2;
    
    error = a2 - y(i, :);

    delta_1 = (W_2' * error) .* activation_function_derivative(z1);
    
    
    w2_grad = w2_grad + (error * a1');
    w1_grad = w1_grad + (delta_1 * this_example);
    b1_grad = b1_grad + delta_1;
    b2_grad = b2_grad + error;
end

w1_grad = 2 * w1_grad / m;
w2_grad = 2 * w2_grad / m;
b1_grad = 2 * b1_grad / m;
b2_grad = 2 * b2_grad / m;


end