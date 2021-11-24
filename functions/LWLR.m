function [y_q] = LWLR(x_t, y_t, x_q, sigma, pos_theta)
    W = eye(size(x_t, 1));
    y_q = zeros(size(x_q,1), size(y_t,2));
    for i=1:size(x_q,1)
        for j=1:size(x_t,1)
            W(j,j) = phi(x_t(j,:), x_q(i,:), sigma, pos_theta);
        end
        Z = W * x_t;
        V = W * y_t;
        beta = (Z'*Z)\Z'*V;
        y_q(i,:) = x_q(i,:) * beta;
        if(pos_theta>0)
            y_q(i, pos_theta) = wrapToPi(y_q(i, pos_theta));
        end
    end
end