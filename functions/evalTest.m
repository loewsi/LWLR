function [] = evalTest(test_training_input, test_training_output, test_query, test_model_predictions, title_plot)
    figure()
    plot(test_training_input, test_training_output)
    hold on
    plot(test_query, test_model_predictions)
    axis equal
    xlabel('x')
    ylabel('sin(x)')
    title(title_plot)
end