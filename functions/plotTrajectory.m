function plotTrajectory(x, y, theta)
    u = cos(theta)';
    v = sin(theta)';
    scale = 0.3;
    figure
    quiver(x,y, u, v, scale)
    xlabel('x[m]')
    ylabel('y[m]')
    axis equal
end
