%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Voicecoder : Main program which permit to :
%
% 1- modify the tempo (the speed of "prononciation")
%   without modifying the pitch (fundamental frequence of speaking)
%
% 2- modify the pitch without modifying the speed 
%
% 3- "robotize" a voice
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Audio signal recovery
%--------------------------------
clear all
close all
% [y,Fs]=audioread('sounds/Diner.wav');   %original signal
% [y,Fs]=audioread('sounds/Extrait.wav');   %original signal
[y,Fs]=audioread('sounds/Halleluia.wav');   %original signal
% [y,Fs]=audioread('sounds/magenta.mp3');   %original signal
% [y,Fs]=audioread('sounds/magenta_cut.mp3');   %original signal
[y_extra,Fs]=audioread('soundspaulhill2.wav');   %original signal
% Note: if the signal is in stereo, only process one channel at a time.
% time

% Make sure the Fs matches for them
y = y + y_extra(1:1000,1);
y = y(:,1);




Y = fft(y);
Y = fftshift(Y); % Swaps left and right side of Y so that is is centered around f=0
% Curves (evolution over time, spectrum and spectrogram)
%--------
Ts = 1/Fs;
f = (-length(y)/2:length(y)/2-1)*(Fs/length(y));     % frequency range
t = linspace(0,length(y)-1,length(y))*Ts;


figure("Name", "Original signal y")
subplot(1,3,1)
plot(t,y)
xlabel('Time')
ylabel('Amplitude')
subplot(1,3,2)
plot(f,abs(Y)/length(y))
xlabel('Frequency')
ylabel('Power')
subplot(1,3,3)
spectrogram(y,128,120,128,Fs,'yaxis');

% Don't forget to create the time and frequency vectors...
% TO DO !
% Ecoute
%-------
sound(y,Fs)

%%
%-------------------------------
% 1- SPEED MODIFICATION
% (without pitch modification)
%-------------------------------
% SLOWER
rapp = 2/3;   %can be modified
ylent = PVoc(y,rapp,1024); 

% Listen
%-------
sound(ylent,Fs)


% Courbes
%--------
% Plot slowed sound
Ylent = fft(ylent);
Ylent = fftshift(Ylent); % Swaps left and right side of Y so that is is centered around f=0
tlent = linspace(0,length(ylent)-1,length(ylent))*Ts;
% tlent = (0:(length(ylent)-1))*Ts % The same thing

flent = (-length(ylent)/2:(length(ylent)/2-1))/length(ylent)*Fs*rapp;
%flent = (-length(ylent)/2:length(ylent)/2-1)*(Fs/length(ylent));
figure("Name", "Slowed ylent")
subplot(1,3,1)
plot(tlent,ylent)
xlabel('Time')
ylabel('Amplitude')
subplot(1,3,2)
plot(flent,2*abs(Ylent)/length(y))
xlabel('Frequency')
ylabel('Power')
subplot(1,3,3)
spectrogram(ylent,128,120,128,Fs,'yaxis');

%% 

% FASTER
rapp = 3/2;   %can be modified
yrapide = PVoc(y,rapp,1024); 


% Listen 
%-------
sound(yrapide,Fs)

% Curves
%--------
% Plot slowed sound
Yrapide = fft(yrapide);
Yrapide = fftshift(Yrapide); % Swaps left and right side of Y so that is is centered around f=0
trapide = linspace(0,length(yrapide)-1,length(yrapide))*Ts;


frapide = (-length(yrapide)/2:(length(yrapide)/2-1))/length(yrapide)*Fs*rapp;
figure("Name", "Faster yrapide")
subplot(1,3,1)
plot(trapide,yrapide)
xlabel('Time')
ylabel('Amplitude')
subplot(1,3,2)
plot(frapide,2*abs(Yrapide)/length(y))
xlabel('Frequency')
ylabel('Power')
subplot(1,3,3)
spectrogram(yrapide,128,120,128,Fs,'yaxis');

