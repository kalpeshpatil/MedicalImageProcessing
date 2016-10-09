%Assignment 4 Q2
% Run time for this programme is 20 sec on windows 10 system with i5
% processor.
clc
clear all
close all
tic;
K=3;
Beta_Optimal=0.8;
a = load('../data/assignmentSegmentBrainGmmEmMrf.mat');

Y = a.imageData;
mask = a.imageMask;
mask_3=zeros([size(mask) 3]);
mask_3(:,:,1)=mask;mask_3(:,:,2)=mask;mask_3(:,:,3)=mask;
[m,n] = size(Y);
Mu=[0.25, 0.5, 0.75]';
Sigma_sq=[1,1,1]';
Beta=Beta_Optimal;
U=ones(m,n,K);
Parameters_Prev=[Mu' Sigma_sq'];
Initial_Array=[];
Final_Array=[];
converged=false;
iter=0;
% Y_Values=Y(mask>0);
% Y_Vec=Y_Values(:);
% idx = kmeans(Y_Vec,3);
% R=Y*mask;R(mask>0)=idx;
Labels=[1,2,3];
a = load('Initial_Guess.mat');
Current_Labels = a.Initial_Guess;
EM;
X_optimal=X_MAP;
U_optimal=U;    
Mu_Optimal=Mu;
Initial_Array_Optimal=log(Initial_Array);
Final_Array_Optimal=log(Final_Array);

Beta=0;
U=ones(m,n,K);
Parameters_Prev=[Mu' Sigma_sq'];
Initial_Array=[];
Final_Array=[];
converged=false;
iter=0;
Labels=[1,2,3];
a = load('Initial_Guess.mat');
Current_Labels = a.Initial_Guess;

EM;
X_0=X_MAP;
U_0=U;
Initial_Array_0=log(Initial_Array);
Final_Array_0=log(Final_Array);

Y_Values=Y(mask>0);Y_Vec=Y_Values(:);idx = kmeans(Y_Vec,K);
Initial_Guess=Y.*mask;Initial_Guess(mask>0)=idx;

%% Outputting things to file
M=max([max(X_0(:)),max(X_optimal(:)),max(Y(:))]);
% Corrupted Image
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(Y/M);
title(['Corrupted Image of brain']);
saveas(fig,['../images/Corrupted Image','.jpg'],'jpg');
close(fig);
% Initial Guess Labels
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(Initial_Guess));
title(['Initial Guess of Labels using question 1']);
saveas(fig,['../images/Initial Guess of Labels using question 1','jpg'],'jpg');
close(fig);
% Outputting Optimal Membership Estimates
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(U_optimal(:,:,1));
title(['Optimal Membership for first class with Beta=' ,num2str(Beta_Optimal)]);
saveas(fig,['../images/Optimal Membership estimates for first class with Beta ',num2str(Beta_Optimal),'.jpg'],'jpg');
close(fig);
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(U_optimal(:,:,2));
title(['Optimal Membership for second class with Beta=' ,num2str(Beta_Optimal)]);
saveas(fig,['../images/Optimal Membership estimates for second class with Beta ',num2str(Beta_Optimal),'.jpg'],'jpg');
close(fig);
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(U_optimal(:,:,3));
title(['Optimal Membership for third class with Beta=' ,num2str(Beta_Optimal)]);
saveas(fig,['../images/Optimal Membership estimates for third class with Beta ',num2str(Beta_Optimal),'.jpg'],'jpg');
close(fig);

fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(U_optimal(:,:,3));
title(['Optimal Membership for third class with Beta=' ,num2str(Beta_Optimal)]);
saveas(fig,['../images/Optimal Membership estimates for third class with Beta ',num2str(Beta_Optimal),'.jpg'],'jpg');
close(fig);

% Optimal labels for image
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(X_optimal));
title(['Optimal label image Beta=' ,num2str(Beta_Optimal)]);
saveas(fig,['../images/Optimal label image ',num2str(Beta_Optimal),'.jpg'],'jpg');
close(fig);
% Outputting Beta=0 MemberShip Estimates
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(U_0(:,:,1));
title(['Membership for first class with Beta=0']);
saveas(fig,['../images/Membership estimates for first class with Beta 0','.jpg'],'jpg');
close(fig);

fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(U_0(:,:,2));
title(['Membership for second class with Beta=0']);
saveas(fig,['../images/Membership estimates for second class with Beta 0','.jpg'],'jpg');
close(fig);

fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(U_0(:,:,3));
title(['Membership for third class with Beta=0']);
saveas(fig,['../images/Membership estimates for third class with Beta 0','.jpg'],'jpg');
close(fig);

% Optimal labels for image for beta=0
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(X_0));
title(['Optimal label image Beta= 0' ]);
saveas(fig,['../images/Optimal label image with beta =0','.jpg'],'jpg');
close(fig);


% Plotting Value initial and final value of map estimates
 fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(1:1:length(Initial_Array_Optimal),Initial_Array_Optimal,'-ro',1:1:length(Final_Array_Optimal),Final_Array_Optimal,'-.b')
legend('Initial','Final')
title(['Plot of log of Initial and Final Objective Function in ICM for Beta = ',num2str(Beta_Optimal)])
saveas(fig,['../images/Initial and final log Objective function for Beta = ',num2str(Beta_Optimal),'.jpg'],'jpg');
 close(fig)
 
 fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(1:1:length(Initial_Array_0),Initial_Array_0,'-ro',1:1:length(Final_Array_0),Final_Array_0,'-.b')
legend('Initial','Final')
title(['Plot of log of Initial and Final Objective Function in ICM for Beta = 0'])
saveas(fig,['../images/Initial and final log Objective function for Beta = 0','.jpg'],'jpg');
 close(fig)
toc;
