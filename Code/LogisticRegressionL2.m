function [w, b] = LogisticRegressionL2(traindata, trainlabels, lambda)
    % INPUT : 
    % traindata   - m X n matrix, where m is the number of training points
    % trainlabels - m X 1 vector of training labels for the training data
    % lambda      - regularization parameter (positive real number)
        
    % OUTPUT
    % returns learnt model: w - n x 1 weight vector, b - bias term

    x0 = zeros(size(traindata, 2) + 1, 1);
    x0 = .25+x0;
    
    function neg_ll_reg = log_likelihood_logistic_objective_reg(weights)

    weights_no_bias = weights(1:size(weights, 1)-1);
    bias = weights(size(weights, 1));

    neg_ll_reg = sum(log(1.+exp(-1.*trainlabels.*(bias+traindata*weights_no_bias)))) + lambda*(weights_no_bias.' *weights_no_bias);

    end
    
    options = optimoptions(@fminunc, 'MaxIterations', 2500, 'MaxFunctionEvaluations', 100000);
    x_star = fminunc(@log_likelihood_logistic_objective_reg, x0, options);
    
    w = x_star(1:size(x_star, 1)-1); 
    b = x_star(size(x_star, 1)) ;
end
