function [ P_bd ,Detector_Mask,R] = myP_bd_Calculator( Resolution,N )
Grid_x_start=-Resolution;Grid_x_end=-Grid_x_start;Grid_y_start=Grid_x_start;Grid_y_end=Grid_x_end;
[X,Y] = meshgrid(Grid_x_start:Grid_x_end,Grid_y_start:Grid_y_end);
R=sqrt(Grid_y_end.^2+Grid_x_end.^2)/sqrt(2);% Radius of CT Scanner
Theta_S=2*pi/N;
P_bd=zeros([size(X) N]);
for k=1:N
            x_start=R*cos((k-1)*Theta_S); y_start=R*sin((k-1)*Theta_S);
            x_final=R*cos((k)*Theta_S); y_final=R*sin((k)*Theta_S);
            a=sqrt((x_final-X).^2+(y_final-Y).^2);
            b=sqrt((x_start-X).^2+(y_start-Y).^2);
            c=sqrt((x_final-x_start).^2+(y_final-y_start).^2);
            arg=(a.^2+b.^2-c.^2)./(2*a.*b);
            angle=acos(arg);
            P_bd(:,:,k)=angle;
            %[i,j,k]
end 
Detector_Mask=ones(2*Resolution+1,2*Resolution+1);
Distance=X.^2+Y.^2;
Detector_Mask(Distance>=R^2)=0;
Normalisation=sum(P_bd,3);
for k=1:N
    temp=(P_bd(:,:,k)./Normalisation).*Detector_Mask;
    temp(Detector_Mask==0)=0;
    P_bd(:,:,k)=temp;
end

end

