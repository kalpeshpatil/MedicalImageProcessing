function [noise_real, noise_imag ] = find_noise(in,x1,y1,x2,y2)
%   Detailed explanation goes here
   temp = in(x1:x2,y1:y2);
   noise_real = sqrt(var(real(temp(:))));
   noise_imag = sqrt(var(imag(temp(:))));

end

