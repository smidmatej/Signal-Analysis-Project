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
% [y,Fs]=audioread('Diner.wav');   %original signal
% [y,Fs]=audioread('Extrait.wav');   %original signal
 [y,Fs]=audioread('Halleluia.wav');   %original signal
% Note: if the signal is in stereo, only process one channel at a time.
% time
y = y(:,1);
Y = fft(y);

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
plot(f,abs(Y).^2/length(y))
xlabel('Frequency')
ylabel('Power')
subplot(1,3,3)
spectrogram(y,128,120,128,Fs,'yaxis');

% Don't forget to create the time and frequency vectors...
% TO DO !
% Ecoute
%-------
%sound(y,Fs)

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
tlent = linspace(0,length(ylent)-1,length(ylent))*Ts;
% This is clunky, I have to multiply by rapp twice. That is because of the
% linspace function. Whatever, it works
flent = linspace(-length(ylent)/2, length(ylent)/2-1, length(ylent))/(Fs/rapp/rapp);
%flent = (-length(ylent)/2:length(ylent)/2-1)*(Fs/length(ylent));
figure("Name", "Slowed ylent")
subplot(1,3,1)
plot(tlent,ylent)
xlabel('Time')
ylabel('Amplitude')
subplot(1,3,2)
plot(flent,abs(Ylent).^2/length(y))
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
Ylent = fft(yrapide);
tvoc = linspace(0,length(yrapide)-1,length(yrapide))*Ts;
% This is clunky, I have to multiply by rapp twice. That is because of the
% linspace function. Whatever, it works
flent = linspace(-length(yrapide)/2, length(yrapide)/2-1, length(yrapide))/(Fs/rapp/rapp);
figure("Name", "Faster yrapide")
subplot(1,3,1)
plot(tvoc,yrapide)
xlabel('Time')
ylabel('Amplitude')
subplot(1,3,2)
plot(flent,abs(Ylent).^2/length(y))
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
tvoc = linspace(0,length(yvoc)-1,length(yvoc))*Ts;
% This is clunky, I have to multiply by rapp twice. That is because of the
% linspace function. Whatever, it works
flent = linspace(-length(yvoc)/2, length(yvoc)/2-1, length(yvoc))/(Fs);
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
plot(flent,abs(Yvoc).^2/length(y))
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
sum_sampling_rate = length(yvoc)/length(y);
[n,d] = rat(sum_sampling_rate);
y_compare = resample(y,n,d);
y_sum = y_compare(1:length(yvoc))-yvoc;


% Listen
%-------
sound(yvoc, Fs)

% Curves
%--------

% TODO: I dont think the frequency matches

Yvoc = fft(yvoc);
tvoc = linspace(0,length(yvoc)-1,length(yvoc))*Ts;
% This is clunky, I have to multiply by rapp twice. That is because of the
% linspace function. Whatever, it works
flent = linspace(-length(yvoc)/2, length(yvoc)/2-1, length(yvoc))/(Fs);
figure('Name', 'Pitch modificaton down')

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
plot(flent,abs(Yvoc).^2/length(y))
xlabel('Frequency')
ylabel('Power')
subplot(2,3,[3 3+3])
spectrogram(yvoc,128,120,128,Fs,'yaxis');


%%
%----------------------------
% 3- VOICE ROBOTIZATION
%-----------------------------
% Choice of carrier frequency (2000, 1000, 500, 200)
HR=500; %can be changed

yrob = Rob(y,Fc,Fs);

% Listen
%-------
% TO DO !

% Curves
%-------------
% TO DO !