% Run time of Program is  sec on windows 10 system with i5 processor 
clc
clear all
close all
tic;
load('../images/assignmentImageDenoisingBrainNoisy.mat');



%partA: estimating noise
%(x1,y1) to (x2,y2) will determine the background window
x1 = 1; y1=1; x2 = 50; y2 = 50;
[noise_real, noise_imag] = find_noise(imageNoisy,x1,y1,x2,y2);
noise = noise_real + i*noise_imag;

%part B and part C

%% parameters for huber
alpha_array=linspace(0.01,1,10);
gamma_array=linspace(0.01,0.1,10);
for u=1:length(alpha_array)
    for v=1:length(gamma_array)
        s = 0.1; 
        i =1;
        Current_Iterative_Image = imageNoisy;
        alpha = alpha_array(u);
        gamma = gamma_array(v);
        objective_array=[];
        prior_type = 'huber';
        prev_objective = Inf;
        converged = false;

        gradient_descent; %for huber

        fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
        imshow(mat2gray(abs(Current_Iterative_Image))); title(['Optimal Image of Denoised Brain for ' ,prior_type,' prior with alpha = ',num2str(alpha),'and gamma=' ,num2str(gamma)]);
        saveas(fig,['../images/Huber_Tuning/Optimal_Denoised_Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
        close(fig);

        fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
        imshow(mat2gray(abs(imageNoisy))); title(['Noisy Image for ' ,prior_type,' prior with alpha = ',num2str(alpha),'and gamma=' ,num2str(gamma)]);
        saveas(fig,['../images/Huber_Tuning/Optimal_Denoised_Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
        close(fig);

        fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
        subplot(1,2,2)
        imshow(mat2gray(abs(Current_Iterative_Image)));
        title('Denoised Image')
        subplot(1,2,1)
        imshow(mat2gray(abs(imageNoisy)));
        title('Noisy Image')
        saveas(fig,['../images/Huber_Tuning/Combined Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
        close(fig);

        fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
        plot(log(objective_array)); title(['Plot of Objective Function for ' ,prior_type,' prior with alpha = ',num2str(alpha),'and gamma=' ,num2str(gamma)]);
        saveas(fig,['../images/Huber_Tuning/Objective Functio Plot for ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
        close(fig);
    end 
end 

%% parameters for disc_adapt_function
alpha_array=linspace(0.01,1,10);
gamma_array=linspace(0.01,0.1,10);
for u=1:length(alpha_array)
    for v=1:length(gamma_array)
        s = 0.1; 
        i =1;
        objective_array=[];
        Current_Iterative_Image = imageNoisy;
        alpha = alpha_array(u);
        gamma = gamma_array(v);
        [alpha,gamma]
        prior_type = 'disc_adapt_function';
        prev_objective = Inf;
        converged = false;

        gradient_descent; %for disc_adapt_function

        fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
        imshow(mat2gray(abs(Current_Iterative_Image))); title(['Optimal Image of Denoised Brain for ' ,prior_type,' prior with alpha = ',num2str(alpha),'and gamma=' ,num2str(gamma)]);
        saveas(fig,['../images/Disc_adapt_function_Tuning/Optimal_Denoised_Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
        close(fig);

        fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
        imshow(mat2gray(abs(imageNoisy))); title(['Noisy Image for ' ,prior_type,' prior with alpha = ',num2str(alpha),'and gamma=' ,num2str(gamma)]);
        saveas(fig,['../images/Disc_adapt_function_Tuning/Optimal_Denoised_Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
        close(fig);

        fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
        subplot(1,2,2)
        imshow(mat2gray(abs(Current_Iterative_Image)));
        title('Denoised Image')
        subplot(1,2,1)
        imshow(mat2gray(abs(imageNoisy)));
        title('Noisy Image')
        saveas(fig,['../images/Disc_adapt_function_Tuning/Combined Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
        close(fig);

        fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
        plot(log(objective_array)); title(['Plot of Objective Function for ' ,prior_type,' prior with alpha = ',num2str(alpha),'and gamma=' ,num2str(gamma)]);
        saveas(fig,['../images/Disc_adapt_function_Tuning/Objective Functio Plot for ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
        close(fig);
    end
end

%% parameters for quadratic
alpha_array=linspace(0.01,1,10);
for u=1:length(alpha_array)
    s = 0.1; 
    i =1;
    Current_Iterative_Image = imageNoisy;
    prev_temp =imageNoisy ;
    alpha = alpha_array(u);
    gamma = 1.18;
    objective_array=[];
    prior_type = 'quadratic';
    prev_objective = Inf;
    converged = false;

    gradient_descent; %for quadratic

    fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
    imshow(mat2gray(abs(Current_Iterative_Image))); title(['Optimal Image of Denoised Brain for ' ,prior_type,' prior with alpha = ',num2str(alpha),'and gamma=' ,num2str(gamma)]);
    saveas(fig,['../images/Quadratic_Tuning/Optimal_Denoised_Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
    close(fig);

    fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
    imshow(mat2gray(abs(imageNoisy))); title(['Noisy Image for ' ,prior_type,' prior with alpha = ',num2str(alpha),'and gamma=' ,num2str(gamma)]);
    saveas(fig,['../images/Quadratic_Tuning/Optimal_Denoised_Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
    close(fig);

    fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
    subplot(1,2,2)
    imshow(mat2gray(abs(Current_Iterative_Image)));
    title('Denoised Image')
    subplot(1,2,1)
    imshow(mat2gray(abs(imageNoisy)));
    title('Noisy Image')
    saveas(fig,['../images/Quadratic_Tuning/Combined Image for Brain ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
    close(fig);

    fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
    plot(log(objective_array)); title(['Plot of Objective Function for ' ,prior_type,' prior with alpha = ',num2str(alpha),'and gamma=' ,num2str(gamma)]);
    saveas(fig,['../images/Quadratic_Tuning/Objective Functio Plot for ',prior_type,' prior with alpha ' num2str(alpha),'with gamma ',num2str(gamma),'.jpg'],'jpg');
    close(fig);

end 