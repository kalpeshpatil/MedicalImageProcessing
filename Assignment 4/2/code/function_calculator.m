function [out] = function_calculator(in,beta)
out=zeros(size(in));
out(abs(in)>0)=beta; 

end

