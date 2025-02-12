% % Initialize Parameters

% System Constants
g  = 9.81;            % gravity (m/s^2)
m1 = 1;               % mass 1 (kg)
m2 = 1;               % mass 2 (kg)
L1 = 1;               % pendulum arm 1 length (m)
L2 = [0.25, 0.5];     % pendulum arm 2 length (m) - [1st simulation, 2nd simulation]

% Initial Conditions
theta1_init = 1 / (3*pi);  % initial angle of arm 1 from equilibrium (radians)
theta1_dot  = 0;           % initial angular velocity of arm 1 (rad/s) 
theta2_init = 2 / (3*pi);  % initial angle of arm 2 from equilibrium (radians)
theta2_dot  = 0;           % initial angular velocity of arm 2 (rad/s)

% Simulation Settings
t_step    = [0.1, .01];   % simulation timestamp precision (s/step) - [1st simulation, 2nd simulation]
duration  = 5;            % simulation duration (s) [** At around 30s it devolves into chaos **]

% % Run Simulations

% Initialize Plot
figure;
axis equal;
hold on;
max_L2 = max(L2);
xlim([(-L1 - max_L2) * 1.1, (L1 + max_L2) * 1.1])
ylim([(-L1 - max_L2) * 1.1, (L1 + max_L2) * 1.1])
title("Double Pendulum")

euler_method_1 = simulation(@euler_method, g, m1, m2, L1, L2(1), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step(1), duration);
euler_method_1.run() % [**** Seems wrong :') Euler 1 actually seems to work fine if it uses the smaller t_step (2) ****]
euler_method_1.animate("Euler Method 1")


euler_method_2 = simulation(@euler_method, g, m1, m2, L1, L2(2), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step(2), duration);
euler_method_2.run() % Seems alright?
euler_method_2.animate("Euler Method 2")

trapezoid_method_1 = simulation(@trapezoid_method, g, m1, m2, L1, L2(1), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step(1), duration);
trapezoid_method_1.run()
trapezoid_method_1.animate("Trapezoid Method 1")

trapezoid_method_2 = simulation(@trapezoid_method, g, m1, m2, L1, L2(2), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step(2), duration);
trapezoid_method_2.run()
trapezoid_method_2.animate("Trapezoid Method 2")
% 
% runge_kutta_method_1 = simulation(@runge_kutta_method, g, m1, m2, L1, L2(1), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step(1), duration);
% runge_kutta_method_1.run()
% 
% runge_kutta_method_2 = simulation(@runge_kutta_method, g, m1, m2, L1, L2(2), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step(2), duration);
% runge_kutta_method_2.run()

hold off;
