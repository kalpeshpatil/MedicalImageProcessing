function [ RRMSE_Original, RRMSE_Achieved,Current_Iterative_Image,objective_array ] =myMainScript(alpha,gamma,prior_type)
load('../data/assignmentImageReconstructionPhantom');
%initialization
%added
kSpaceData = imageKspaceData;
mask = imageKspaceMask;
%
InputImage = kSpaceData;
Current_Iterative_Image = ifft2(mask.*(InputImage)); % Guess of input image
Prev_Iteration_Image = ones(size(kSpaceData));
s = 0.1; %initial step size
i =1;
prev_objective = 10e90;
while (s>1e-20)
    [prior,prior_penalty] = prior_calculator(Current_Iterative_Image,prior_type,gamma);
    likelihood = ifft2(mask.*fft2(Current_Iterative_Image) - mask.*kSpaceData);
    Checker_Current = Current_Iterative_Image - 2*s*((1-alpha)*likelihood+(alpha)*(prior));
    %note: Xi-yi is the likelihood term
    checker_objective = (1-alpha)*(sum(sum(abs(mask.*((kSpaceData)-(fft2(Checker_Current)))).^2)))+(alpha)*(sum(sum(abs(prior_penalty))));
  
    if(checker_objective < prev_objective)
        prev_objective=checker_objective;
        Current_Iterative_Image = Checker_Current;
        
        s = s + 0.1*s;
        objective=checker_objective;
        objective_array(i) = objective;
        i = i + 1;
 
    else
        s = s/2;
    end
    
    
    RRMSE_Iteration=getRRMSE(abs(imageNoiseless),abs(Current_Iterative_Image));
end
%imshow(mat2gray(abs(Current_Iterative_Image)));
RRMSE_Original=(getRRMSE(abs(imageNoiseless), abs(ifft2(mask.*(kSpaceData)))));
RRMSE_Achieved=(getRRMSE(abs(imageNoiseless), abs(Current_Iterative_Image)));
end



