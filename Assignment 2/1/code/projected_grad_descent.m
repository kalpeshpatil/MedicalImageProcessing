function [D,D11_array,D12_array,D21_array,D22_array,obj_array] = projected_grad_descent(S_real,g,b0)

s=0.1;
del_s = zeros(2);
L_mat = [1,0;
         0,1];
L_mat_new = L_mat;
N = 6;
s = 0.1;
iter = 1;
obj = objective(S_real,g,L_mat,b0,N);
prev_obj = obj;
converged = false;
while(~converged)
 del_s = gradient_calculator(S_real,g,L_mat_new,b0,N);
 L_mat_new = L_mat - s*del_s;
 
 if(L_mat_new(1,1))<0
    L_mat_new(1,1) = 0;
 end
  if(L_mat_new(1,1))<0
    L_mat_new(1,1) = 0;
 end

 checker_obj = objective(S_real,g,L_mat_new,b0,N);

 if(checker_obj<prev_obj)
    s = s + 0.1*s;
    L_mat = L_mat_new;
    obj = checker_obj;
    prev_obj = obj;
    D = L_mat*L_mat';
    obj_array(iter) = obj;
    D11_array(iter) = D(1,1);
    D12_array(iter) = D(1,2);
    D21_array(iter) = D(2,1);
    D22_array(iter) = D(2,2);
    iter = iter + 1;
 else 
    s = 0.5*s;
 end

 if(s<1e-20)
 converged = true;
end
end



end

