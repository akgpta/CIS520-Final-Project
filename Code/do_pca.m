
clc;

get_data;
[coeff,score,latent] = pca(X_train);
coeff


% mean1 = mean(x_train(:,1));
% mean2 = mean(x_train(:,2));
% v1 = coeff(:,1)
% v2 = coeff(:,2)
% 
% xlinspace1 = linspace(-3,5);
% f1 = mean2 - mean1*v1(2)/v1(1) + v1(2)/v1(1)*xlinspace1;
% xlinspace2 = linspace(-1,3);
% f2 = mean2 - mean1*v2(2)/v2(1) + v2(2)/v2(1)*xlinspace2;
% scatter(x_train(:,1), x_train(:,2));
% hold on
% plot(xlinspace1, f1, xlinspace2, f2);
% axis equal
% xlim([-3 5])
% figure();
% 
% centered_data = [synth_data(:,1)-mean1, synth_data(:,2)-mean2];
% v1proj = centered_data * v1;
% v2proj = centered_data * v2;
% scatter(v1proj, v2proj);
% axis equal
% figure();
% 
% scatter(v1proj, zeros(size(v1proj)));
% figure();
% scatter(zeros(size(v2proj)),v2proj);
% figure();
% 
% 
% end