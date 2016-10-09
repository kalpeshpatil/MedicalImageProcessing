function [ output ] = myIntegration( Input_Image, t, Theta, Delta_s )
[Length,Width] = size(Input_Image);
% Assume image in -Xmax:Xmax and -Ymax:Ymax as requied by Interp function.
Xmax = (Length+1)/2;
Ymax = (Width+1)/2;

dist1 = (t*cos((pi*(Theta/180)))+Xmax)/(sin((pi*(Theta/180))));
dist2 = (t*cos((pi*(Theta/180)))-Xmax)/sin((pi*(Theta/180)));
dist3 = (-t*sin((pi*(Theta/180)))-Ymax)/cos((pi*(Theta/180)));
dist4 = (-t*sin((pi*(Theta/180)))+Ymax)/cos((pi*(Theta/180)));
        
if Theta==0 || Theta==180
   s_low = -Ymax; s_high = Ymax;
elseif Theta>0 && Theta<90
   s_low = max(dist3,dist2);s_high = min(dist1,dist4);
elseif Theta==90
   s_low = -Xmax; s_high = Xmax;
else
    s_low = max(dist4,dist2);
    s_high = min(dist1,dist3);
end

% Following arrangement is to account for Origin.
 [X, Y] = meshgrid(-Xmax+1:Xmax-1, -Ymax+1:Ymax-1);
s_range = double(s_low):Delta_s:double(s_high);
x_line = t*cos((pi*(Theta/180))) - s_range*sin((pi*(Theta/180)));
y_line = t*sin((pi*(Theta/180))) + s_range*cos((pi*(Theta/180)));
temp = interp2(X, Y, Input_Image, x_line, y_line, 'linear', 0);
output = sum(temp);

end

