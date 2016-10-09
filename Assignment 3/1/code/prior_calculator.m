function [ update, penalty ] = prior_calculator(in,prior_type,gamma)

downShift = -circshift(in,1)+in;
upShift = -circshift(in,-1)+in;
rightShift = -(circshift(in',1))'+in;
leftShift = -(circshift(in',-1))'+in;

update = downShift.*function_calculator(downShift,prior_type,gamma,1);
update = update + upShift.*function_calculator(upShift,prior_type,gamma,1);
update = update + rightShift.*function_calculator(rightShift,prior_type,gamma,1);
update = update + leftShift.*function_calculator(leftShift ,prior_type,gamma,1);

penalty = downShift.*function_calculator(downShift,prior_type,gamma,0);
penalty = penalty + upShift.*function_calculator(upShift,prior_type,gamma,0);
penalty = penalty + rightShift.*function_calculator(rightShift,prior_type,gamma,0);
penalty = penalty + leftShift.*function_calculator(leftShift,prior_type,gamma,0);

end

