% initialize Workspace
clear, close all
initWorkspace();


% get sampled data
fs = 2;
[t, v, w, x, y, theta] = getAndSampleData(fs, false);
% save whole data
saveData(t, v, w, x, y, theta, 'learning_dataset.txt');
% save data in three batches for training and evaluation
saveData(t(1:918), v(1:918), w(1:918), x(1:918), y(1:918), theta(1:918), 'learning_dataset_batch_1.txt');
saveData(t(919:1836), v(919:1836), w(919:1836), x(919:1836), y(919:1836), theta(919:1836), 'learning_dataset_batch_2.txt');
saveData(t(1837:2754), v(1837:2754), w(1837:2754), x(1837:2754), y(1837:2754), theta(1837:2754), 'learning_dataset_batch_3.txt');


% test algorithm on noisy sin function
[test_training_input, test_training_output] = getNoisySine(4*pi, 50, false);

test_query = (1.5:(2*pi+1)/(50-1):(4*pi-1.5))';
sigma = eye(1)*1;
test_model_predictions = LWLR(test_training_input, test_training_output, test_query, sigma, 0);
evalTest(test_training_input, test_training_output, test_query, test_model_predictions, 'Test algorithm on noisy sine') 


% apply algorithm

% map v, w, theta -> ∆x, ∆y, ∆theta
% assume perfect knowledge of state (theta) at each timestep
sigma = eye(3)*0.1;
model_predictions_1 = LWLR([v(1:1835),  w(1:1835),  theta(1:1835)], [x(2:1836)-x(1:1835), y(2:1836)-y(1:1835), theta(2:1836)-theta(1:1835)], [v(1837:2753),  w(1837:2753), theta(1837:2753)], sigma, 3);
disp('map v, w, theta -> ∆x, ∆y, ∆theta, perfect knowledge of state')
evalLWLRDelta(model_predictions_1, x(1837:2754), y(1837:2754), theta(1837:2754), 'map v, w, theta -> ∆x, ∆y, ∆theta, perfect knowledge of state')

% map v, w, theta -> ∆x, ∆y, ∆theta
% assume knowledge of state (theta) at timestep depends on prediction of last timestep
sigma = eye(3)*1;
model_predictions_2 = LWLRIncrementalDelta([v(1:1835),  w(1:1835),  theta(1:1835)], [x(2:1836)-x(1:1835), y(2:1836)-y(1:1835), theta(2:1836)-theta(1:1835)], [v(1837:2753),  w(1837:2753)], theta(1837), sigma, 3);
disp('map v, w, theta -> ∆x, ∆y, ∆theta, use prediction of state')
evalLWLRDelta(model_predictions_2, x(1837:2754), y(1837:2754), theta(1837:2754), 'map v, w, theta -> ∆x, ∆y, ∆theta, use prediction of state')


% map v_t, w_t, x_t, y_t, theta_t -> x_(t+1), y_(t+1), theta_(t+1)
% assume perfect knowledge of state at each timestep
sigma = eye(5)*2;
model_predictions_3 = LWLR([v(1:1835),  w(1:1835), x(1:1835), y(1:1835), theta(1:1835)], [x(2:1836), y(2:1836), theta(2:1836)], [v(1837:2753),  w(1837:2753), x(1837:2753), y(1837:2753), theta(1837:2753)], sigma, 0);
disp('map v_t, w_t, x_t, y_t, theta_t -> x_{t+1}, y_{t+1}, theta_{t+1}, perfect knowledge of state')
evalLWLR(model_predictions_3, x(1837:2754), y(1837:2754), theta(1837:2754), 'map v_t, w_t, x_t, y_t, theta_t -> x_{t+1}, y_{t+1}, theta_{t+1}, perfect knowledge of state')


% map v_t, w_t, x_t, y_t, theta_t -> x_(t+1), y_(t+1), theta_(t+1)
% assume knowledge of state at timestep depends on prediction of last timestep
sigma = eye(5)*5;
sigma(1,1) = 1;
sigma(2,2) = 1;
model_predictions_4 = LWLRIncremental([v(1:1835),  w(1:1835), x(1:1835), y(1:1835), theta(1:1835)], [x(2:1836), y(2:1836), theta(2:1836)], [v(1837:2753),  w(1837:2753)], [x(1837), y(1837), theta(1837)], sigma, 5);
disp('map v_t, w_t, x_t, y_t, theta_t -> x_{t+1}, y_{t+1}, theta_{t+1}, use prediction of state')
evalLWLR(model_predictions_4, x(1837:2754), y(1837:2754), theta(1837:2754), 'map v_t, w_t, x_t, y_t, theta_t -> x_{t+1}, y_{t+1}, theta_{t+1}, use prediction of state')



% map v, w, theta, sin(theta), cos(theta) -> ∆x, ∆y, ∆theta
% assume perfect knowledge of state (theta) at each timestep
sigma = eye(5)*0.1;
model_predictions_5 = LWLR([v(1:1835),  w(1:1835),  theta(1:1835), sin(theta(1:1835)), cos(theta(1:1835))], [x(2:1836)-x(1:1835), y(2:1836)-y(1:1835), theta(2:1836)-theta(1:1835)], [v(1837:2753),  w(1837:2753), theta(1837:2753), sin(theta(1837:2753)), cos(theta(1837:2753))], sigma, 3);
disp('map v, w, theta, sin(theta), cos(theta) -> ∆x, ∆y, ∆theta, perfect knowledge of state')
evalLWLRDelta(model_predictions_5, x(1837:2754), y(1837:2754), theta(1837:2754), 'map v, w, theta, sin(theta), cos(theta) -> ∆x, ∆y, ∆theta, perfect knowledge of state')


% use motion model
[x_sim, y_sim, theta_sim] = simulateSystem(v(1837:2753),  w(1837:2753), 1/fs, x(1837), y(1837), theta(1837));
disp('Simulated System')
evalLWLR([x_sim, y_sim, theta_sim], x(1837:2754), y(1837:2754), theta(1837:2754), 'Simulated System')

