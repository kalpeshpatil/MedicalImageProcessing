    tic;
clc;
clear all;
close all;


S = [0.5045 - 0.0217i, 0.6874 + 0.0171i, 0.3632 + 0.1789i, 0.3483 + 0.1385i, 0.2606 - 0.0675i, 0.2407 + 0.1517i];
S_real = real(S);
S_mag = abs(S);
N = 6;
g = [1,0; 0.866,0.5; 0.5,0.866; 0,1; -0.5,0.866; -0.866,0.5];  
b0 = 0.1;

[D,D11_array,D12_array,D21_array,D22_array,obj_array] = projected_grad_descent(S_real,g,b0);

disp('D matrix:');
disp(D);

%part b and c

[eigVec, eigVal] = eig(D);
principal_dir = eigVec(:,2);
disp('principal dirction:');
disp(principal_dir);
diffusion_factor = eigVal(2,2)/eigVal(1,1);
disp('multiplicative factor for diffusion:');
disp(diffusion_factor);

%plots

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(log(obj_array)); title('Plot of log Objective Function');
saveas(fig,'../images/Objective Function.jpg','jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(D11_array); title('Plot of D(1,1)');
saveas(fig,'../images/D11','jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(D12_array); title('Plot of D(1,2)');
saveas(fig,'../images/D12.jpg','jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(D21_array); title('Plot of D(2,1)');
saveas(fig,'../images/D21.jpg','jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(D22_array); title('Plot of D(2,2)');
saveas(fig,'../images/D22.jpg','jpg');
close(fig);



toc;

