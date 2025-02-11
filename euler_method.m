% Calculate the angular mechanics of the system at the next state
function next_state =  euler_method(current_state, g, m1, m2, L1, L2, step)
    
    % Unpack current state values
    theta1     = current_state.theta1;
    theta1_dot = current_state.theta1_dot;
    theta2     = current_state.theta2;
    theta2_dot = current_state.theta2_dot;

    % Calculate values of next state using Euler's Method
    new_theta1     = theta1 + step * theta1_dot;
    new_theta1_dot = theta1_dot + step * M1AA(g, m1, m2, theta1, theta1_dot, theta2, theta2_dot, L1, L2);
    new_theta2     = theta2 + step * theta2_dot;
    new_theta2_dot = theta2_dot + step * M2AA(g, m1, m2, theta1, theta1_dot, theta2, theta2_dot, L1, L2);
    
    % Package and return
    disp(new_theta1);
    next_state = state(new_theta1, new_theta1_dot, new_theta2, new_theta2_dot);
end