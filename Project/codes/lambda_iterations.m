function [ lambda_curr ] = lambda_iterations(InputImage, Detector_Mask,P_bd,t,N_star )
lambda_image = ones(size(InputImage))*t;
lambda_image=lambda_image.*Detector_Mask;
lambda_curr = lambda_image;
iter_max = 2000;
S = size(P_bd);
threshold=0.001;
converged=false;
while(converged~=true)

    lambda_old = lambda_curr;
    ratio_sum = zeros(S(1),S(2));
    for k=1:S(3)
        num =  N_star(k).*P_bd(:,:,k);
        sum_p=lambda_old.*P_bd(:,:,k);
        sum_p(Detector_Mask==0)=0;
        den = sum(sum_p(:));
        temp=num./den;
        if (den==0)
            temp =zeros(size(num));
        end
        temp(Detector_Mask==0)=0;
        ratio_sum(Detector_Mask>0) = ratio_sum(Detector_Mask>0) + temp(Detector_Mask>0);
    end
    lambda_curr = lambda_old.*ratio_sum;
    lambda_curr(Detector_Mask==0)=0;
    
    nor=norm((lambda_curr-lambda_old),'fro')/norm(lambda_old,'fro');
    if(nor<threshold)
        converged = true;
    end
end
end