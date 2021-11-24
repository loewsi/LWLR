function [mu_bar, sigma_bar] = getMotionUpdate(X, lambda, R, t0, t1, alpha, beta)

%%% This function computes the new mean and covarince of sigma points after
%%% the motion update

    w_m0 = lambda/(3+lambda);
    w_m = 1/(2*(3+lambda));
    w_c0 = lambda/(3+lambda) + (1 - alpha^2 + beta);

    
    mu_bar = w_m0 * X(:, 1);
    for i=2:7
        mu_bar = mu_bar + w_m * X(:, i);
    end
    
    sigma_bar = w_c0*(diffX(X(:, 1),mu_bar))*(diffX(X(:, 1),mu_bar))' + R * (t1-t0)^2;
    for i=2:7
        sigma_bar = sigma_bar +  w_m*(diffX(X(:, i),mu_bar))*(diffX(X(:, i),mu_bar))';
    end
    
    
end
