function [output] = getRRMSE( in1, in2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 x=abs(mat2gray(in1) - mat2gray(in2));
 y=abs(mat2gray(in1));
 x=x.^2;
 y=y.^2;
  Nr =sum(x(:));
  Dr = sum(y(:));
  
  output = sqrt(Nr)/sqrt(Dr) ;
  


end

