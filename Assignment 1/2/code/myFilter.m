function [ output] = myFilter(radon_data, r_dist, L,filter_type)

theta_array = [0:3:177];
output = zeros(size(radon_data));

% Fourier transform will have below mentioned frequencies
freq_array = pi*linspace(-1,1,length(r_dist)); 

filter = abs(freq_array);
cutoff_freq = L*max(freq_array);
filter(abs(freq_array)>cutoff_freq)=0;


if(strcmp(filter_type,'ram_lak'))
    
end

if(strcmp(filter_type,'shepp_logan'))
    filter = filter.*sinc((0.5/(cutoff_freq*L)).*freq_array);
end

if(strcmp(filter_type,'cosine'))
    filter = filter.*cos((0.5*pi/(cutoff_freq*L)).*freq_array);
end

%finding fft and ifft
    for i = 1:length(theta_array)
        fft_theta = fftshift(fft(radon_data(:,i)));
        filtered_fft = filter'.*fft_theta;
        filtered_fft = ifftshift(filtered_fft);
        output(:,i)  = real(ifft(filtered_fft));
    end


end

