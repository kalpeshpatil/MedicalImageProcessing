% Run time of Program is  22.966717 sec on windows 10 system with i5 processor 
clc
clear all
close all
tic;
load('../data/assignmentImageDenoisingBrainNoisy.mat');

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(imageNoisy))); title(['Noisy Brain Image']);
saveas(fig,['../images/Noisy Image for Brain','.jpg'],'jpg');
close(fig);

%% partA: estimating noise
%(x1,y1) to (x2,y2) will determine the background window
x1 = 1; y1=1; x2 = 50; y2 = 50;
[noise_real, noise_imag] = find_noise(imageNoisy,x1,y1,x2,y2);
noise = noise_real + i*noise_imag

%part B and part C

%% parameters for huber
alpha_optimal=0.78;
gamma_optimal=0.06;
s = 0.1; 
i =1;
Current_Iterative_Image = imageNoisy;
alpha = alpha_optimal;
gamma = gamma_optimal;
objective_array=[];
prior_type = 'huber';
prev_objective = Inf;
converged = false;

gradient_descent; %for huber

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(Current_Iterative_Image))); title(['Optimal Image of Denoised Brain for ' ,prior_type,' prior']);
saveas(fig,['../images/Huber/Optimal_Denoised_Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(imageNoisy))); title(['Noisy Image for Brain']);
saveas(fig,['../images/Huber/Noisy Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
subplot(1,2,2)
imshow(mat2gray(abs(Current_Iterative_Image)));
title('Denoised Image')
subplot(1,2,1)
imshow(mat2gray(abs(imageNoisy)));
title('Noisy Image')
saveas(fig,['../images/Huber/Combined Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(log(objective_array));xlabel('Iteration'); ylabel('log of Objective Function');
 title(['Variation of log of Objective Function with iterations for ' ,prior_type]);
saveas(fig,['../images/Huber/Objective Functio Plot for ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);


%% parameters for disc_adapt_function
alpha_optimal=0.78;
gamma_optimal=0.09;
s = 0.1; 
i =1;
objective_array=[];
Current_Iterative_Image = imageNoisy;
alpha = alpha_optimal;
gamma = gamma_optimal;
[alpha,gamma]
prior_type = 'disc_adapt_function';
prev_objective = Inf;
converged = false;

gradient_descent; %for disc_adapt_function

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(Current_Iterative_Image))); title(['Optimal Image of Denoised Brain for ' ,prior_type,' prior']);
saveas(fig,['../images/Disc_adapt_function/Optimal_Denoised_Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(imageNoisy))); title(['Noisy Image for Brain']);
saveas(fig,['../images/Disc_adapt_function/Noisy Image for Brain ',prior_type,' prior','.jpg'],'jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
subplot(1,2,2)
imshow(mat2gray(abs(Current_Iterative_Image)));
title('Denoised Image')
subplot(1,2,1)
imshow(mat2gray(abs(imageNoisy)));
title('Noisy Image')
saveas(fig,['../images/Disc_adapt_function/Combined Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(log(objective_array)); xlabel('Iteration'); ylabel('log of Objective Function');
 title(['Variation of log of Objective Function with iterations for ' ,prior_type]);
saveas(fig,['../images/Disc_adapt_function/Objective Functio Plot for ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);

%% parameters for quadratic
alpha_optimal=0.45;

s = 0.1; 
i =1;
Current_Iterative_Image = imageNoisy;
prev_temp =imageNoisy ;
alpha = alpha_optimal;
gamma = 1;
objective_array=[];
prior_type = 'quadratic';
prev_objective = Inf;
converged = false;

gradient_descent; %for quadratic

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(Current_Iterative_Image))); title(['Optimal Image of Denoised Brain for ' ,prior_type,' prior']);
saveas(fig,['../images/Quadratic/Optimal_Denoised_Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'.jpg'],'jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(abs(imageNoisy))); title(['Noisy Image for Brain' ]);
saveas(fig,['../images/Quadratic/Noisy Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'.jpg'],'jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
subplot(1,2,2)
imshow(mat2gray(abs(Current_Iterative_Image)));
title('Denoised Image')
subplot(1,2,1)
imshow(mat2gray(abs(imageNoisy)));
title('Noisy Image')
saveas(fig,['../images/Quadratic/Combined Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'.jpg'],'jpg');
close(fig);

fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(log(objective_array)); xlabel('Iteration'); ylabel('log of Objective Function');
 title(['Variation of log of Objective Function with iterations for ' ,prior_type]);
saveas(fig,['../images/Quadratic/Objective Functio Plot for ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
close(fig);
toc;
