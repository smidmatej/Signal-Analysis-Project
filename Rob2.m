function [yrob] = Rob2(y,F1,F2,r,Fs)

    t = (0:length(y)-1)/Fs;
    yrob = real(y .* (r*exp(-i*2*pi*t*F1)' + (1-r)*exp(-i*2*pi*t*F2)'));
end

