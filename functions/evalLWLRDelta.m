function [] = evalLWLRDelta(prediction, x_true, y_true, theta_true, title_plot)
    x_predict = x_true(1);
    y_predict = y_true(1);
    theta_predict = theta_true(1);
    for i=1:size(prediction,1)
        x_predict(i+1) = x_predict(i) + prediction(i,1);
        y_predict(i+1) = y_predict(i) + prediction(i,2);
        theta_predict(i+1) = theta_predict(i) + prediction(i,3);
    end  
    figure()
    plot(x_predict,y_predict)
    hold on
    plot(x_true, y_true)
    xlabel('x')
    ylabel('y')
    title(title_plot)
    legend('Predicted position', 'True position')
    
    error_abs = sqrt((x_predict'-x_true).^2+(y_predict'-y_true).^2);
    error_rel = sqrt((prediction(:,1)-(x_true(2:end)-x_true(1:end-1))).^2+(prediction(:,2)-(y_true(2:end)-y_true(1:end-1))).^2);
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