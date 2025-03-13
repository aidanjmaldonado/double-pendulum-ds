% Calculate the angular mechanics of the system at the next state
function next_state =  trapezoid_method(current_state, g, m1, m2, L1, L2, step)
    
    % Unpack current state values
    theta1     = current_state.theta1;
    theta1_dot = current_state.theta1_dot;
    theta2     = current_state.theta2;
    theta2_dot = current_state.theta2_dot;

    % Calculate intermediate Euler values
    euler_theta1     = theta1 + step * theta1_dot;
    euler_theta1_dot = theta1_dot + step * EOM(1, g, m1, m2, theta1, theta1_dot, theta2, theta2_dot, L1, L2);
    euler_theta2     = theta2 + step * theta2_dot;
    euler_theta2_dot = theta2_dot + step * EOM(2, g, m1, m2, theta1, theta1_dot, theta2, theta2_dot, L1, L2);

    % Calculate values of next state using Trapezoid's Method
    new_theta1     = theta1 + (1/2) * step * (theta1_dot + euler_theta1_dot);
    new_theta1_dot = theta1_dot + (1/2) * step * (EOM(1, g, m1, m2, theta1, theta1_dot, theta2, theta2_dot, L1, L2) + M1AA(g, m1, m2, euler_theta1, euler_theta1_dot, euler_theta2, euler_theta2_dot, L1, L2));
    new_theta2     = theta2 + (1/2) * step * (theta2_dot + euler_theta2_dot);
    new_theta2_dot = theta2_dot + (1/2) * step * (EOM(2, g, m1, m2, theta1, theta1_dot, theta2, theta2_dot, L1, L2) + M2AA(g, m1, m2, euler_theta1, euler_theta1_dot, euler_theta2, euler_theta2_dot, L1, L2));
    
    % Package and return
    next_state = state(new_theta1, new_theta1_dot, new_theta2, new_theta2_dot);
end