%%
%----------------------------------
% 2- CHANGE PITCH
% (without speed modification)
%----------------------------------
% General settings:
%---------------------
% Number of points for FFT/IFFT
Nfft=256;

% Number of points (length) of the weighting window
% (by default Hanning window)
Nwind = Nfft;

% Increase
%--------------
a = 2; b=3; %can be changed
yvoc = PVoc(y, a/b, Nfft, Nwind);

% Resampling the time signal to keep the same speed
yvoc = resample(yvoc, a, b);


%Sum of original and modified signal
%Attention: we must take the same number of samples
%Note: you can put a coefficient on ypitch so that it
% intervenes + or - in the sum...

% Resample the original signal for better comparison
sum_sampling_rate = length(yvoc)/length(y);
[n,d] = rat(sum_sampling_rate);
y_compare = resample(y,n,d);
y_sum = y_compare(1:length(yvoc))-yvoc;

% Listen
%-------
sound(yvoc, Fs)

% Curves
%--------

Yvoc = fft(yvoc);
Yvoc = fftshift(Yvoc); % Swaps left and right side of Y so that is is centered around f=0
tvoc = linspace(0,length(yvoc)-1,length(yvoc))*Ts;

fup = (-length(yvoc)/2:(length(yvoc)/2-1))/length(yvoc)*Fs*a/b;
figure('Name', 'Pitch modificaton up')

subplot(2,3,1)
hold on
plot(tvoc, yvoc)
plot(tvoc, y_compare(1:length(yvoc)), '--')
xlabel('Time')
ylabel('Amplitude')
legend({'$y_{voc}$', '$y$'}, 'interpreter', 'latex' ,'Location', 'Best')

subplot(2,3,3+1)
plot(y_sum)
title('$y_{sum}$', 'interpreter', 'latex')
xlabel('Time')
ylabel('Amplitude')

subplot(2,3,[2 3+2])
plot(fup,abs(Yvoc).^2/length(y))
xlabel('Frequency')
ylabel('Power')
subplot(2,3,[3 3+3])
spectrogram(yvoc,128,120,128,Fs,'yaxis');




%%

%Decrease
%------------

a=3; b=2; %can be changed
yvoc = PVoc(y, a/b,Nfft,Nwind);


% Resampling the time signal to keep the same speed
yvoc = resample(yvoc, a, b);


%Sum of original and modified signal
%Attention: we must take the same number of samples
%Note: you can put a coefficient on ypitch so that it
% intervenes + or - in the sum...

% Resample the original signal for better comparison
% TODO: Document this in the report
% Because the phase interpolation leaves out some samples, we use this to
% find a closer match in the number of samples for comparing
sum_sampling_rate = length(yvoc)/length(y);
[n,d] = rat(sum_sampling_rate); % rational fraction approximation pi -> 22/7
y_compare = resample(y,n,d); % use the fraction to resaple original signal 
y_sum = y_compare(1:length(yvoc))-yvoc; % then do the comparison


% Listen
%-------
sound(yvoc, Fs)

% Curves
%--------


Yvoc = fft(yvoc);
Yvoc = fftshift(Yvoc); % Swaps left and right side of Y so that is is centered around f=0
tvoc = linspace(0,length(yvoc)-1,length(yvoc))*Ts;

fdown = (-length(yvoc)/2:(length(yvoc)/2-1))/length(yvoc)*Fs*a/b;
figure('Name', 'Pitch modificaton down')

subplot(2,3,1)
hold on
plot(tvoc, yvoc)
plot(tvoc, y_compare(1:length(yvoc)), '--')
xlabel('Time')
ylabel('Amplitude')
legend({'$y_{voc}$', '$y$'}, 'interpreter', 'latex' ,'Location', 'Best')

% TODO: y_sum is obviously not zero, that is because the interpolation is
% innacurace. Is it our fault or will it happen always?
subplot(2,3,3+1)
plot(y_sum)
title('$y_{sum}$', 'interpreter', 'latex')
xlabel('Time')
ylabel('Amplitude')

