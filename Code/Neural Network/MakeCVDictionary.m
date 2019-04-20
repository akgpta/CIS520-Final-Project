function [cv_data_x, cv_data_y] = MakeCVDictionary(cv_data_path)
%MakeCVDictionary Makes the CV dictionaries for a given data path 
for i = 1:5
        cv_data_x{i} = importdata(strcat(cv_data_path, int2str(i), '/X_100%.txt'));
        cv_data_y{i} = importdata(strcat(cv_data_path, int2str(i), '/Y_100%.txt'));
end

end

