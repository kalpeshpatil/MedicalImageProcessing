function [ del_s ] =gradient_calculator(S_real,g,L_mat,b0,N);

del_s = zeros(2);

for i=1:N
    g1 = g(i,1);
    g2 = g(i,2);
    Estimate = exp(-b0*g(i,:)*L_mat*L_mat'*g(i,:)');
    Error = Estimate*(-2*b0*(Estimate-S_real(i)));
    del_s(1,1) = del_s(1,1) + Error*(g1^2*L_mat(1,1) + g1*g2*L_mat(2,1));
    del_s(2,1) = del_s(2,1) + Error*(g1*g2*L_mat(1,1) + g2^2*L_mat(2,1));
    del_s(2,2) = del_s(2,2) + Error*g2^2*L_mat(2,2);
end


end

