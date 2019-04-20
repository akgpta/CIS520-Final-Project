function [y_hat] = predict(x, W_1, W_2, b_1, b_2, activation_function)
%PREDICT Summary of this function goes here
%   Detailed explanation goes here
b_1_add = repmat(b_1, 1, size(x, 1))';
z1 = x * W_1' + b_1_add;
a1 = activation_function(z1);

fw_b = a1 * W_2' + b_2;
y_hat = fw_b;
end

