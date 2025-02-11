% % Initialize Parameters

% System Constants
g  = 9.81;            % gravity (m/s^2)
m1 = 1;               % mass 1 (kg)
m2 = 1;               % mass 2 (kg)
L1 = 1;               % pendulum arm 1 length (m)
L2 = [0.25, 0.5];     % pendulum arm 2 length (m) - [1st simulation, 2nd simulation]

% Initial Conditions
theta1_init = 1 / (3*pi);  % initial angle of arm 1 from equilibrium (radians)
theta1_dot  = 0;           % initial angular velocity (rad/s) 
theta2_init = 2 / (3*pi);  % initial angle of arm 2 from equilibrium (radians)
theta2_dot  = 0;           % initial angular velocity (rad/s)

% Simulatiion Settings
t_step    = [0.1, 0.01];   % simulation timestamp precision (s/step)
duration  = 5;             % simulation duration (s)

%%



euler_method_1 = simulation(@euler_method, g, m1, m2, L1, L2(1), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step(1), duration);
euler_method_1.run()

