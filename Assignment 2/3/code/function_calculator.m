function [out] = function_calculator(in,type,gamma,derivativeEn)
%finds prior update and penalty depending upon 
%type of prior and input parameters
out=zeros(size(in));
if (~derivativeEn)
    switch (type)
        case 'quadratic'
            out = abs(in).^2;            
        case 'huber'
            out(abs(in)<=gamma) = 0.5*abs(in(abs(in)<=gamma)).^2;
            out(abs(in)>gamma) = gamma*abs(in(abs(in)>gamma))-(gamma.^2/2);
        case 'disc_adapt_function'
             out = gamma*abs(in) - gamma^2 * log(1 + abs(in)./gamma);
    end 
else
    switch (type)
        case 'quadratic'
            out = ones(size(in));
        case 'huber'
                out(abs(in)<=gamma) = 0.5;
                out(abs(in)>gamma) = gamma./(2*abs(in(abs(in)>gamma)));
        case 'disc_adapt_function'
             out = gamma./(2*(abs(in) + gamma));
    end
end
end

