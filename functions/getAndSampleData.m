function [t, v, w, x, y, theta] = getAndSampleData(fs, toggle_plot)


    [t_odom, v_raw, w_raw] = readOdometry();
    [t_true, x_true, y_true, theta_true] = readGroundtruth();
    
    % remove first mesurement point to mak start point equal
    t_true = t_true(2:end);
    x_true = x_true(2:end);
    y_true = y_true(2:end);
    theta_true = theta_true(2:end);
    theta_true_wrapped = theta_true;
    
    for k=2:size(theta_true,1)
        if(abs(theta_true(k-1)-theta_true(k))>(2*pi-0.5))
            theta_true(k:end) = theta_true(k:end) + sign(theta_true(k-1)-theta_true(k))*2*pi;
        end
    end
    
    % take realtive time
    t_odom = t_odom-t_true(1);
    t_true = t_true-t_true(1);
    
    %resample data
    x = resample(x_true, t_true, fs);
    y = resample(y_true, t_true, fs);
    theta = resample(theta_true, t_true, fs, 'linear');
    theta = wrapToPi(theta);
    t = (t_true(1):1./fs:t_true(end))';
    v = zeros(size(t, 1), 1);
    w = v;
    v(1) = v_raw(1);
    w(1) = w_raw(1);
    
    i=2;
    j=2;
    while(j<=size(t_true,1))
        if((i <= size(t,1)) && (t_odom(j-1)<t(i)) && (t_odom(j)>=t(i)))   
            v(i) = v_raw(j);
            w(i) = w_raw(j);
            i = i+1;
        end
        if((i <= size(t,1)) && (t_odom(j-1)<t(i)) && (t_odom(j)>=t(i)))
            j = j-1;
        end
        j = j+1;
    end
    
    %v = resample(v_raw, t_odom, fs);
    %w = resample(w_raw, t_odom, fs);
    
    % remove first and last few data points were resampling is inaccurate
    x = x(11:end-10);
    y = y(11:end-10);
    theta = theta(11:end-10);
    t = t(11:end-10);
    
    v = v(11:end-10);
    w = w(11:end-10);
    
    if(toggle_plot)
        figure()
        plot(t_true, x_true)
        hold on
        plot(t, x, 'x');
        xlabel('time')
        ylabel('x')
        title('Sampled x(t)')
        figure()
        plot(t_true, y_true)
        hold on
        plot(t, y, 'x');
        xlabel('time')
        ylabel('y')
        title('Sampled y(t)')
        figure()
        plot(t_true, theta_true_wrapped)
        hold on
        plot(t, theta, 'x');
        xlabel('time')
        ylabel('theta')
        title('Sampled theta(t)')
        figure()
        plot(t_odom, v_raw)
        hold on
        plot(t, v, 'x');
        xlabel('time')
        ylabel('v')
        title('Sampled v(t)')
        figure()
        plot(t_odom, w_raw)
        hold on
        plot(t, w, 'x');
        xlabel('time')
        ylabel('w')
        title('Sampled w(t)')
    end
    
    
end