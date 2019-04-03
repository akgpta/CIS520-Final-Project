% get_data.m

% Train subsets
X_subset = cell(10,1);

X_mean_init = cell(10,1);

mu_init = cell(5,1);

X_train_fold = cell(5,1);
X_test_fold = cell(5,1);

for i = 1:10
    X_subset{i} = dlmread(strcat('../Data/TrainSubsets/X_train_', int2str(i), '0%.txt'));
    X_mean_init{i} = dlmread(strcat('../Data/MeanInitialization/Part_a/mu_', int2str(i), '0%.txt'));
end

for i = 1:5
    mu_init{i} = dlmread(strcat('../Data/MeanInitialization/Part_b/mu_k_', int2str(i), '.txt'));
    
    X_train_fold{i} = dlmread(strcat('../Data/CrossValidation/X_train_fold', int2str(i), '.txt'));
    X_test_fold{i} = dlmread(strcat('../Data/CrossValidation/X_test_fold', int2str(i), '.txt'));
end

X_train = dlmread(strcat('../Data/X_train.txt'));
X_test = dlmread(strcat('../Data/X_test.txt'));

