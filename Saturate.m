function [ysat] = Saturate(y, r)
    ysat = NaN(length(y),1);
    ymax = max(abs(y));
    for k = 1:length(y)
       if y(k) > r*ymax
            ysat(k) = r*ymax;
       elseif y(k) < -r*ymax
            ysat(k) = -r*ymax;
       else
            ysat(k) = y(k);
    end
end

