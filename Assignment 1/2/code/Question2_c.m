function [rrmse0,rrmse1,rrmse5 ] = Question2_c( Input_Image )

    S0 = Input_Image;
    mask = fspecial ('gaussian', 11, 1);
    S1 = conv2 (S0, mask, 'same');
    mask = fspecial ('gaussian', 51, 5);
    S5 = conv2 (S0, mask, 'same');
    
    theta_array = [0:3:177];
    
    [rad0, r_dist_0] = radon(S0, theta_array);
    [rad1, r_dist_1] = radon(S1, theta_array);
    [rad5, r_dist_5] = radon(S5, theta_array);

    wmax =pi;
    L = ((1:1:length(r_dist_0)).*pi/length(r_dist_0))./wmax;
    rrmse0 = zeros(length(L),1);
    rrmse1 = zeros(length(L),1);
    rrmse5 = zeros(length(L),1);
        
    for i = 1:length(L)
      ram_lak0 = myFilter(rad0,r_dist_0,L(i),'ram_lak');
      R0 = iradon(ram_lak0, theta_array,'none',1.0, 256);
      rrmse0(i) = getRRMSE(R0,S0);
    
      ram_lak1 = myFilter(rad1,r_dist_1,L(i),'ram_lak');
      R1 = iradon(ram_lak1, theta_array,'none',1.0, 256);
      rrmse1(i) = getRRMSE(R1,S1);
              
      ram_lak5 = myFilter(rad5,r_dist_5,L(i),'ram_lak');
      R5 = iradon(ram_lak5, theta_array,'none',1.0, 256);
      rrmse5(i) = getRRMSE(R5,S5);
    
    end
fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(L,rrmse0); title(['RRSME Variation for S0 Phantom']);
saveas(fig,['../images/Question2_c/RRSME_Plot_S0_Phantom_','.jpg'],'jpg');

fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(L,rrmse1); title(['RRSME Variation for S1 Phantom']);
saveas(fig,['../images/Question2_c/RRSME_Plot_S1_Phantom_','.jpg'],'jpg');

fig = figure;set(gcf, 'Position', get(0,'Screensize')); 
plot(L,rrmse5); title(['RRSME Variation for S5 Phantom']);
saveas(fig,['../images/Question2_c/RRSME_Plot_S5_Phantom_','.jpg'],'jpg');

    
end

