function [S0, S1, S5, R0, R1, R5, rrmse_array ] = Question2_b(Input_Image)

    S0 = Input_Image;
    mask = fspecial ('gaussian', 11, 1);
    S1 = conv2 (S0, mask, 'same');
    mask = fspecial ('gaussian', 51, 5);
    S5 = conv2 (S0, mask, 'same');
    
    theta_array = [0:3:177];
    
    [rad0, r_dist_0] = radon(S0, theta_array);
    ram_lak0 = myFilter(rad0,r_dist_0,1,'ram_lak');
    R0 = iradon(ram_lak0, theta_array,'none',1.0, 256);
    
    [rad1, r_dist_1] = radon(S1, theta_array);
     ram_lak1 = myFilter(rad1,r_dist_1,1,'ram_lak');
    R1 = iradon(ram_lak1, theta_array,'none',1.0, 256);
    
    [rad5, r_dist_5] = radon(S5, theta_array);
     ram_lak5 = myFilter(rad5,r_dist_5,1,'ram_lak');
    R5 = iradon(ram_lak5, theta_array,'none',1.0, 256);
    
    rrmse_array = zeros(3,1);
    rrmse_array(1) = getRRMSE(S0, R0);
    rrmse_array(2) = getRRMSE(S1, R1);
    rrmse_array(3) = getRRMSE(S5, R5);
    
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imagesc(theta_array,r_dist_0,rad0);
title(['Radon Transform of S0 Phantom']);
xlabel('\theta (degrees)');ylabel('X\prime');set(gca,'XTick',0:20:177);
colormap(hot);colorbar;axis on;
saveas(fig,['../images/Question2_b/RadonTransform_R0_Phantom_',num2str(rrmse_array(1)),'.jpg'],'jpg');
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(R0)); title(['OutputIradon for S0 Phantom']);
saveas(fig,['../images/Question2_b/Iradon_Output_R0_Phantom_',num2str(rrmse_array(1)),'.jpg'],'jpg');
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(S0)); title(['Input Image S0']);
saveas(fig,['../images/Question2_b/Iradon_Input_S0_Phantom_',num2str(rrmse_array(1)),'.jpg'],'jpg');

fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imagesc(theta_array,r_dist_1,rad1);
title(['Radon Transform of S1 Phantom']);
xlabel('\theta (degrees)');ylabel('X\prime');set(gca,'XTick',0:20:177);
colormap(hot);colorbar;axis on;
saveas(fig,['../images/Question2_b/RadonTransform_R1_Phantom_',num2str(rrmse_array(2)),'.jpg'],'jpg');
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(R1)); title(['OutputIradon for S1 Phantom']);
saveas(fig,['../images/Question2_b/Iradon_Output_R1_Phantom_',num2str(rrmse_array(2)),'.jpg'],'jpg');
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(S1)); title(['Input Image S1']);
saveas(fig,['../images/Question2_b/Iradon_Input_S1_Phantom_',num2str(rrmse_array(2)),'.jpg'],'jpg');

fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imagesc(theta_array,r_dist_5,rad5);
title(['Radon Transform of S5 Phantom']);
xlabel('\theta (degrees)');ylabel('X\prime');set(gca,'XTick',0:20:177);
colormap(hot);colorbar;axis on;
saveas(fig,['../images/Question2_b/RadonTransform_R5_Phantom_',num2str(rrmse_array(3)),'.jpg'],'jpg');
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(R5)); title(['OutputIradon for S5 Phantom']);
saveas(fig,['../images/Question2_b/Iradon_Output_R5_Phantom_',num2str(rrmse_array(3)),'.jpg'],'jpg');
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(S5)); title(['Input Image S5']);
saveas(fig,['../images/Question2_b/Iradon_Input_S5_Phantom_',num2str(rrmse_array(3)),'.jpg'],'jpg');


end
    
    


