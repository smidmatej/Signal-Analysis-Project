[y,Fs] = audioread('paulhill2.wav');

%Initialization of parameters
L = length(y);
fshift      = 128;
lenW        = 2048;
window1     = hann(lenW);
ratioCOLA   =sum(window1.^2)/fshift;
window1     =window1/sqrt(ratioCOLA);
window2     = window1;

y = [zeros(lenW, 1); y;  zeros(lenW-mod(L,fshift),1)];
xOut = zeros(length(y),1);
pntrIn  = 0;  pntrOut = 0;

while pntrIn<length(y) - lenW
	thisGrain = window1.*y(pntrIn+1:pntrIn+lenW);
	f      = fftshift(fft(thisGrain));
	magF   = abs(f);
	phaseF = 0*angle(f);             % Set phase to zero ("robot effect");
	fHat    = magF.* exp(i*phaseF);
	thisGrain = window2.*real(ifft(fftshift(fHat)));

	xOut(pntrOut+1:pntrOut+lenW) = thisGrain + xOut(pntrOut+1:pntrOut+lenW);
	pntrOut = pntrOut + fshift;
    pntrIn  = pntrIn + fshift;
end

soundsc(xOut, Fs);