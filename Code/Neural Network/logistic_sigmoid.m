function g = logistic_sigmoid(z)
%SIGMOID Computes the logistic sigmoid of the array z

g = 1.0 ./ (1.0 + exp(-z));

end

