function [x_1, y_1, theta_1] = transitionModel(v_1, w_1, x_0, y_0, theta_0, dt)
    %%% This function computes the transition model of the robot
    x_1 = x_0 + dt * v_1 * cos(theta_0+dt*w_1);
    y_1 = y_0 + dt * v_1 * sin(theta_0+dt*w_1);
    theta_1 = wrapTo2Pi(theta_0+dt*w_1);
end
