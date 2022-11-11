function [wahwah, fig] = wahwah(y, Fs, width, damping, min_cutoff, max_cutoff)

    center_freq = width/Fs;
    
    cutoff_freq=min_cutoff:center_freq:max_cutoff;
    while(length(cutoff_freq) < length(y) )
        cutoff_freq = [ cutoff_freq (max_cutoff:-center_freq:min_cutoff) ];
        cutoff_freq = [ cutoff_freq (min_cutoff:center_freq:max_cutoff) ];
    end
    
    cutoff_freq = cutoff_freq(1:length(y));
    
    

    
    F1 = 2*sin((pi*cutoff_freq(1))/Fs);
    Q1 = 2*damping;

    highpass=zeros(size(y));
    bandpass=zeros(size(y));
    lowpass=zeros(size(y));
    
    highpass(1) = y(1);
    bandpass(1) = F1*highpass(1);
    lowpass(1) = F1*bandpass(1);
    
    for n=2:length(y)
        highpass(n) = y(n) - lowpass(n-1) - Q1*bandpass(n-1);
        bandpass(n) = F1*highpass(n) + bandpass(n-1);
        lowpass(n) = F1*bandpass(n) + lowpass(n-1);
        F1 = 2*sin((pi*cutoff_freq(n))/Fs);
    end
    
    fig = figure('visible','off')
    plot((0:length(y)-1)/Fs, cutoff_freq)
    title('Cutoff frequency')
    
    wahwah = bandpass./max(max(abs(bandpass)));
end

