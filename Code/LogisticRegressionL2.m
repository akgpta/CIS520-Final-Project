%LogisticRegressionL2

function [w, b] = LogisticRegressionL2(traindata, trainlabels, lambda)
    % INPUT : 
    % traindata   - m X n matrix, where m is the number of training points
    % trainlabels - m X 1 vector of training labels for the training data
    % lambda      - regularization parameter (positive real number)
        
    % OUTPUT
    % returns learnt model: w - n x 1 weight vector, b - bias term
    
    [m, n] = size(traindata); 
    
    function[res] = LogLikelihood(weight)
        res = 0;
        
        for i = 1:m
            a = -1 * trainlabels(i) * weight' * [traindata(i,:), 1]';
            res = res + log(1 + exp(a));
        end
        res = res + lambda * (weight(1:n)' * weight(1:n)); 
    end

    options = optimset('MaxFunEvals',60000,'MaxIter',1000);
 
    RandomW = ones(n+1, 1);
    w_hat = fminunc(@LogLikelihood, RandomW, options);
    
    b = w_hat(n + 1);
    w = w_hat(1:n,:);
end
