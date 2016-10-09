function [out0, out1a, out1b, out2a, out2b, out3a, out3b] = Question2_a(Input_Image)
%radon transform and inverse radon transform (without filtering)

theta_array = 0:3:177;
[rad0, r_dist] = radon(Input_Image, theta_array);
fig = figure;set(gcf, 'Position', get(0,'Screensize'));
imagesc(theta_array,r_dist,rad0);
title(['Radon Transform of Shepp-Logan Phantom']);
xlabel('\theta (degrees)');ylabel('X\prime');set(gca,'XTick',0:20:177);
colormap(hot);colorbar;axis on;
saveas(fig,['../images/Question2_a/RadonTransform_Phanton','.jpg'],'jpg');

out0 = iradon(rad0, theta_array,'none',1.0, 256);
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(out0)); title(['Output of Inverse Radon Transform for Shepp-Logan Phantom']);
saveas(fig,['../images/Question2_a/Iradon_Output','.jpg'],'jpg');
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(Input_Image)); title(['Shepp-Logan']);
saveas(fig,['../images/Question2_a/Input','.jpg'],'jpg');

%Ram-Lak filter
ram_lak1 = myFilter(rad0,r_dist,1,'ram_lak');
out1a = iradon(ram_lak1, theta_array,'none',1.0, 256);

ram_lak2 = myFilter(rad0,r_dist,0.5,'ram_lak');
out1b = iradon(ram_lak2, theta_array,'none',1.0, 256);

%Shepp-Logan filter
shepp_logan1 = myFilter(rad0,r_dist,1,'shepp_logan');
out2a = iradon(shepp_logan1, theta_array,'none',1.0, 256);

shepp_logan2 = myFilter(rad0,r_dist,0.5,'shepp_logan');
out2b = iradon(shepp_logan2, theta_array,'none',1.0, 256);

%Cosine filter
cosine1 = myFilter(rad0,r_dist,1,'cosine');
out3a = iradon(cosine1, theta_array,'none',1.0, 256);

cosine2 = myFilter(rad0,r_dist,0.5,'cosine');
out3b = iradon(cosine2, theta_array,'none',1.0, 256);

fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imagesc(theta_array,r_dist,ram_lak1);
title(['Radon Transform of Phantom with filter Ram\_Lak with L=Wmax']);
xlabel('\theta (degrees)');ylabel('X\prime');set(gca,'XTick',0:20:177);
colormap(hot);colorbar;axis on;
saveas(fig,['../images/Question2_a/RadonTransform_Phanton_Ram_Lak_1','.jpg'],'jpg');
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(out1a)); title(['Output for Ram\_Lak with L=Wmax']);
saveas(fig,['../images/Question2_a/Iradon_Output_Ram_Lak_1','.jpg'],'jpg');

fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imagesc(theta_array,r_dist,ram_lak2);
title(['Radon Transform of Phantom with filter Ram\_Lak with L=0.5*Wmax']);
xlabel('\theta (degrees)');ylabel('X\prime');set(gca,'XTick',0:20:177);
colormap(hot);colorbar;axis on;
saveas(fig,['../images/Question2_a/RadonTransform_Phanton_Ram_Lak_0.5','.jpg'],'jpg');
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(out1b)); title(['Output for Ram\_Lak with L=0.5*Wmax']);
saveas(fig,['../images/Question2_a/Iradon_Output_Ram_Lak_0.5','.jpg'],'jpg');

fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imagesc(theta_array,r_dist,shepp_logan1);
title(['Radon Transform of Phantom with filter shepp\_logan with L=Wmax']);
xlabel('\theta (degrees)');ylabel('X\prime');set(gca,'XTick',0:20:177);
colormap(hot);colorbar;axis on;
saveas(fig,['../images/Question2_a/RadonTransform_Phanton_shepp_logan_1','.jpg'],'jpg');
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(out2a)); title(['Output for shepp\_logan with L=Wmax']);
saveas(fig,['../images/Question2_a/Iradon_Output_shepp_logan_1','.jpg'],'jpg');

fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imagesc(theta_array,r_dist,shepp_logan2);
title(['Radon Transform of Phantom with filter shepp\_logan with L=0.5*Wmax']);
xlabel('\theta (degrees)');ylabel('X\prime');set(gca,'XTick',0:20:177);
colormap(hot);colorbar;axis on;
saveas(fig,['../images/Question2_a/RadonTransform_Phanton_shepp_logan_0.5','.jpg'],'jpg');
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(out2b)); title(['Output for shepp\_logan with L=0.5*Wmax']);
saveas(fig,['../images/Question2_a/Iradon_Output_shepp_logan_0.5','.jpg'],'jpg');

fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imagesc(theta_array,r_dist,cosine1);
title(['Radon Transform of Phantom with filter cosine with L=Wmax']);
xlabel('\theta (degrees)');ylabel('X\prime');set(gca,'XTick',0:20:177);
colormap(hot);colorbar;axis on;
saveas(fig,['../images/Question2_a/RadonTransform_Phanton_cosine_1','.jpg'],'jpg');
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(out3a)); title(['Output for cosine with L=1*Wmax']);
saveas(fig,['../images/Question2_a/Iradon_Output_cosine_1','.jpg'],'jpg');

fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imagesc(theta_array,r_dist,cosine2);
title(['Radon Transform of Phantom with filter cosine with L=0.5*Wmax']);
xlabel('\theta (degrees)');ylabel('X\prime');set(gca,'XTick',0:20:177);
colormap(hot);colorbar;axis on;
saveas(fig,['../images/Question2_a/RadonTransform_Phanton_cosine_0.5','.jpg'],'jpg');
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(out3b)); title(['Output for cosine with L=0.5*Wmax']);
saveas(fig,['../images/Question2_a/Iradon_Output_cosine_0.5','.jpg'],'jpg');

end

