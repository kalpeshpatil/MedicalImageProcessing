function [ output ] = myIntegration( Input_Image, t, Theta, Delta_s )
[Length,Width] = size(Input_Image);
% Assume image in -Xmax:Xmax and -Ymax:Ymax as requied by Interp function.
Xmax = (Length+1)/2;
Ymax = (Width+1)/2;

% Below mentioned computation is done to compute range of 's'
dist1 = min((t*cos(Theta)-Xmax)/sin(Theta), (t*cos(Theta)+Xmax)/sin(Theta));
dist2 = min((-t*sin(Theta)-Ymax)/cos(Theta), (-t*sin(Theta)+Ymax)/cos(Theta));
dist3 = max((t*cos(Theta)-Xmax)/sin(Theta), (t*cos(Theta)+Xmax)/sin(Theta));
dist4 = max((-t*sin(Theta)-Ymax)/cos(Theta), (-t*sin(Theta)+Ymax)/cos(Theta));

if(Theta == 0)||(Theta==pi)
    s_low = -Ymax; s_high = Ymax;
else if (Theta == pi/2)
    s_low = -Xmax; s_high = Xmax;
    else
        s_low = max(dist1,dist2);
        s_high = min(dist3,dist4);
    end
end

output = 0;
% Following arrangement is to account for Origin.
 [X, Y] = meshgrid(-Xmax+1:Xmax-1, -Ymax+1:Ymax-1);
 
 for s=s_low:Delta_s:s_high
        x_line = t*cos(Theta) - s*sin(Theta);
        y_line = t*sin(Theta) + s*cos(Theta);
        temp = interp2(X, Y, Input_Image, x_line, y_line, 'linear', 0);
        output = output + Delta_s*temp;
 end


end

