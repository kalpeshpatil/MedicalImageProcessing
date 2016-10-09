% Run time of Program is 13.26 sec on windows 10 system with i5 processor 
clc
clear all 
close all
tic;
% Loading phantom image
InputImage = phantom(128);
% Choosing differet values of Delta
Delta_s_array = [0.5,1,3];

% For loop for different delta settings.
for i = 1:3
[OutputImage,xp,theta] = myRadonTrans(InputImage, Delta_s_array(i));
% theta = 0:5:175;
% [OutputImage,xp] = radon(InputImage);
fig = figure;
imagesc(theta,xp,OutputImage);
title(['delta\_s = ',num2str(Delta_s_array(i))]);
xlabel('\theta (degrees)');
ylabel('X\prime');
set(gca,'XTick',0:20:180);
colormap(hot);
colorbar
axis on;
saveas(fig,['../images/RaedonTf_',num2str(Delta_s_array(i)),'.jpg'],'jpg');
fig = figure; 
plot(xp,OutputImage(:,1)); title(['1D function: R_{0^o} (x\prime) delta\_s :',num2str(Delta_s_array(i))]);
saveas(fig,['../images/1D_0deg delta_s_',num2str(Delta_s_array(i)),'.jpg'],'jpg');
fig = figure; 
plot(xp,OutputImage(:,19)); title(['1D function:R_{90^o} (x\prime) delta\_s :',num2str(Delta_s_array(i))]);
saveas(fig,['../images/1D_90deg delta_s_',num2str(Delta_s_array(i)),'.jpg'],'jpg');
end
toc;





