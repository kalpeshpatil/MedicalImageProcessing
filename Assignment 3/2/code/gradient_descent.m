%gradient descent script


%load('assignmentImageReconstructionBrain.mat');


while (~converged )
   [prior,prior_penalty] = prior_calculator(Current_Iterative_Image,prior_type,gamma);
    likelihood = ifft2(mask.*fft2(Current_Iterative_Image) - mask.*kSpaceData);
    Checker_Current = Current_Iterative_Image - 2*s*((1-alpha)*likelihood+(alpha)*(prior));
    %note: Xi-yi is the likelihood term
    checker_objective = (1-alpha)*(sum(sum(abs(imageKspaceMask.*fft2(Checker_Current)-(kSpaceData)).^2)))+(alpha)*(sum(sum(abs(prior_penalty))));
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
    
    if(s<1e-10)
        converged = true;
    end
  
end
    