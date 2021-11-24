function [d] = phi(x, y, sigma, pos_theta)
    delta = x-y;
    for i=1:size(delta,1)
        if(i==pos_theta)
            delta(i) = wrapToPi(delta(i));
        end
    end
    d = exp(-(delta)*pinv(sigma)*(delta)');
end