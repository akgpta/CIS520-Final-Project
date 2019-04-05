get_data

d = size(X_10, 2);

A = [1, 2, 5]; 
alphas = cartesian(A, d); 

k_values = [1,2,5,10]; 

err_cv = zeros(size(alphas,1), size(k_values,2));

for a = 1:size(alphas, 1)
    alpha = alphas(a, :);

    for k = 1:size(k_values,2)
        k_val = k_values(k); 

        for i = 1:length(x_folds)
            Y_pred = k_nearest_neighbor(x_folds{i}, y_folds{i}, alpha, k_val, x_tests{i});
            err = squared_error(Y_pred, y_tests{i});
            err_cv(a, k) = err_cv(a,k) + err;
        end
    end
end
err_cv = err_cv./length(x_folds);

foo_axis = 1:size(alphas);
foo_axis = foo_axis.';
foo_axis = repmat(foo_axis, 1, size(k_values,2));
foo_axis = foo_axis(:);

bar_axis = repmat(k_values,size(alphas,1),1);
bar_axis = bar_axis(:);

z_values = err_cv(:);

scatter3(foo_axis, bar_axis, z_values);
xlabel("alpha index");
ylabel("k value");
zlabel("average cv error");
title("stuff");
%TODO: holdout period