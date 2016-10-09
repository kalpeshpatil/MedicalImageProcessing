InputImage=imread('../logo.png');
InputImage=mat2gray(InputImage);
InputImage=1-InputImage;
O_Size=16;
ReadImage=imresize(InputImage,[2*O_Size,2*O_Size]);
N=80;% Number of Detectors
t=2000000;% Sampling Time

Resolution=32;
Grid_x_start=-Resolution;Grid_x_end=-Grid_x_start;Grid_y_start=Grid_x_start;Grid_y_end=Grid_x_end;
[X,Y] = meshgrid(Grid_x_start:Grid_x_end,Grid_y_start:Grid_y_end);
Grid_x_start=-O_Size;Grid_x_end=O_Size-1;Grid_y_start=Grid_x_start;Grid_y_end=Grid_x_end;

[P_bd,Detector_Mask,R]=myP_bd_Tube_Calculator( Resolution,N );
InputImage=zeros(2*Resolution+1,2*Resolution+1);
%InputImage((X>=Grid_x_start )&& (X<=Grid_x_end) && (Y>=Grid_y_start) && (Y<=Grid_y_end))=ReadImage;
w=(X>=Grid_x_start );x=(X<=Grid_x_end);y=(Y>=Grid_y_start);z=(Y<=Grid_y_end);
Ind=w.*x.*y.*z;
InputImage((Ind==1))=ReadImage(:);
InputImage(Ind==0)=0;
% Generation of Data 
Data_Matrix=zeros([size(InputImage) size(P_bd,3)]);
N_star=zeros(1,size(P_bd,3));


for i=1:size(InputImage,1)
for j=1:size(InputImage,2)
       if(InputImage(i,j)>0)
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
       end
end
end
%% Expectaation Maximisation
[ lambda_curr ] = lambda_iterations(InputImage, Detector_Mask,P_bd,t,N_star );
lambda_inversion;

%% Outputting Files
OutputImage=mat2gray(lambda_curr);
OutputImage(Detector_Mask==0)=1;
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow((OutputImage),'InitialMagnification','fit')
title(['logo\_EM']);
saveas(fig,['../images/logo_EM','.jpg'],'jpg');
close(fig);
OutputImage=inverted_image;
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow((OutputImage),'InitialMagnification','fit')
title(['logo\_Inversion']);
saveas(fig,['../images/logo_Inversion','.jpg'],'jpg');
close(fig);

InputImage(Detector_Mask==0)=1;
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
imshow(mat2gray(InputImage),'InitialMagnification','fit')
title(['logo\_input']);
 saveas(fig,['../images/logo_input','.jpg'],'jpg');close(fig);