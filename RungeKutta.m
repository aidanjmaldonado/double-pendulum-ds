% Calculate the angular mechanics of the system at the next state
function next_state =  runge_kutta_method(current_state, g, m1, m2, L1, L2, step)
    
    % Unpack current state values
    theta1     = current_state.theta1;
    theta1_dot = current_state.theta1_dot;
    theta2     = current_state.theta2;
    theta2_dot = current_state.theta2_dot;

    % Calculate k1 values
    k1_theta1     = theta1_dot;
    k1_theta1_dot = EOM(1, g, m1, m2, theta1, theta1_dot, theta2, theta2_dot, L1, L2);
    k1_theta2     = theta2_dot;
    k1_theta2_dot = EOM(2, g, m1, m2, theta1, theta1_dot, theta2, theta2_dot, L1, L2);

    % Calculate k2 values
    k2_theta1     = theta1_dot + (1/2) * step * k1_theta1_dot;
    k2_theta1_dot = EOM(1, g, m1, m2, theta1 + (step/2) * k1_theta1, theta1_dot + (1/2) * step * k1_theta1_dot, theta2 + (1/2) * step * k1_theta2, theta2_dot + (1/2) * step * k1_theta2_dot, L1, L2);
    k2_theta2     = theta2_dot + (1/2) * step * k1_theta2_dot;
    k2_theta2_dot = EOM(2, g, m1, m2, theta1 + (1/2) * step * k1_theta1, theta1_dot + (1/2) * step * k1_theta1_dot, theta2 + (1/2) * step * k1_theta2, theta2_dot + (1/2) * step * k1_theta2_dot, L1, L2);

    % Calculate k3 values
    k3_theta1     = theta1_dot + (1/2) * step * k2_theta1_dot;
    k3_theta1_dot = EOM(1, g, m1, m2, theta1 + (1/2) * step * k2_theta1, theta1_dot + (1/2) * step * k2_theta1_dot, theta2 + (1/2) * step * k2_theta2, theta2_dot + (1/2) * step * k2_theta2_dot, L1, L2);
    k3_theta2     = theta2_dot + (1/2) * step * k2_theta2_dot;
    k3_theta2_dot = EOM(2, g, m1, m2, theta1 + (1/2) * step * k2_theta1, theta1_dot + (1/2) * step * k2_theta1_dot, theta2 + (1/2) * step * k2_theta2, theta2_dot + (1/2) * step * k2_theta2_dot, L1, L2);

    % Calculate k4 values
    k4_theta1     = theta1_dot + step * k3_theta1_dot;
    k4_theta1_dot = EOM(1, g, m1, m2, theta1 + step * k3_theta1, theta1_dot + step * k3_theta1_dot, theta2 + step * k3_theta2, theta2_dot + step * k3_theta2_dot, L1, L2);
    k4_theta2     = theta2_dot + step * k3_theta2_dot;
    k4_theta2_dot = EOM(2, g, m1, m2, theta1 + step * k3_theta1, theta1_dot + step * k3_theta1_dot, theta2 + step * k3_theta2, theta2_dot + step * k3_theta2_dot, L1, L2);

    % Calculate values of next state using Runge-Kutta's Method
    new_theta1     = theta1 + (1/6) * step * (k1_theta1 + 2 * k2_theta1 + 2 * k3_theta1 + k4_theta1);
    new_theta1_dot = theta1_dot + (1/6) * step * (k1_theta1_dot + 2 * k2_theta1_dot + 2 * k3_theta1_dot + k4_theta1_dot);
    new_theta2     = theta2 + (1/6) * step * (k1_theta2 + 2 * k2_theta2 + 2 * k3_theta2 + k4_theta2);
    new_theta2_dot = theta2_dot + (1/6) * step * (k1_theta2_dot + 2 * k2_theta2_dot + 2 * k3_theta2_dot + k4_theta2_dot);
    
    % Package and return
    next_state = state(new_theta1, new_theta1_dot, new_theta2, new_theta2_dot);
end