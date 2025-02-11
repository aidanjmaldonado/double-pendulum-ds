% Calculate the angular mechanics of the system at the next state
function next_state =  runge_kutta_method(current_state, g, m1, m2, L1, L2, step)
    
    % Unpack current state values
    theta1     = current_state.theta1;
    theta1_dot = current_state.theta1_dot;
    theta2     = current_state.theta2;
    theta2_dot = current_state.theta2_dot;

    % Calculate values of next state using Runge-Kutta's Method
    new_theta1     = 0; % To-do
    new_theta1_dot = 0; % To-do
    new_theta2     = 0; % To-do
    new_theta2_dot = 0; % To-do
    
    % Package and return
    next_state = state(new_theta1, new_theta1_dot, new_theta2, new_theta2_dot);
end