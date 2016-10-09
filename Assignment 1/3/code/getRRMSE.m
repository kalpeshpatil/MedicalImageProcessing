function [output] = getRRMSE( in1, in2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
 
  Nr = sum(sum((mat2gray(in1) - mat2gray(in2)).^2));
  Dr = sum(sum((mat2gray(in1)).^2));
  
  output = sqrt(Nr)/sqrt(Dr) ;
  


end

