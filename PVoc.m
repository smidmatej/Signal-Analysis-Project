function y = PVoc(x, rapp, Nfft, Nwind)
% y = PVoc(x, rapp, Nfft , Nwind)
% Phase vocoder function for modifying an audio sound
% by interpolating in the frequency domain passing
% by short-term TF.
%
% x: original audio signal (only 1 channel is processed at a time --> x is a
% vector)
%
% ratio: is the ratio between the original speed and the arrival speed
%
% Nfft: number of points (samples) on which the FT is performed
% windowed
%
% Nwind: length, in number of samples, of the weighting window during the TFCT



% Default values ​​in case the input parameters are not all given
%----------------------------------------------------------------------------------
if nargin < 3
  Nfft = 1024;
end

if nargin < 4
  Nwind = Nfft;
end

% Useful parameters for TFCT
%--------------------------------
% We choose a Hanning weighting window
% In order to have a good reconstruction with a Hanning window (smoothed signals),
% we take an overlap of 25% of the window
Nov = Nfft/4;
% Scale factor
% Note: to find the correct amplitude when making a
% direct TFCT + an inverse TFCT, we take it equal to 2/3...
% we will not detail the demonstration here.
% In our application, we can take it = 1
scf = 1.0;

% 1- CALCULATION OF THE TFCT
%-----------------------
X = scf * TFCT(x', Nfft, Nwind, Nov);

Fs = 11025

% 2- Interpolation of frequency samples
%------------------------------------------------
% Calculation of the new time base (in terms of samples)
% this corresponds to the new number of frames (time windows)
[nl, nc] = size(X);
Nt = [0:rapp:(nc-2)];
% Remark :
% we take Ntmax at (nc-2) instead of (nc-1) because during the interpolation,
% we work with columns n and n+1, n belong to Nt.

% Calculation of the new TFCT
X2 = TFCT_Interp(X, Nt, Nov);

% Note: you will need to create this "TFCT_Interp" function!



% 3- CALCULATION OF THE REVERSE TFCT
%------------------------------
y = TFCTInv(X2, Nfft, Nwind, Nov)';


