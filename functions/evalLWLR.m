function [] = evalLWLR(prediction, x_true, y_true, theta_true, title_plot)
    x_predict = prediction(:,1);
    y_predict = prediction(:,2);
    theta_predict = prediction(:,3);
    figure()
    plot(x_predict,y_predict)
    hold on
    plot(x_true, y_true)
    xlabel('x')
    ylabel('y')
    title(title_plot)
    legend('Predicted position', 'True position')
    
    error_abs = sqrt((x_predict-x_true(2:end)).^2+(y_predict-y_true(2:end)).^2);
    error_rel = sqrt(((prediction(2:end,1)-(prediction(1:end-1,1)))-(x_true(3:end)-x_true(2:end-1))).^2+((prediction(2:end,2)-(prediction(1:end-1,2)))-(y_true(3:end)-y_true(2:end-1))).^2);
    mean(error_abs)
    var(error_abs)
    mean(error_rel)
    var(error_rel)
    
    figure()
    plot(error_abs)
    xlabel('timestep')
    ylabel('Error')
    title(title_plot)
    hold on
    plot(error_rel)
    legend('Absolute error', 'Relative Error')
end