% get_data.m

X_data = {0,0,0,0,0};
Y_data = {0,0,0,0,0};
for i = 0:4
   X_temp = readtable('../Matlab-Data/x_201'+string(i)+'.csv');
   Y_temp = readtable('../Matlab-Data/y_201'+string(i)+'.csv', 'ReadVariableNames', false);
   X_temp = X_temp{:, :};
   Y_temp = Y_temp{:, :};
   X_data{i+1} = standardize(X_temp);
   Y_data{i+1} = Y_temp;
end

% X_10 = readtable('../Matlab-Data/x_2010.csv');
% X_10 = X_10{:,:};
% X_10 = standardize(X_10);
% 
% X_10 = standardize((readtable('../Matlab-Data/x_2010.csv')));
% X_11 = standardize((readtable('../Matlab-Data/x_2011.csv')));
% X_12 = standardize((readtable('../Matlab-Data/x_2012.csv')));
% X_13 = standardize((readtable('../Matlab-Data/x_2013.csv')));
% X_14 = standardize((readtable('../Matlab-Data/x_2014.csv')));
% 
% Y_10 = (readtable('../Matlab-Data/y_2010.csv'));
% Y_11 = (readtable('../Matlab-Data/y_2011.csv'));
% Y_12 = (readtable('../Matlab-Data/y_2012.csv'));
% Y_13 = (readtable('../Matlab-Data/y_2013.csv'));
% Y_14 = (readtable('../Matlab-Data/y_2014.csv'));

X_10 = X_data{1};
X_11 = X_data{2};
X_12 = X_data{3};
X_13 = X_data{4};
X_14 = X_data{5};

Y_10 = Y_data{1};
Y_11 = Y_data{2};
Y_12 = Y_data{3};
Y_13 = Y_data{4};
Y_14 = Y_data{5};

x_fold_1 = [X_11; X_12; X_13];
y_fold_1 = [Y_11; Y_12; Y_13];

x_fold_2 = [X_10; X_12; X_13];
y_fold_2 = [Y_10; Y_12; Y_13];

x_fold_3 = [X_10; X_11; X_13];
y_fold_3 = [Y_10; Y_11; Y_13];

x_fold_4 = [X_10; X_11; X_12];
y_fold_4 = [Y_10; Y_11; Y_12];

X_train = [X_10; X_11; X_12; X_13]; 
Y_train = [Y_10; Y_11; Y_12; Y_13]; 

x_folds = {x_fold_1, x_fold_2, x_fold_3, x_fold_4};
x_tests = {X_10, X_11, X_12, X_13};
y_folds = {y_fold_1, y_fold_2, y_fold_3, y_fold_4};
y_tests = {Y_10, Y_11, Y_12, Y_13};

function [res] = standardize(x) 
    res = (x - mean(x))./std(x);
end
