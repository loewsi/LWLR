function [y_q] = LWLRIncrementalDelta(x_t, y_t, x_q, x_0, sigma, pos_theta)
    W = eye(size(x_t, 1));
    y_q = zeros(size(x_q,1), size(y_t,2));
    theta = x_0;
    for i=1:size(x_q,1)
        if(i>1)
            theta = wrapToPi(theta + y_q(i-1,end));
        end
        for j=1:size(x_t,1)
            if(i==1)
                W(j,j) = phi(x_t(j,:), [x_q(i,:), x_0], sigma, pos_theta);
            else
                W(j,j) = phi(x_t(j,:), [x_q(i,:), theta], sigma, pos_theta);
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
            y_q(i,:) = [x_q(i,:), theta] * beta;
            if(pos_theta>2)
                y_q(i, pos_theta-2) = wrapToPi(y_q(i, pos_theta-2));
            end
        end
    end
end