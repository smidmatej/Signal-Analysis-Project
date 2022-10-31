function Y = TFCT_Interp(X,t,Nov)
% X is the STFT of x. Shape(X) = (ncfft, nct), where ncfft are the frequencies
% and nct are the time samples
% Interpolation from nct -> t
% t is a vector of time samples where we want to interpolate X

% Initialize M as a empty matrix with correct dimensions
M = NaN(length(X), length(t));
phi = NaN(length(X), length(t));


[nl, nc] = size(X)


dphi0 = zeros(nl,1);
N = 2*(nl-1);
% ???
dphi0(2:nl) = (2*pi*Nov)./(N./(1:(N/2)));


for idx_t = 1:(length(t))
    
    % interpolation index -> original signal index 
    k = (idx_t-1)/length(t)
    idx_x = floor(nc*k)+1
    
    % Scaling coefficients
    beta = t(idx_t) - floor(t(idx_t));
    alpha = 1 - beta;

    if idx_x ~= nc
        % Interpolate
        M(:, idx_t) = alpha*abs(X(:, idx_x)) + beta*abs(X(:, idx_x+1));
        phi(:, idx_t) = angle(X(:, idx_x+1)) - angle(X(:, idx_x)) - dphi0;
    else
        % The end, set the last sample 
        M(:, idx_t) = abs(X(:, idx_x));
        phi(:, idx_t) = angle(X(:, idx_x)) - dphi0;
    end
end
M
phi
Y = M.* exp(j.*phi)