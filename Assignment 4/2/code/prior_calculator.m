function [ penalty ] = prior_calculator(in,beta)

downShift = -circshift(in,1)+in;
upShift = -circshift(in,-1)+in;
rightShift = -(circshift(in',1))'+in;
leftShift = -(circshift(in',-1))'+in;

penalty = function_calculator(downShift,beta);
penalty = penalty + function_calculator(upShift,beta);
penalty = penalty + function_calculator(rightShift,beta);
penalty = penalty + function_calculator(leftShift,beta);

end

