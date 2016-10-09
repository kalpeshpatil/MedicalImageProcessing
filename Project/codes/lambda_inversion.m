%lambda_inversion

S2 = size(P_bd);
sz=length(find(Detector_Mask==1));
P_bd_new = zeros(sz,S2(3));
Indices=find(Detector_Mask==1);
for k = 1:S2(3)
    temp = P_bd(:,:,k);

    P_bd_new(:,k) = temp(Indices); 
end

P_bd_new_t = P_bd_new';

lambda_new = ((inv(P_bd_new_t'*P_bd_new_t))*P_bd_new_t')*N_star';
temp=zeros(size(Detector_Mask));
temp(Indices)=lambda_new;
temp=mat2gray(temp);
temp(Detector_Mask==0)=1;
inverted_image=temp;
% imshow(temp);