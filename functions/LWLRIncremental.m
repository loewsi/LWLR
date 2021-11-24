function [y_q] = LWLRIncremental(x_t, y_t, x_q, x_0, sigma, pos_theta)
    W = eye(size(x_t, 1));
    y_q = zeros(size(x_q,1), size(y_t,2));
    for i=1:size(x_q,1)
        for j=1:size(x_t,1)
            if(i==1)
                W(j,j) = phi(x_t(j,:), [x_q(i,:), x_0], sigma, pos_theta);
            else
                W(j,j) = phi(x_t(j,:), [x_q(i,:), y_q(i-1,:)], sigma, pos_theta);
            end
        end
        Z = W * x_t;
        V = W * y_t;
        beta = (Z'*Z)\Z'*V;
        if(i==1)
            y_q(i,:) = [x_q(i,:), x_0] * beta;
            if(pos_theta>2)
                y_q(i, pos_theta-2) = wrapToPi(y_q(i, pos_theta-2));
            end
        else
            y_q(i,:) = [x_q(i,:), y_q(i-1,:)] * beta;
            if(pos_theta>2)
                y_q(i, pos_theta-2) = wrapToPi(y_q(i, pos_theta-2));
            end
        end
    end
end