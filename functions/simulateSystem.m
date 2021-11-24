function [x, y, theta] = simulateSystem(v, w, dt, x_0, y_0, theta_0)

%%% This function simulates the system for given inputs and inital position

    N = length(v);
    x = zeros(N,1);
    y = zeros(N,1);
    theta = zeros(N,1);
    x(1) = x_0;
    y(1) = y_0;
    theta(1) = theta_0;
    for i=1:N-1
        [x(i+1), y(i+1), theta(i+1)] = transitionModel(v(i), w(i), x(i), y(i), theta(i), dt);
    end
    
    
end