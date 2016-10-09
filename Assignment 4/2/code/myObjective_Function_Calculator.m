function [ Objective ] = myObjective_Function_Calculator(Y, X_labels,Means,Sigma_2,Beta,mask )
Sigma_2_Labels=zeros(size(X_labels));
Means_Labels=zeros(size(X_labels));
Means_Labels(X_labels==1)=Means(1);Means_Labels(X_labels==2)=Means(2);Means_Labels(X_labels==3)=Means(3);
Sigma_2_Labels(X_labels==1)=Sigma_2(1);Sigma_2_Labels(X_labels==2)=Sigma_2(1);Sigma_2_Labels(X_labels==3)=Sigma_2(1);
Likelihood_Penalty=((Y-Means_Labels).^2)./(2*Sigma_2_Labels);
Likelihood_Penalty(mask==0)=0;
Prior_Penalty=prior_calculator(X_labels,Beta);
Prior_Penalty(mask==0)=0;
Dummy=(Likelihood_Penalty.*mask+Prior_Penalty).*mask;
Objective=sum(Dummy(:));

end

