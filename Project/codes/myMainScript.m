clc
close all
Resolution_Array=[16,8,4];
for i = 1:length(Resolution_Array)
    Resolution=Resolution_Array(i);
    myEstimate_Tube_Calculator(Resolution_Array(i) );
end
