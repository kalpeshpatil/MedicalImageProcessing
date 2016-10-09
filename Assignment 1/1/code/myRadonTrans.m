function [Output,t_array,Theta_array] = myRadonTrans(Input_Image, Delta_s)
    
    t_array = [-90:5:90]';
    Theta_array = [0:5:175]';
    Size_Theta = size(Theta_array);
    Size_t = size(t_array);
    Output = zeros(Size_t(1), Size_Theta(1));
    
    

for i=1:Size_Theta(1)
    for j=1:Size_t(1)
        Output(j, i) = myIntegration(Input_Image, t_array(j), Theta_array(i), Delta_s);
    end
end
    
    
end

