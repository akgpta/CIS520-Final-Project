%neural_network.m

function [W1_hat, W2_hat, b1_hat, b2_hat] = neural_network_2(X, Y, learning_rate, iterations, W1_0, W2_0, b1_0, b2_0, nn_type)
    % changing y values from -1, +1 to 0, +1
    Y = (Y + 1)/2; 
 
    [m, ~] = size(X); 

    logistic_sigmoid = @(z) 1./(1 + exp(-1 .* z)); 
    logistic_sigmoid_derv = @(z) logistic_sigmoid(z) - logistic_sigmoid(z).^2; 
    relu = @(z) max(z,0);
    function[g] = relu_derv(z)
        g = sign(z);
        g(z > 0) = 1; 
        g(z <= 0) = 0;   
    end
    
    function [W1, W2, b1, b2] = batch_gradient_descent(W1, W2, b1, b2)
        for i = 1:iterations
            z = W1 * X' + b1; %d_1 x m
            [z_m, z_n] = size(z);
            a = zeros(z_m, z_n); 
            g_derv = zeros(z_m, z_n); 
            
            if isequal(nn_type, 'sigmoid')
                a = logistic_sigmoid(z);
                g_derv = logistic_sigmoid_derv(z);
            elseif isequal(nn_type, 'relu')
                a = relu(z);
                g_derv = relu_derv(z);
            end         
            
            f_wb = W2 * a + b2; %1 x m
            
            f_ls = logistic_sigmoid(f_wb); 
                                   
            derv_b2 = sum(f_ls - Y')/m; %1 x 1
            derv_W2 = (f_ls - Y') * a'/m; %1 x d_1
            derv_b1 = (f_ls - Y') * g_derv' .* W2/m'; %d_1 x 1
            derv_W1 = (W2' * (f_ls - Y')) .* g_derv * X/m; 
            
            W1 = W1 - (learning_rate .* derv_W1);            
            b1 = b1 - (learning_rate * derv_b1)';
            W2 = W2 - (learning_rate .* derv_W2);
            b2 = b2 - (learning_rate .* derv_b2);
        end
    end

    [W1_hat, W2_hat, b1_hat, b2_hat] = batch_gradient_descent(W1_0, W2_0, b1_0, b2_0); 
end