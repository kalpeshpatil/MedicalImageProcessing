function [U_Labels ] = myNewEstimate_Image_Labels( X_labels,Y,Beta,Means,Sigma_2,mask)
O=myObjective_Function_Calculator(Y, X_labels,Means,Sigma_2,Beta,mask);
U_Labels=X_labels.*mask;
Labels=zeros([size(X_labels) 3]);
Labels(:,:,1)=myEstimator(Y,Means,Sigma_2,X_labels,1,mask,Beta);
Labels(:,:,2)=myEstimator(Y,Means,Sigma_2,X_labels,2,mask,Beta);
Labels(:,:,3)=myEstimator(Y,Means,Sigma_2,X_labels,3,mask,Beta);

[Garbage,U_Labels]=min(Labels,[],3);
U_Labels(mask==0)=0;


% for i=1:size(X_labels,1)
%     for j=1:size(X_labels,2)
%         Y_1=X_labels;Y_2=X_labels;Y_3=X_labels;
%         
%         if(X_labels(i,j)==1)
%             Y_2(i,j)=2; Y_3(i,j)=3;
%             O_2=myObjective_Function_Calculator(Y, Y_2,Means,Sigma_2,Beta,mask);
%             O_3=myObjective_Function_Calculator(Y, Y_3,Means,Sigma_2,Beta,mask);
%             if(O_2<O & O_2<O_3)
%                 U_Labels(i,j)=2;
%             end 
%             if(O_3<O & O_3<O_2)
%                 U_Labels(i,j)=3;
%             end 
%         end
%          if(X_labels(i,j)==2)
%             Y_1(i,j)=1; Y_3(i,j)=3;
%             O_1=myObjective_Function_Calculator(Y, Y_1,Means,Sigma_2,Beta,mask);
%             O_3=myObjective_Function_Calculator(Y, Y_3,Means,Sigma_2,Beta,mask);
%             if(O_1<O & O_1<O_3)
%                 U_Labels(i,j)=1;
%             end 
%             if(O_3<O & O_3<O_1)
%                 U_Labels(i,j)=3;
%             end 
%          end
%           if(X_labels(i,j)==3)
%             Y_1(i,j)=1; Y_2(i,j)=2;
%             O_2=myObjective_Function_Calculator(Y, Y_2,Means,Sigma_2,Beta,mask);
%             O_3=myObjective_Function_Calculator(Y, Y_1,Means,Sigma_2,Beta,mask);
%             if(O_1<O & O_1<O_2)
%                 U_Labels(i,j)=1;
%             end 
%             if(O_2<O & O_2<O_1)
%                 U_Labels(i,j)=2;
%             end 
%           end
%           [i,j]
%     end 
% end 
U_Labels=mask.*U_Labels;
end

% Y_2_2_3=(X_labels);
% Y_3_2_3=(X_labels);
% 
% Y_1_3_3=(X_labels);
% Y_1_1_3=(X_labels);
% 
% Y_1_2_2=(X_labels);
% Y_1_2_1=(X_labels);
% 
% Y_2_2_3(X_labels==1)=2;
% Y_3_2_3(X_labels==1)=3;
% 
% O_2_2_3=myObjective_Function_Calculator(Y, Y_2_2_3,Means,Sigma_2,Beta);
% O_3_2_3=myObjective_Function_Calculator(Y,Y_3_2_3,Means,Sigma_2,Beta);
% U_Labels((O_2_2_3<O_3_2_3 & O_2_2_3<O_1_2_3& X_labels==1))=2;
% U_Labels((O_3_2_3<O_2_2_3 & O_3_2_3<O_1_2_3& X_labels==1))=3;
% 
% 
% Y_1_3_3(X_labels==2)=3;
% Y_1_1_3(X_labels==2)=1;
% O_1_3_3=myObjective_Function_Calculator(Y, Y_1_3_3,Means,Sigma_2,Beta);
% O_1_1_3=myObjective_Function_Calculator(Y,Y_1_1_3,Means,Sigma_2,Beta);
% U_Labels((O_1_3_3<O_1_1_3 & O_1_3_3<O_1_2_3& X_labels==2))=3;
% U_Labels((O_1_1_3<O_1_3_3 & O_1_3_3<O_1_2_3& X_labels==2))=1;
% 
% Y_1_2_1(X_labels==3)=1;
% Y_1_2_2(X_labels==3)=2;
% O_1_2_1=myObjective_Function_Calculator(Y, Y_1_2_1,Means,Sigma_2,Beta);
% O_1_2_2=myObjective_Function_Calculator(Y,Y_1_2_2,Means,Sigma_2,Beta);
% U_Labels((O_1_2_1<O_1_2_2 & O_1_2_1<O_1_2_3& X_labels==3))=1;
% U_Labels((O_1_2_2<O_1_2_1 & O_1_2_2<O_1_2_3& X_labels==3))=2;


