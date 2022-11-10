function Y = TFCT_Interp(X,t,Nov)
% X is the STFT of x. Shape(X) = (ncfft, nct), where ncfft are the frequencies
% and nct are the time samples
% Interpolation from nct -> t
% t is a vector of time samples where we want to interpolate X

% Initialize M as a empty matrix with correct dimensions
M = NaN(size(X,1), length(t));
phi = NaN(size(X,1), length(t));


[nl, nc] = size(X);


dphi0 = zeros(nl,1);
N = 2*(nl-1);

% Starting condition for the phi accumulator
phi_now(2:nl) = (2*pi*Nov)./(N./(1:(N/2)));
%phi_now = 0;
for idx_t = 1:(length(t))
    
    % interpolation index -> original signal index 
    k = (idx_t-1)/length(t);
    idx_x = floor(nc*k)+1;
    
    % Scaling coefficients
    beta = t(idx_t) - floor(t(idx_t));
    alpha = 1 - beta;

    if idx_x ~= nc
        % Interpolate
        M(:, idx_t) = alpha*abs(X(:, idx_x)) + beta*abs(X(:, idx_x+1));
        
        % Interpolate phase
        dphi(1,:) = angle(X(:, idx_x+1)) - angle(X(:, idx_x)); % Phase difference
        dphi = dphi - 2*pi*round(dphi/2/pi); % convert to <-pi,pi>
        phi_now = phi_now + dphi; % Accumulate dphi. dphi0 is the starting condition in phi_now
        phi(:, idx_t) = phi_now; % Save accumulated phase 
    else
        % The end, set the last sample 
        M(:, idx_t) = abs(X(:, idx_x));
        phi(:, idx_t) = angle(X(:, idx_x)) - dphi0;
    end
end

Y = M.* exp(j.*phi);