% Run time of Program is 53.07 sec on windows 10 system with i5 processor 
clc
close all
tic;
Input_Image = phantom(256);
[out0, out1a, out1b, out2a, out2b, out3a, out3b] = Question2_a(Input_Image);
close all
[S0, S1, S5, R0, R1, R5, rrmse_array ] = Question2_b(Input_Image);
close all
[rrmse0,rrmse1,rrmse5] = Question2_c(Input_Image);
close all
toc;