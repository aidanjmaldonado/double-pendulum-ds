% ode45_method.m
function state_array = ode45_method(g, m1, m2, L1, L2, theta1_init, theta1_dot_init, theta2_init, theta2_dot_init, t_step, duration, effective_dampening)

    % Returns the derivatives (right-hand side of the ODE)
    function derivatives = double_pendulum_equations(~, current_state, g, m1, m2, L1, L2, e_damp, t_step)
        theta1     = current_state(1);
        theta1_dot = current_state(2);
        theta2     = current_state(3);
        theta2_dot = current_state(4);
    
        theta1_doot = EOM(1, g, m1, m2, theta1, theta1_dot, theta2, theta2_dot, L1, L2);
        theta2_doot = EOM(2, g, m1, m2, theta1, theta1_dot, theta2, theta2_dot, L1, L2);

        % Apply dampening
        theta1_doot = theta1_doot + (log(e_damp)/t_step) * theta1_dot;
        theta2_doot = theta2_doot + (log(e_damp)/t_step) * theta2_dot;

        derivatives = [theta1_dot; theta1_doot; theta2_dot; theta2_doot];
    end

    % Initial conditions
    initial_state = [theta1_init; theta1_dot_init; theta2_init; theta2_dot_init];
    time_array = 0:t_step:duration; 
 
    % Evaluate with ode45 solver
    [~, state_array] = ode45(@(t, y) double_pendulum_equations(t, y, g, m1, m2, L1, L2, effective_dampening, t_step), time_array, initial_state);
end