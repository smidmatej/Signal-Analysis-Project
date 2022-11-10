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

 [y,Fs]=audioread('Diner.wav');   %original signal
% [y,Fs]=audioread('Extrait.wav');   %original signal
% [y,Fs]=audioread('Halleluia.wav');   %original signal
% Note: if the signal is in stereo, only process one channel at a time.
% time
y = y(:,1);

% Curves (evolution over time, spectrum and spectrogram)
%--------
% Don't forget to create the time and frequency vectors...
% TO DO !
% Ecoute
%-------
% A FAIRE !

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
% A FAIRE !


% Courbes
%--------
% A FAIRE !

%
% FASTER
rapp = 3/2;   %can be modified
yrapide = PVoc(y,rapp,1024); 


% Listen 
%-------
% A FAIRE !

% Curves
%--------
% TO DO !

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
yvoc = PVoc(y, a/b,Nfft,Nwind);

% Resampling the time signal to keep the same speed
% TO DO !

%Sum of original and modified signal
%Attention: we must take the same number of samples
%Note: you can put a coefficient on ypitch so that it
% intervenes + or - in the sum...
% TO DO !

% Listen
%-------
% TO DO !

% Curves
%--------
% TO DO !


%Decrease
%------------

a=3; b=2; %can be changed
yvoc = PVoc(y, a/b,Nfft,Nwind);

% Resampling the time signal to keep the same speed
% TO DO !

%Sum of original and modified signal
%Attention: we must take the same number of samples
%Note: you can put a coefficient on ypitch so that it
% intervenes + or - in the sum...
% TO DO !

% Listen
%-------
% TO DO !

% Curves
%--------
% TO DO !


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