function [ Updated_Labels,Initial,Final ] =myMAP_Estimate(InputImage,ClassMeans, Class_Sigma_Sq,Beta,mask,Current_L)

 

% Getting initial guess using kmeans
Current_Labels=Current_L;
[m,n]=size(InputImage);

Initial=myObjective_Function_Calculator(InputImage, (Current_Labels.*mask),ClassMeans,Class_Sigma_Sq,Beta,mask);
prevObj = Initial;
iter=0;
converged=false;
while (~converged )
    iter=iter+1;
    Updated_Labels=myNewEstimate_Image_Labels((Current_Labels.*mask),InputImage,Beta,ClassMeans,Class_Sigma_Sq,mask);
    currObj=myObjective_Function_Calculator(InputImage, Updated_Labels.*mask,ClassMeans,Class_Sigma_Sq,Beta,mask);
    if (currObj<prevObj & iter<=200)
        converged=false;     
        Current_Labels=Updated_Labels;
        prevObj=currObj;
    else
        converged=true;
    end
    %values = [values log(abs(currObj))]; 
    
end
Final=myObjective_Function_Calculator(InputImage,Current_Labels.*mask,ClassMeans,Class_Sigma_Sq,Beta,mask);
Updated_Labels=mask.*Updated_Labels;

end



