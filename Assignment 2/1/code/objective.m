function [obj ] =objective( S_real,g,L_mat,b0,N )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

obj = 0;
for i=1:N
   obj = obj + (exp(-b0*g(i,:)*L_mat*L_mat'*g(i,:)') - S_real(i))^2;
end


end

