alpha=logspace(-1,0,12);
gamma=logspace(-2,0,12);
Tuning_Disc=zeros(length(alpha), length(gamma));
prior_type='disc_adapt_function';

 for i = 1:length(alpha)
     for j=1:length(gamma)
        [Original, Achieved,Image]=myDenoiser(alpha(i),gamma(j),prior_type);
         Tuning_Disc(i,j)=Achieved;
         [i,j]
     end
 end 


% alpha=logspace(-1,0,12);
% 
% gamma=logspace(-2,0,12);
% Tuning_Huber=zeros(length(alpha), length(gamma));
% prior_type='huber';
% j=1;
%  for i = 1:length(alpha)
%      for j=1:length(gamma)
%         [Original, Achieved,Image]=myDenoiser(alpha(i),gamma(j),prior_type);
%          Tuning_Huber(i,j)=Achieved;
%          [i,j]
%      end
%  end 



alpha=logspace(-1,0,12);
gamma=logspace(-3,1,10);
Tuning_Quadratic=zeros(length(alpha), length(gamma));
prior_type='quadratic';
j=1;
for i = 1:length(alpha)
       [Original, Achieved,Image]=myDenoiser(alpha(i),gamma(j),prior_type);
        Tuning_Quadratic(i,j)=Achieved;
end
alpha_optimal=0.2310;
