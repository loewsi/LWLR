function [] = saveData(t, v, w, x, y, theta, name);
    datatable = table(t, v, w, x, y, theta, 'VariableNames', { 't', 'v', 'w', 'x', 'y', 'theta'});
    writetable(datatable, name)
end