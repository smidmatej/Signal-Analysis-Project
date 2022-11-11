function [yrob] = Rob(y,Fc,Fs)

    t = (0:length(y)-1)/Fs;
    yrob = real(y .* exp(-i*2*pi*t*Fc)');
end

