%Assignment 4 Q1
clc
close all
clear all
%% Parameters
K = 3; %no of classes
q = 5; %q parameter
WindowSize = 20;
Standard_Deviation_Window = 3;
%% Main Code
load('../data/assignmentSegmentBrain.mat');
mask = imageMask;
mask_3=zeros([size(mask) 3]);
mask_3(:,:,1)=mask;mask_3(:,:,2)=mask;mask_3(:,:,3)=mask;
input = imageData;
[m,n] = size(input);
weights = fspecial('gaussian',WindowSize,Standard_Deviation_Window);
Bias_Field = ones(m,n);

U = ones(m,n,K)/K;

converged = false;
prevObj = Inf;
currObj = Inf;
values=[];
iter = 0;
D = zeros(m,n,K);
C = [0.25, 0.5, 0.75]';
convIn = mask.*(conv2((input),weights,'same'));
convInSq = mask.*(conv2((input).^2,weights,'same'));
temp=zeros(m,n);
while(~converged)
iter =iter +1;
if (iter==1)
%% finding djk
    convBias = conv2((Bias_Field), weights,'same');
    convBiasSq = conv2((Bias_Field).^2, weights,'same');
    for i=1:K
        D(:,:,i)=mask.*(input.^2+(C(i)^2).*convBiasSq-2*C(i).*(input.*convBias)+2.2204e-16); 
    end
    Raised_D=(D.^(1/(-q+1)));
    Raised_D_Sum=sum((mask_3.*Raised_D),3);
%% finding memberships

    for i=1:K
        garbage=mask.*(Raised_D(:,:,i)./(Raised_D_Sum));
        temp(mask>0)=garbage(mask>0);
        U(:,:,i)=temp;
    end   
    
    %saving initial memberships 
    
end

   
    
 
%% finding class means
    Bias_Estimation_C = zeros(m,n);
    Bias_Estimation_C_sq = zeros(m,n);
    for i=1:K
        current_mem=U(:,:,i);
        current_mem=current_mem.^q;
        num=sum(sum(mask.*(current_mem).*input.*convBias));
        den=sum(sum(mask.*(current_mem).*convBiasSq));
        C(i)=num/den;
        Bias_Estimation_C=Bias_Estimation_C+(mask.*(U(:,:,i).^q))*C(i);
        Bias_Estimation_C_sq=Bias_Estimation_C_sq+(mask.*(U(:,:,i).^q))*C(i)^2;
    end
    
%% finding bias field
garbage=conv2(input.*Bias_Estimation_C,weights,'same')./conv2(mask.*Bias_Estimation_C_sq,weights,'same');
temp(mask>0)=garbage(mask>0);
Bias_Field=temp;
%% Computing Objective Function
    %% finding djk
    convBias = conv2((Bias_Field), weights,'same');
    convBiasSq = conv2((Bias_Field).^2, weights,'same');
    for i=1:K
        D(:,:,i)=mask.*(input.^2+(C(i)^2).*convBiasSq-2*C(i).*(input.*convBias)+2.2204e-16); 
    end
    Raised_D=(D.^(1/(-q+1)));
    Raised_D_Sum=sum((mask_3.*Raised_D),3);
%% finding memberships

    for i=1:K
        garbage=mask.*(Raised_D(:,:,i)./(Raised_D_Sum));
        temp(mask>0)=garbage(mask>0);
        U(:,:,i)=temp;
    end   
    
   Sum_Objective=zeros(m,n);

    for i=1:K
        Sum_Objective=Sum_Objective+(U(:,:,i).^q).*D(:,:,i).*mask;
    end
    currObj=sum(sum(Sum_Objective));
    if (abs(currObj-prevObj)/abs(currObj)<0.001 || iter>=200)
        converged=true;     
    end
    values = [values log(abs(currObj))];

    prevObj=currObj;
end

bias_removed = mask.*(C(1)*U(:, :, 1) + C(2)*U(:, :, 2) + C(3)*U(:, :, 3));
residual = imageData - bias_removed.*Bias_Field;
%% Outputting things to file
M=max([max(residual(:)),max(bias_removed(:)),max(input(:)),max(Bias_Field(:))]);
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(input/M);
title(['Corrupted Image of brain']);
saveas(fig,['../images/Corrupted Image','.jpg'],'jpg');
close(fig);
% Outputting Membership Estimates
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(U(:,:,1));
title(['Memmbership for first class with q=' ,num2str(q)]);
saveas(fig,['../images/Membership estimates for first class with q ',num2str(q),'.jpg'],'jpg');
close(fig);
% Outputting Membership Estimates
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(U(:,:,2));
title(['Memmbership for second class with q=' ,num2str(q)]);
saveas(fig,['../images/Membership estimates for second class with q ',num2str(q),'.jpg'],'jpg');
close(fig);
% Outputting Membership Estimates
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(U(:,:,3));
title(['Memmbership for third class with q=' ,num2str(q)]);
saveas(fig,['../images/Membership estimates for third class with q ',num2str(q),'.jpg'],'jpg');
close(fig);
% Outputting Initial MemberShip Estimates
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mask.*(ones(m,n)/K));
title(['Initial membership estimates' ,num2str(q)]);
saveas(fig,['../images/Initial Membership Estimates for ',num2str(q),'.jpg'],'jpg');
close(fig);

% Outputting Bias Field Estimates
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow((Bias_Field.*mask)/M);
title(['Bias Field Estimates with q= ' ,num2str(q)]);
saveas(fig,['../images/Bias field estimates with q ',num2str(q),'.jpg'],'jpg');
close(fig);
% Outputting Bias Removed Image
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow((bias_removed)/M);
title(['Bias removed image with q= ' ,num2str(q)]);
saveas(fig,['../images/Bias removed image with q ',num2str(q),'.jpg'],'jpg');
close(fig);
% Outputting Residual Image
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow((residual)/M);
title(['Residual image with q= ' ,num2str(q)]);
saveas(fig,['../images/Residual image with q ',num2str(q),'.jpg'],'jpg');
close(fig);

% Plotting Value of Objective Function
 fig=figure;set(gcf, 'Position', get(0,'Screensize')); 
 plot(1:1:length(values),values); title(['Variation of Objective Function with iterations for q = ' ,num2str(q)]);
 saveas(fig,['../images/Variation of Objective Function for q = ',num2str(q),'.jpg'],'jpg');
 close(fig)
