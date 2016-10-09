% Run time of Program is 39.054 sec on windows 10 system with i5 processor 
clc
clear all
close all
tic;
%CT_Chest
chest = load('../data/CT_Chest.mat');
%imshow(chest.imageAC,[]);
chest_image = mat2gray(chest.imageAC);

%Phantom
phantom_ = load('../data/myPhantom.mat');
%figure; imshow(phantom_.imageAC,[]);
phantom_image = mat2gray(phantom_.imageAC);

%CT Reconstruction 
theta_array = [1:1:180]';
rrmse = zeros(1,180);
rad = radon(chest_image, [1:180]);
for i = 1:180
    if(i<31)
    rad_temp = rad (:,i:i+150);
    theta_temp = [i:1:i+150];
    else
    rad_temp = rad(:,[i:180,1:i-30]);
    theta_temp = [i:180,1:i-30];
    end
    reconstruted = mat2gray(iradon(rad_temp,theta_temp,'linear','Ram-Lak',1,512));
    rrmse(i) = getRRMSE(chest_image,reconstruted);
end
theta_min = find(rrmse == min(rrmse));
if(theta_min<31)
  rad_temp = rad (:,theta_min:theta_min+150);
  theta_temp = [theta_min:1:theta_min+150];
else
  rad_temp = rad(:,[theta_min:180,1:theta_min-30]);
  theta_temp = [theta_min:180,1:theta_min-30];
end
best_rec = mat2gray(iradon(rad_temp,theta_temp,'linear','Ram-Lak',1,512));
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(best_rec)); title(['Best Reconstructed chest\_image']);
saveas(fig,['../images/Best_Reconstruction_chest_image_Minimum_Error_Angle_',num2str(theta_min),'MinRRMSE_',num2str(min(rrmse)),'.jpg'],'jpg');
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(rrmse);
xlabel('\theta (degrees)');ylabel('X\prime');
title('RRMSE variation with angle \theta for chest_image')
saveas(fig,['../images/RRMSE_Plot_chest_image','.jpg'],'jpg');

%phantom

theta_array = [1:1:180]';
rrmse = zeros(1,180);
rad = radon(phantom_image, [1:180]);
for i = 1:180
    if(i<31)
    rad_temp = rad (:,i:i+150);
    theta_temp = [i:1:i+150];
    else
    rad_temp = rad(:,[i:180,1:i-30]);
    theta_temp = [i:180,1:i-30];
    end
    reconstruted = mat2gray(iradon(rad_temp,theta_temp,'Ram-Lak',1,256));
    rrmse(i) = getRRMSE(phantom_image,reconstruted);
end
theta_min = find(rrmse == min(rrmse));
if(theta_min<31)
  rad_temp = rad (:,theta_min:theta_min+150);
  theta_temp = [theta_min:1:theta_min+150];
else
  rad_temp = rad(:,[theta_min:180,1:theta_min-30]);
  theta_temp = [theta_min:180,1:theta_min-30];
end
best_rec = mat2gray(iradon(rad_temp,theta_temp,'Ram-Lak',1,256));
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(best_rec)); title(['Best Reconstructed Phantom']);
saveas(fig,['../images/Best_Reconstruction_Phantom_Minimum_Error_Angle_',num2str(theta_min),'MinRRMSE_',num2str(min(rrmse)),'.jpg'],'jpg');
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(rrmse);
xlabel('\theta (degrees)');ylabel('X\prime');
title('RRMSE variation with angle \theta for Phantom')
saveas(fig,['../images/RRMSE_Plot_Phantom','.jpg'],'jpg');
toc;
