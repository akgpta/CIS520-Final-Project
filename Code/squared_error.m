% squared_error.m

function [err] = squared_error(Y_pred, Y_actual)
    err = sum ((Y_pred - Y_actual).^2);
end
