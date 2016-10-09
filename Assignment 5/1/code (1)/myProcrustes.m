function [r_mat,z_trf] = myProcrustes( z_mean,z_temp )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    y = z_mean';
    x = z_temp';
    y = y./norm(y,'fro');
    x = x./norm(x,'fro');  
    [U,sigma,V] = svd(x*y');
    R = U*V';
    if(det(R) > 0.1) 
        r_mat = R;
    else 
        M = eye(2);
        [p,q] = size(M);
        M(p,q)= -1;
        r_mat = V*M*U';
    end
    
    z_trf = r_mat'*x;
    
end

