% cartesian.m

% Generate all possible d-sequences from elements of A
function [res] = cartesian(A, d)

    % A is m x 1
    % d is 1 x 1
    % res is   m^d x d

    m = size(A,2);

    res = zeros(m^d, d);
    for i = 0:m^d - 1
        curr = zeros(1,d);
        for j = 0:d-1
            curr(d-j) = A(1 + floor(mod(i,m^(j+1))/m^j));
        end
        res(i+1,:) = curr;
    end
end