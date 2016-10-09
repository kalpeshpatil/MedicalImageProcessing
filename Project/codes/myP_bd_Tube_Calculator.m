function [ P_bd ,Detector_Mask,R] = myP_bd_Tube_Calculator( Resolution,N )
Grid_x_start=-Resolution;Grid_x_end=-Grid_x_start;Grid_y_start=Grid_x_start;Grid_y_end=Grid_x_end;
[X,Y] = meshgrid(Grid_x_start:Grid_x_end,Grid_y_start:Grid_y_end);
R=sqrt(Grid_y_end.^2+Grid_x_end.^2)/sqrt(2);% Radius of CT Scanner
Theta_S=(2*pi)/N;
P_bd=zeros([size(X) N*(N-1)/2]);
counter=1;
Detector_Mask=ones(2*Resolution+1,2*Resolution+1);
Distance=X.^2+Y.^2;
Detector_Mask(Distance>=R^2)=0;
for i=0:N-2
    for j=i+1:N-1
            x1_start=R*cos((i)*Theta_S); y1_start=R*sin((i)*Theta_S);
            x1_final=R*cos((i+1)*Theta_S); y1_final=R*sin((i+1)*Theta_S);
            x2_start=R*cos((j)*Theta_S); y2_start=R*sin((j)*Theta_S);
            x2_final=R*cos((j+1)*Theta_S); y2_final=R*sin((j+1)*Theta_S);
            a=sqrt((x1_final-X).^2+(y1_final-Y).^2);
            b=sqrt((x1_start-X).^2+(y1_start-Y).^2);
            c=sqrt((x1_final-x1_start).^2+(y1_final-y1_start).^2);
            arg=(a.^2+b.^2-c.^2)./(2*a.*b);
            angle1=abs(acos(arg));
            
            a=sqrt((x2_final-X).^2+(y2_final-Y).^2);
            b=sqrt((x2_start-X).^2+(y2_start-Y).^2);
            c=sqrt((x2_final-x2_start).^2+(y2_final-y2_start).^2);
            arg=(a.^2+b.^2-c.^2)./(2*a.*b);
            angle2=abs(acos(arg));
            Mask=inpolygon(X,Y,[x1_start x1_final x2_start x2_final],[y1_start y1_final y2_start y2_final]);
            Angle=min(angle1, angle2);
            Angle=Angle/pi;
            Angle(Mask==0)=0;
            P_bd(:,:,counter)=Angle;
            counter=counter+1;
            %[i,j,k]
    end
end 

Normalisation=sum(P_bd,3);
for k=1:N
    temp=(P_bd(:,:,k)./Normalisation).*Detector_Mask;
    temp(Detector_Mask==0)=0;
    P_bd(:,:,k)=temp;
end

end

