function [ penalty ] = myPrior(in,k,mask,beta)
Current=k.*ones(size(in));
downShift = -circshift(in,1)+Current;
upShift = -circshift(in,-1)+Current;
rightShift = -(circshift(in',1))'+Current;
leftShift = -(circshift(in',-1))'+Current;

penalty = function_calculator(downShift,beta);
penalty = penalty + function_calculator(upShift,beta);
penalty = penalty + function_calculator(rightShift,beta);
penalty = penalty + function_calculator(leftShift,beta);

penalty=exp(-penalty);
penalty=penalty.*mask;
end

