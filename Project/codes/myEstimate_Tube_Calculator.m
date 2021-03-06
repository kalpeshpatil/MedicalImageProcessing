function [ N ] = myEstimate_Tube_Calculator(Resolution)

N=40;% Number of Detectors
t=2000000;% Sampling Time
[P_bd,Detector_Mask,R]=myP_bd_Tube_Calculator( Resolution,N );
Position_Array=2:1:(Resolution+1);

for o=1:length(Position_Array)  
Position=Position_Array(o);
[Resolution, Position]
InputImage=zeros(2*Resolution+1,2*Resolution+1);
InputImage( Position,Resolution+1)=1;
% Generation of Data 
Data_Matrix=zeros([size(InputImage) size(P_bd,3)]);
N_star=zeros(1,size(P_bd,3));

i=Position;j=Resolution+1;
for k=1:size(P_bd,3)
    pbd=P_bd(i,j,k);
    Intensity=InputImage(i,j);
    lambda_c=(P_bd(i,j,k))*InputImage(i,j);
    lambda=lambda_c*t;
    %Value=lambda;
    Value=poissrnd(lambda);
    Data_Matrix(i,j,k)=Value;
    N_star(k)=N_star(k)+Value;
end 
%% Expectaation Maximisation
[ lambda_curr ] = lambda_iterations(InputImage, Detector_Mask,P_bd,t,N_star );
lambda_inversion;


%% Outputting things to files
OutputImage=mat2gray(lambda_curr);
OutputImage(Detector_Mask==0)=1;

fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow((OutputImage),'InitialMagnification','fit')
 title(['Output Image of EM with Resolution ',num2str(Resolution), ' and Position ', num2str(Position)]);
 saveas(fig,['../images/EM/Output Image EM with Resolution',num2str(Resolution),' and Position ',num2str(Position),'.jpg'],'jpg');
close(fig);
OutputImage=inverted_image;
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow((OutputImage),'InitialMagnification','fit')
 title(['Output Image of Inversion with Resolution ',num2str(Resolution), ' and Position ', num2str(Position)]);
 saveas(fig,['../images/Inversion/Output Image Inversion with Resolution',num2str(Resolution),' and Position ',num2str(Position),'.jpg'],'jpg');
close(fig);

InputImage(Detector_Mask==0)=1;
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(InputImage),'InitialMagnification','fit')
 title(['Input Image with Resolution ',num2str(Resolution), ' and Position ', num2str(Position)]);
saveas(fig,['../images/Input/Input Image with Resolution',num2str(Resolution),' and Position ',num2str(Position),'.jpg'],'jpg');
close(fig);

end
end
