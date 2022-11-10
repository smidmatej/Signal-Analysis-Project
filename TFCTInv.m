function x = TFCTInv(d, Nfft, Nwin, hop)

% D = TFCTInv(d,Nfft,w,hop)
% Inverse Short Term Fourier Transform(inverse TFCT)
%
% d: signal for which we want to calculate the inverse TFCT
% Nfft: number of points for the inverse FFT
% win: number of points in the weighting window
% hop: number of window covering points
%
%x: result of the inverse TFCT
%
% Program largely inspired by that of D. Marshall


%Initialization of parameters
N = size(d);
cols = N(2);
xlen = Nfft + (cols-1)*hop;

%Initialization of the output vector (the inverse TFCT)
x = zeros(1,xlen);

%creation of the weighting window
    if rem(Nwin, 2) == 0   
      Nwin = Nwin + 1;  %for having an odd number of samples
    end
    halflen = (Nwin-1)/2;
    halff = Nfft/2;   % central point of the window
    halfwin = 0.5 * ( 1 + cos( pi * (0:halflen)/halflen));
    win = zeros(1, Nfft);
    acthalflen = min(halff, halflen);
    win((halff+1):(halff+acthalflen)) = halfwin(1:acthalflen);
    win((halff+1):-1:(halff-acthalflen+2)) = halfwin(1:acthalflen);

%Calcul    
for b = 0:hop:(hop*(cols-1))
  ft = d(:,1+b/hop)';
  ft = [ft, conj(ft([((Nfft/2)):-1:2]))];
  px = real(ifft(ft));
  x((b+1):(b+Nfft)) = x((b+1):(b+Nfft))+px.*win;
end;
