while(~converged)
iter =iter +1;
[X_MAP,Initial,Final]= myMAP_Estimate(Y,Mu,Sigma_sq,Beta,mask,Current_Labels);
Initial_Array=[Initial_Array Initial];
Final_Array=[Final_Array Final];
D=zeros([m,n,K]);
    for i=1:K
        sigma=sqrt(Sigma_sq(i));
         Likelihood=normpdf(Y,Mu(i),sigma);
         Prior=myPrior(X_MAP,i,mask,Beta);
         D(:,:,i)=Likelihood.*Prior;
    end
 
    D_Sum=sum((mask_3.*D),3);
%% finding memberships
    temp=zeros(m,n);
    for i=1:K
        garbage=mask.*(D(:,:,i)./(D_Sum));
        temp(mask>0)=garbage(mask>0);
        U(:,:,i)=temp;
    end   
    
    %% Finding Estimates of Mean
   for i=1:K
       Mu(i)=sum(sum(U(:,:,i).*Y.*mask))/(sum(sum(U(:,:,i).*mask)));
   end
   %% Finding Estimates of Sigma
   for i=1:K
       Est=((Y-Mu(i)).^2).*U(:,:,i).*mask;
       Sigma_sq(i)=(sum(Est(:)))/(sum(sum(U(:,:,i).*mask)));
   end
   Parameters=[Mu' Sigma_sq'];
   Term=(Parameters-Parameters_Prev).^2;
   Den=Parameters_Prev.^2;
   Crit=sqrt(sum(Term(:))/sum(Den(:)));
   Current_Labels=X_MAP;
   if (Crit<0.001 || iter>=200)
        converged=true;     
   end
    Parameters_Prev=Parameters;
end
[X_MAP,Initial,Final]= myMAP_Estimate(Y,Mu,Sigma_sq,Beta,mask,Current_Labels);
Initial_Array=[Initial_Array Initial];
Final_Array=[Final_Array Final];