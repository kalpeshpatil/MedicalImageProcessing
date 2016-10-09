function [ Objective ] = myEstimator(Y,Means,Sigma_2,X_Labels,k,mask,beta)
Current=k.*ones(size(X_Labels));
downShift = -circshift(X_Labels,1)+Current;
upShift = -circshift(X_Labels,-1)+Current;
rightShift = -(circshift(X_Labels',1))'+Current;
leftShift = -(circshift(X_Labels',-1))'+Current;

Prior_penalty = function_calculator(downShift,beta);
Prior_penalty = Prior_penalty + function_calculator(upShift,beta);
Prior_penalty = Prior_penalty + function_calculator(rightShift,beta);
Prior_penalty = Prior_penalty + function_calculator(leftShift,beta);

Prior_penalty=Prior_penalty.*mask;

Sigma_2_Labels=zeros(size(X_Labels));
Means_Labels=zeros(size(X_Labels));
Means_Labels(:)=Means(k);
Sigma_2_Labels(:)=Sigma_2(k);
Likelihood_penalty=((Y-Means_Labels).^2)./(2*Sigma_2_Labels);
Likelihood_penalty(mask==0)=0;

Prior_penalty(mask==0)=0;
Dummy=(Likelihood_penalty.*mask+Prior_penalty).*mask;
Objective=Dummy;
end

