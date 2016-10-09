clc
clear all
close all

% Read the DataSet
in = load('assignmentShapeAnalysis.mat');
in = in.pointSets;
[n_d,n_points,n_shapes] = size(in);
% Plotting Shapes with random set of colors
 fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
 for k = 1:n_shapes
 plot(in(1,:,k),in(2,:,k),'--','LineWidth',0.1,'color',rand(1,3));
 hold all
 end
  title('Input pointsets');
saveas(fig,['../images/Input Pointset','.jpg'],'jpg');
close(fig);
  
% Normalising shapes to make scale factor=1 and shifting centrod to 0;
for k=1:n_shapes
    for j=1:n_d
     in(j,:,k) = in(j,:,k) - mean(in(j,:,k));
    end
     in(:,:,k) = in(:,:,k)./norm(in(:,:,k),'fro');     
end    

% Computation of mean
 curr_mean = in(:,:,1);
 curr_data = in;
 scale = zeros(1,n_shapes);
 t_mat = zeros(n_points,n_d,n_shapes);
 r_mat = zeros(n_d,n_d,n_shapes);
 obj = Inf;
 thresh = 10e-8;
 while(obj >thresh)    
     prev_mean = curr_mean;
     % Alligning shape to current mean
     for k = 1:n_shapes
         temp_shape = in(:,:,k);
         [r_mat,transformed_shape] = myProcrustes(curr_mean',temp_shape');      
         curr_data(:,:,k) = transformed_shape;         
     end    
    % Computing mean
     for i = 1:n_d
         for j = 1:n_points
            curr_mean(i,j) = mean(curr_data(i,j,:)); 
         end
     end 
     % Redundant calculation to make it's centroid and scale =1 but doing
     % it for safety
     for k=1:n_shapes
         for j = 1:n_d
         curr_data(j,:,k) = curr_data(j,:,k) - mean(curr_data(j,:,k));
         end
         curr_data(:,:,k) = curr_data(:,:,k)./norm(curr_data(:,:,k),'fro');     
     end  
     
     for k=1:n_d
     curr_mean(k,:) = curr_mean(k,:) - mean(curr_mean(k,:));
     end
     curr_mean = curr_mean./norm(curr_mean,'fro');%(Projected Gradient Descent)
     
     in = curr_data;
     obj = norm(curr_mean - prev_mean);
 end
 % Plotting All means
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
for k=1:n_shapes
    plot(in(1,:,k),in(2,:,k),'--','LineWidth',0.1,'color',rand(1,3));
    hold all
 end
 hold on;
 plot(curr_mean(1,:),curr_mean(2,:),'-','LineWidth',3,'color','black');
 title('The Aligned Pointsets and mean shape');
 saveas(fig,['../images/Alligned pointsets and mean shape','.jpg'],'jpg');
close(fig);
 
% covariance matrix which is stored below
 cov_mat = zeros(n_d*n_points,n_points*n_d);
 Vec_Mean=reshape(curr_mean,[n_d*n_points,1]);
 for k=1:n_shapes
            
         % Computing variance over shapes 
        cov_mat(:,:) = squeeze(cov_mat(:,:)) + (reshape(in(:,:,k),[n_d*n_points,1]) - Vec_Mean)*(reshape(in(:,:,k),[n_d*n_points,1]) - Vec_Mean)';
     
 end    
 
 % Sample variance so dividing by n-1;
 cov_mat = cov_mat./(n_shapes - 1);
 
 % Performing PCA over covariance matrix to get principal mode of variation

 [V, D] = eig(squeeze(cov_mat(:,:)));
 
 V=fliplr(V);% Precisely because eigen values were in ascending order
 
 
lambda = fliplr((diag(D))');% Precisely because eigen values were in ascending order

 
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
 plot(lambda,'b');
 title('Eigenvalues')
 saveas(fig,['../images/Eigenvalues','.jpg'],'jpg');
close(fig);

 
 % Computing modes of variation by adding scaled eigenvectors
 mode1=Vec_Mean+2*(lambda(1)^0.5)*V(:,1);
 mode2=Vec_Mean-2*(lambda(1)^0.5)*V(:,1);
 
 mode1=reshape(mode1, [n_d,n_points]);
 mode2=reshape(mode2, [n_d,n_points]);
 
  for k=1:n_d
     mode1(k,:) = mode1(k,:) - mean(mode1(k,:));
     mode2(k,:) = mode2(k,:) - mean(mode2(k,:));
  end
     mode1 = mode1./norm(mode1,'fro');
     mode2 = mode2./norm(mode2,'fro');    
 
 fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
 for k =1:n_shapes
 plot(in(1,:,k),in(2,:,k),'*','LineWidth',0.1,'color',rand(1,3));
 hold all;
 end
 
h1= plot(curr_mean(1,:),curr_mean(2,:),'-','LineWidth',3,'color','r');
  hold on;
 h2=plot(mode1(1,:),mode1(2,:),'-','LineWidth',3,'color','y');
  hold on;
 h3=plot(mode2(1,:),mode2(2,:),'-','LineWidth',3,'color','k');
 legend([h1,h2 ,h3 ],'Mean','Mean+2SD','Mean-2SD');
 title('2 modes of variation and aligned dataset');
 saveas(fig,['../images/Modes of variation and aligned dataset','.jpg'],'jpg');
close(fig);