subplot(2,3,[2 3+2])
plot(fdown,abs(Yvoc).^2/length(y))
xlabel('Frequency')
ylabel('Power')
subplot(2,3,[3 3+3])
spectrogram(yvoc,128,120,128,Fs,'yaxis');


%%
%----------------------------
% 3- VOICE ROBOTIZATION
%-----------------------------
% Choice of carrier frequency (2000, 1000, 500, 200)

Fc = Fs/2/10
yrob = Rob(y,Fc,Fs);

% Listen 
%-------
sound(yrob,Fs)

% Curves
%--------
% Plot slowed sound
Yrob = fft(yrob);
Yrob = fftshift(Yrob); % Swaps left and right side of Y so that is is centered around f=0
trob = linspace(0,length(yrob)-1,length(yrob))*Ts;
frob = (-length(yrob)/2:(length(yrob)/2-1))/length(yrob)*Fs;

figure("Name", "Faster yrapide")
subplot(1,3,1)
plot(trob,yrob)
xlabel('Time')
ylabel('Amplitude')
subplot(1,3,2)
plot(frob,abs(Yrob).^2/length(yrob))
xlabel('Frequency')
ylabel('Power')
subplot(1,3,3)
spectrogram(yrob,128,120,128,Fs,'yaxis');

%%
%----------------------------
% 4- VOICE SATURATION
%-----------------------------

% Choose ratio of saturation r between 0 and 1
% r >= 1 does not do anything
% r = 0.5 saturates the sound at 50% of the max value
r = 0.05
ysat = Saturate(y,r);

% Listen 
%-------
sound(ysat,Fs)

% Curves
%--------
% Plot slowed sound
Ysat = fft(ysat);
Ysat = fftshift(Ysat); % Swaps left and right side of Y so that is is centered around f=0

tsat = linspace(0,length(ysat)-1,length(ysat))*Ts;
fsat = (-length(ysat)/2:(length(ysat)/2-1))/length(ysat)*Fs;

figure("Name", "Faster yrapide")
subplot(1,3,1)
plot(tsat,ysat)
xlabel('Time')
ylabel('Amplitude')
subplot(1,3,2)
plot(fsat,abs(Ysat).^2/length(ysat))
xlabel('Frequency')
ylabel('Power')
subplot(1,3,3)
spectrogram(ysat,128,120,128,Fs,'yaxis');


%%
%----------------------------
% 5- WAH WAH
%-----------------------------

width = 10000; % 1/Freqency of the wah
damping = 0.05; % Dont really know what this does. Smaller value -> more wah
% relative values of min and max determine the difference between up and
% down
min_cutoff = 50;
max_cutoff = 100;
    
[y_wahwah, fig] = wahwah(y,Fs,width,damping,min_cutoff,max_cutoff);

set(fig, 'visible', 'on')
% Listen 
%-------
sound(y_wahwah,Fs)

%%
%----------------------------
% 5- Robotization v2
%-----------------------------

% Robotization using 2 frequecies whose effect is weighted relatively to
% each other using the ration r
F1 = 1000;
F2 = 3;
r = 0.5; % Ration between the effects of F1 and F2 
y_rob = Rob2(y, F1, F2, r, Fs);

% Listen 
%-------
sound(y_rob,Fs)


Yrob = fft(y_rob);
Yrob = fftshift(Yrob); % Swaps left and right side of Y so that is is centered around f=0

trob = linspace(0,length(y_rob)-1,length(y_rob))*Ts;
frob = (-length(y_rob)/2:(length(y_rob)/2-1))/length(y_rob)*Fs;

figure("Name", "Faster yrapide")
subplot(1,3,1)
plot(trob,y_rob)
xlabel('Time')
ylabel('Amplitude')
subplot(1,3,2)
plot(frob,abs(Yrob).^2/length(y_rob))
xlabel('Frequency')
ylabel('Power')
subplot(1,3,3)
spectrogram(y_rob,128,120,128,Fs,'yaxis');
