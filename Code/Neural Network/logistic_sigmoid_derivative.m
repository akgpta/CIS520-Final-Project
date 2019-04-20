function g = logistic_sigmoid_derivative(z)
%RELU Computes the RELU of z

g = logistic_sigmoid(z) .* (1 - logistic_sigmoid(z));

end
