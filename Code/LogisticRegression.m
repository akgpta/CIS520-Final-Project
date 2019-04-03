%LogisticRegression

function [w, b] = LogisticRegression(traindata, trainlabels)
    % INPUT : 
    % traindata   - m X n matrix, where m is the number of training points
    % trainlabels - m X 1 vector of training labels for the training data    
    
    % OUTPUT
    % returns learnt model: w - n x 1 weight vector, b - bias term
    
    % Fill in your code here    
    %Consider using fminunc MATLAB function for solving the logistic regression optimization problem.
    
    [m, n] = size(traindata); 
    
    function[res] = LogLikelihood(weight)
        res = 0;
        
        for i = 1:m
            a = -1 * trainlabels(i) * weight' * [traindata(i,:), 1]';
            res = res + log(1 + exp(a));
        end
    end

    options = optimset('MaxFunEvals',30000,'MaxIter',1000);
 
    RandomW = ones(n+1, 1);
    w_hat = fminunc(@LogLikelihood, RandomW, options);
    
    b = w_hat(n + 1);
    w = w_hat(1:n,:);
end
