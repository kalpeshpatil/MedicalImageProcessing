Hi,
You can find functions and myMainScript along with run time (mentioned as comment in myMainScript file). Question 2's separate parts are made as seprate function which can act on their own, as files in the code folder make it clear. 

Regarding Images, each part a,b,c have seprate folder in "images" folder of this question. Folder names being "Question2_a", "Question2_b", "Question2_c"


File Name format for "Question2_a"
"Input" correspond to Input Phantom
"Iradon_Output" correspond to Plane Back Projection

For Different window and cutoff frequency iradon output images have following name format.
"Iradon_Output_<Filter_Type>_value(L)" 
While Radon Transform have following name format.
"RadonTransform_Phanton_<Filter_Type>_value(L)"
L takes value 1,0.5 depending upon cutoff frequency being L=wmax or L=wmax/2. Also Filter_Type takes values "cosine", "Ram_Lak", "shepp_logan"


File Name format for "Question2_b"
InputImage Filename have following format.
"Iradon_Input_<Image_Identifier>_Phantom_value(RRMSE)"
Output Reconstructed Image Filename have following format.
"Iradon_Output_<Output_Image_Identifier>_Phantom_value(RRMSE)"
Radon Transform Filename have following format.
"RadonTransform_<Output_Image_Identifier>_Phantom_value(RRMSE)"


File Name format for "Question2_c
Plot filename have following format.
"RRSME_Plot_<Image_Identifier>_Phantom_"

In all of the above cases following notions are adopted.
Output_Image_Identifier takes values "R0, "R1", "R5" while Image_Identifier takes values "S0", "S1", "S5".
while RRMSE stand for "Relative Room Mean Square Error"
