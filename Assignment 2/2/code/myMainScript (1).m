% Run time of Program is 78.766712 sec on windows 10 system with i5 processor 

tic;
%% RRMSE between noiseless image and noisy image is 0.2931
load('../data/assignmentImageDenoisingPhantom.mat');
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(imageNoiseless)));
title(['Noiseless Image']);
saveas(fig,['../images/','Noiseless Image','.jpg'],'jpg');
close(fig);

fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(imageNoisy)));
title(['Noisy Image']);
saveas(fig,['../images/','Noisy Image','.jpg'],'jpg');
close(fig);

%% MRF Prior Quadratic Function

prior_type='quadratic';
 alpha_optimal=0.2310;
 [Original, Achieved_Optimal,Image_Optimal,Objective_Array]=myDenoiser(alpha_optimal,1,prior_type);
 % Finding Values for min(1.2*alpha_optimal,1)
 [Original, Achieved_Optimal_12,Image_Optimal_12]=myDenoiser(min(1.2*alpha_optimal,1),1,prior_type);
 % Finding Values for 0.8*alpha_optimal
 [Original, Achieved_Optimal_08,Image_Optimal_08]=myDenoiser(0.8*alpha_optimal,1,prior_type);
 % Plotting optimal images 
 fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
 imshow(mat2gray(abs(Image_Optimal)));
 title(['Optimal Image for ' ,prior_type,' prior with alpha = ',num2str(alpha_optimal),'and RRMSE= ' ,num2str(Achieved_Optimal)]);
 saveas(fig,['../images/Quadratic/Optimal_Denoised_Image for ',prior_type,' prior with alpha ' num2str(alpha_optimal),'with RRMSE',num2str(Achieved_Optimal),'.jpg'],'jpg');
 close(fig);
 % Plotting suboptimal images
 fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
 imshow(mat2gray(abs(Image_Optimal_12))); title(['SubOptimal Image for ' ,prior_type,' prior with alpha = ',num2str(min(1.2*alpha_optimal,1)),'and RRMSE= ' ,num2str(Achieved_Optimal_12)]);
 saveas(fig,['../images/Quadratic/SubOptimal_Denoised_Image for ',prior_type,' prior with alpha ' num2str(min(1.2*alpha_optimal,1)),'with RRMSE',num2str(Achieved_Optimal_12),'.jpg'],'jpg');
 close(fig);
 % Plotting suboptimal images
 fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
 imshow(mat2gray(abs(Image_Optimal_08))); title(['SubOptimal Image for ' ,prior_type,' prior with alpha = ',num2str(alpha_optimal*0.8),'and RRMSE= ' ,num2str(Achieved_Optimal_08)]);
 saveas(fig,['../images/Quadratic/SubOptimal_Denoised_Image for ',prior_type,' prior with alpha ' num2str(0.8*alpha_optimal),'with RRMSE',num2str(Achieved_Optimal_08),'.jpg'],'jpg');
 close(fig)
 % Plotting Value of Objective Function
 fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
 plot(log(Objective_Array));
 xlabel('Iteration'); ylabel('log of Objective Function');
 title(['Variation of log of Objective Function with iterations for ' ,prior_type]);
 saveas(fig,['../images/Quadratic/Plot of Objective Function for  ',prior_type,'.jpg'],'jpg');
 close(fig)
 
 %% MRF Prior Huber Function
prior_type='huber';

