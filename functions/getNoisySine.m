function [test_input, test_output] = getNoisySine(length, res, toggle_plot)
%GETNOISYSINE generate noisy sine of desired length and resolution
    test_input = (0:length/(res-1):length)';
    test_output = sin(test_input) + randn(res, 1)/10;
    
    if(toggle_plot)
        figure()
        plot(test_input, test_output, 'x')
        hold on
        plot(test_input, sin(test_input))
        xlabel('input')
        ylabel('output')
        title('Noisy Sine')
    end
    
end

