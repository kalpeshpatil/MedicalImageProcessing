% Run time of Program is  16 sec on windows 10 system with i5 processor 
clc
close all
tic;
load('../data/assignmentImageReconstructionBrain');
kSpaceData = imageKspaceData;
mask = imageKspaceMask;

fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(ifft2(imageKspaceData))));
title(['Inverse Fourier Kspace Data Image']);
saveas(fig,['../images/','Inverse Fourier Image Image','.jpg'],'jpg');
close(fig);

%% parameters for huber
alpha_optimal=1-1e-6;
gamma_optimal=0.012;
s = 0.1; 
i =1;
Current_Iterative_Image = ifft2(kSpaceData);
alpha = alpha_optimal;
gamma = gamma_optimal;
objective_array=[];
prior_type = 'huber';
prev_objective = Inf;
converged = false;

gradient_descent; %for huber

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(Current_Iterative_Image))); title(['Optimal Image of Reconstructed Brain for ' ,prior_type,' prior']);
saveas(fig,['../images/Huber/Optimal_Denoised_Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
subplot(1,2,2)
imshow(mat2gray(abs(Current_Iterative_Image)));
title('Reconstructed Image')
subplot(1,2,1)
imshow(mat2gray(abs(ifft2(kSpaceData))));
title('Inverse Fourier Image')
saveas(fig,['../images/Huber/Combined Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(ifft2(kSpaceData))));
title('Inverse Fourier Image')
saveas(fig,['../images/Huber/Inverse Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);
fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(log(objective_array)); title(['Plot of Objective Function for ' ,prior_type,' prior']);
saveas(fig,['../images/Huber/Objective Functio Plot for ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);


%% parameters for disc_adapt_function
alpha_optimal=1-1e-5;
gamma_optimal=0.09;
s = 0.1; 
i =1;
objective_array=[];
Current_Iterative_Image = ifft2(kSpaceData);
alpha = alpha_optimal;
gamma = gamma_optimal;
[alpha,gamma]
prior_type = 'disc_adapt_function';
prev_objective = Inf;
converged = false;

gradient_descent; %for disc_adapt_function

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(Current_Iterative_Image))); title(['Optimal Image of Reconstructed Brain for ' ,prior_type,' prior']);
saveas(fig,['../images/Disc_adapt_function/Optimal_Denoised_Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
subplot(1,2,2)
imshow(mat2gray(abs(Current_Iterative_Image)));
title('Reconstructed Image')
subplot(1,2,1)
imshow(mat2gray(abs(ifft2(kSpaceData))));
title('Inverse Fourier Image')
saveas(fig,['../images/Disc_adapt_function/Combined Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(ifft2(kSpaceData))));
title('Inverse Fourier Image')
saveas(fig,['../images/Disc_adapt_function/Inverse Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);
fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(log(objective_array)); title(['Plot of Objective Function for ' ,prior_type,' prior']);
saveas(fig,['../images/Disc_adapt_function/Objective Functio Plot for ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);

%% parameters for quadratic
alpha_optimal=1-1e-4;

s = 0.1; 
i =1;
Current_Iterative_Image = ifft2(kSpaceData);
prev_temp =kSpaceData ;
alpha = alpha_optimal;
gamma = 1;
objective_array=[];
prior_type = 'quadratic';
prev_objective = Inf;
converged = false;

gradient_descent; %for quadratic

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(Current_Iterative_Image))); title(['Optimal Image of Reconstructed Brain for ' ,prior_type,' prior']);
saveas(fig,['../images/Quadratic/Optimal_Denoised_Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
subplot(1,2,2)
imshow(mat2gray(abs(Current_Iterative_Image)));
title('Reconstructed Image')
subplot(1,2,1)
imshow(mat2gray(abs(ifft2(kSpaceData))));
title('Inverse Fourier Image')
saveas(fig,['../images/Quadratic/Combined Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(ifft2(kSpaceData))));
title('Inverse Fourier Image')
saveas(fig,['../images/Quadratic/Inverse Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);
fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(log(objective_array)); title(['Plot of Objective Function for ' ,prior_type,' prior']);
saveas(fig,['../images/Quadratic/Objective Functio Plot for ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);
toc;