alpha_optimal=1;gamma_optimal=0.01;
[Original, Achieved_Optimal,Image_Optimal,Objective_Array]=myDenoiser(alpha_optimal,gamma_optimal,prior_type);
[Original, Achieved_Optimal_a_12,Image_Optimal_a_12]=myDenoiser(min(1.2*alpha_optimal,1),gamma_optimal,prior_type);
[Original, Achieved_Optimal_a_08,Image_Optimal_a_08]=myDenoiser(0.8*alpha_optimal,gamma_optimal,prior_type);
[Original, Achieved_Optimal_g_12,Image_Optimal_g_12]=myDenoiser(alpha_optimal,1.2*gamma_optimal,prior_type);
[Original, Achieved_Optimal_g_08,Image_Optimal_g_08]=myDenoiser(alpha_optimal,0.8*gamma_optimal,prior_type);
a=[Achieved_Optimal,Achieved_Optimal_a_08,Achieved_Optimal_a_12,Achieved_Optimal_g_08,Achieved_Optimal_g_12]
% Showing Optimal Image
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(Image_Optimal)));
title(['Optimal Image for ' ,prior_type,' prior with alpha = ',num2str(alpha_optimal),' and gamma= ',num2str(gamma_optimal),'and RRMSE= ' ,num2str(Achieved_Optimal)]);
saveas(fig,['../images/Huber/Optimal_Denoised_Image for ',prior_type,' prior with alpha ' num2str(alpha_optimal),' and gamma ',num2str(gamma_optimal),'with RRMSE',num2str(Achieved_Optimal),'.jpg'],'jpg');
close(fig);
% Suboptimal Image for alpha=min(1.2*alpha_optimal,1); gamma=gamma_optimal
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(Image_Optimal_a_12)));
title(['SubOptimal Image for ' ,prior_type,' prior with alpha = ',num2str(min(1.2*alpha_optimal,1)),' and gamma= ',num2str(gamma_optimal),'and RRMSE= ' ,num2str(Achieved_Optimal_a_12)]);
saveas(fig,['../images/Huber/SubOptimal_Denoised_Image for ',prior_type,' prior with alpha ' num2str(min(1.2*alpha_optimal,1)),' and gamma ',num2str(gamma_optimal),'with RRMSE',num2str(Achieved_Optimal_a_12),'.jpg'],'jpg');
close(fig);
% Suboptimal Image for alpha=0.8*alpha_optimal; gamma=gamma_optimal
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(Image_Optimal_a_08)));
title(['SubOptimal Image for ' ,prior_type,' prior with alpha = ',num2str(alpha_optimal*0.8),' and gamma= ',num2str(gamma_optimal),'and RRMSE= ' ,num2str(Achieved_Optimal_a_08)]);
saveas(fig,['../images/Huber/SubOptimal_Denoised_Image for ',prior_type,' prior with alpha ' num2str(alpha_optimal*0.8),' and gamma ',num2str(gamma_optimal),'with RRMSE',num2str(Achieved_Optimal_a_08),'.jpg'],'jpg');
close(fig);
% Suboptimal Image for alpha=alpha_optimal; gamma=1.2*gamma_optimal
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(Image_Optimal_g_12)));
title(['SubOptimal Image for ' ,prior_type,' prior with alpha = ',num2str(alpha_optimal),' and gamma= ',num2str(gamma_optimal*1.2),'and RRMSE= ' ,num2str(Achieved_Optimal_g_12)]);
saveas(fig,['../images/Huber/SubOptimal_Denoised_Image for ',prior_type,' prior with alpha ' num2str(alpha_optimal),' and gamma ',num2str(gamma_optimal*1.2),'with RRMSE',num2str(Achieved_Optimal_g_12),'.jpg'],'jpg');
close(fig);
% Suboptimal Image for alpha=alpha_optimal; gamma=0.8*gamma_optimal
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(Image_Optimal_g_08)));
title(['SubOptimal Image for ' ,prior_type,' prior with alpha = ',num2str(alpha_optimal),' and gamma= ',num2str(gamma_optimal*0.8),'and RRMSE= ' ,num2str(Achieved_Optimal_g_08)]);
saveas(fig,['../images/Huber/SubOptimal_Denoised_Image for ',prior_type,' prior with alpha ' num2str(alpha_optimal),' and gamma ',num2str(gamma_optimal*0.8),'with RRMSE',num2str(Achieved_Optimal_g_08),'.jpg'],'jpg');
close(fig);
% Plotting Value of Objective Function
 fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
  plot(Objective_Array);xlabel('Iteration'); ylabel('log of Objective Function');
 title(['Variation of log of Objective Function with iterations for ' ,prior_type]);
 saveas(fig,['../images/Huber/Plot of Objective Function for  ',prior_type,'.jpg'],'jpg');
 close(fig)
 %% MRF Prior disc_adapt_function
prior_type='disc_adapt_function';

