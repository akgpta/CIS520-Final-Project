%LinearLeastSquareRegression.m 

function [w, b] = LinearLeastSquareRegression(traindata, trainlabels, lambda)
    % INPUT : 
    % traindata   - m X n matrix, where m is the number of training points
    % trainlabels - m X 1 vector of training labels for the training data
    % lambda      - regularization parameter (positive real number)
        
    % OUTPUT
    % returns learnt model: w - n x 1 weight vector, b - bias term
    
    [m, n] = size(traindata);
    X_augmented = ones(m, 1); 
    
    X = horzcat(traindata, X_augmented); 
    a = zeros(n, 1); 
    A = horzcat(eye(n), a); 
    a = zeros (1, n+1); 
    A = vertcat(A, a);
        
    w_hat = (X'* X + (lambda * m) .* A)^(-1) * X' * trainlabels; 
    b = w_hat(n + 1);
    w = w_hat(1:n,:);
end