alpha_optimal=0.999;gamma_optimal=0.008;
[Original, Achieved_Optimal,Image_Optimal,Objective_Array]=myDenoiser(alpha_optimal,gamma_optimal,prior_type);
[Original, Achieved_Optimal_a_12,Image_Optimal_a_12]=myDenoiser(min(1.2*alpha_optimal,1),gamma_optimal,prior_type);
[Original, Achieved_Optimal_a_08,Image_Optimal_a_08]=myDenoiser(0.8*alpha_optimal,gamma_optimal,prior_type);
[Original, Achieved_Optimal_g_12,Image_Optimal_g_12]=myDenoiser(alpha_optimal,1.2*gamma_optimal,prior_type);
[Original, Achieved_Optimal_g_08,Image_Optimal_g_08]=myDenoiser(alpha_optimal,0.8*gamma_optimal,prior_type);
a=[Achieved_Optimal,Achieved_Optimal_a_08,Achieved_Optimal_a_12,Achieved_Optimal_g_08,Achieved_Optimal_g_12]
% Showing Optimal Image
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(Image_Optimal)));
title(['Optimal Image for ' ,prior_type,' prior with alpha = ',num2str(alpha_optimal),' and gamma= ',num2str(gamma_optimal),'and RRMSE= ' ,num2str(Achieved_Optimal)]);
saveas(fig,['../images/Disc_adapt_function/Optimal_Denoised_Image for ',prior_type,' prior with alpha ' num2str(alpha_optimal),' and gamma ',num2str(gamma_optimal),'with RRMSE',num2str(Achieved_Optimal),'.jpg'],'jpg');
close(fig);
% Suboptimal Image for alpha=min(1.2*alpha_optimal,1); gamma=gamma_optimal
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(Image_Optimal_a_12)));
title(['SubOptimal Image for ' ,prior_type,' prior with alpha = ',num2str(min(1.2*alpha_optimal,1)),' and gamma= ',num2str(gamma_optimal),'and RRMSE= ' ,num2str(Achieved_Optimal_a_12)]);
saveas(fig,['../images/Disc_adapt_function/SubOptimal_Denoised_Image for ',prior_type,' prior with alpha ' num2str(min(1.2*alpha_optimal,1)),' and gamma ',num2str(gamma_optimal),'with RRMSE',num2str(Achieved_Optimal_a_12),'.jpg'],'jpg');
close(fig);
% Suboptimal Image for alpha=0.8*alpha_optimal; gamma=gamma_optimal
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(Image_Optimal_a_08)));
title(['SubOptimal Image for ' ,prior_type,' prior with alpha = ',num2str(alpha_optimal*0.8),' and gamma= ',num2str(gamma_optimal),'and RRMSE= ' ,num2str(Achieved_Optimal_a_08)]);
saveas(fig,['../images/Disc_adapt_function/SubOptimal_Denoised_Image for ',prior_type,' prior with alpha ' num2str(alpha_optimal*0.8),' and gamma ',num2str(gamma_optimal),'with RRMSE',num2str(Achieved_Optimal_a_08),'.jpg'],'jpg');
close(fig);
% Suboptimal Image for alpha=alpha_optimal; gamma=1.2*gamma_optimal
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(Image_Optimal_g_12)));
title(['SubOptimal Image for ' ,prior_type,' prior with alpha = ',num2str(alpha_optimal),' and gamma= ',num2str(gamma_optimal*1.2),'and RRMSE= ' ,num2str(Achieved_Optimal_g_12)]);
saveas(fig,['../images/Disc_adapt_function/SubOptimal_Denoised_Image for ',prior_type,' prior with alpha ' num2str(alpha_optimal),' and gamma ',num2str(gamma_optimal*1.2),'with RRMSE',num2str(Achieved_Optimal_g_12),'.jpg'],'jpg');
close(fig);
% Suboptimal Image for alpha=alpha_optimal; gamma=0.8*gamma_optimal
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(Image_Optimal_g_08)));
title(['SubOptimal Image for ' ,prior_type,' prior with alpha = ',num2str(alpha_optimal),' and gamma= ',num2str(gamma_optimal*0.8),'and RRMSE= ' ,num2str(Achieved_Optimal_g_08)]);
saveas(fig,['../images/Disc_adapt_function/SubOptimal_Denoised_Image for ',prior_type,' prior with alpha ' num2str(alpha_optimal),' and gamma ',num2str(gamma_optimal*0.8),'with RRMSE',num2str(Achieved_Optimal_g_08),'.jpg'],'jpg');
close(fig);
% Plotting Value of Objective Function
 fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
 plot(Objective_Array);xlabel('Iteration'); ylabel('log of Objective Function');
 title(['Variation of log of Objective Function with iterations for ' ,prior_type]);
 saveas(fig,['../images/Disc_adapt_function/Plot of Objective Function for  ',prior_type,'.jpg'],'jpg');
 close(fig)
toc;
