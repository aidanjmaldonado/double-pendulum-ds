% % Initialize parameters

% System constants
g  = 9.81;            % gravity (m/s^2)
m1 = 1;               % mass 1 (kg)
m2 = 1;               % mass 2 (kg)
L1 = 1;               % pendulum arm 1 length (m)
L2 = [0.25, 0.50];    % pendulum arm 2 length (m) - [1st simulation, 2nd simulation]

% Initial conditions
theta1_init = 1 / (3*pi);  % initial angle of arm 1 from equilibrium (radians)
theta1_dot  = 0;           % initial angular velocity of arm 1 (rad/s) 
theta2_init = 2 / (3*pi);  % initial angle of arm 2 from equilibrium (radians)
theta2_dot  = 0;           % initial angular velocity of arm 2 (rad/s)
dampening   = 1.00;        % scalar - controls how the system experiences friction (1.00 for no friction, 0.01 for max friction)

% Simulation settings
t_step    = 0.01;          % simulation timestamp precision (s/step) - [1st simulation, 2nd simulation]
duration  = 5;             % simulation duration (s)

% % Simulations

% Initialize plots
frame = simulation.initialize_plots(L1, L2);
normalize = false;        % Normalize theta plot [-π, π]
animation_speed = 1.00;   % Playback speed

% Initialize double pendulum simulation states
euler_method_1 = simulation(@Euler, g, m1, m2, L1, L2(1), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step, duration, dampening, normalize);
euler_method_2 = simulation(@Euler, g, m1, m2, L1, L2(2), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step, duration, dampening, normalize);

trapezoid_method_1 = simulation(@Trapezoid, g, m1, m2, L1, L2(1), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step, duration, dampening, normalize);
trapezoid_method_2 = simulation(@Trapezoid, g, m1, m2, L1, L2(2), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step, duration, dampening, normalize);

runge_kutta_method_1 = simulation(@RungeKutta, g, m1, m2, L1, L2(1), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step, duration, dampening, normalize);
runge_kutta_method_2 = simulation(@RungeKutta, g, m1, m2, L1, L2(2), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step, duration, dampening, normalize);

ode45_method_1 = simulation(@ODE45, g, m1, m2, L1, L2(1), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step, duration, dampening, normalize);
ode45_method_2 = simulation(@ODE45, g, m1, m2, L1, L2(2), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step, duration, dampening, normalize);

% Run simulations
euler_method_1.run()
euler_method_2.run()

trapezoid_method_1.run()
trapezoid_method_2.run()

runge_kutta_method_1.run()
runge_kutta_method_2.run()

ode45_method_1.run()
ode45_method_2.run()

% Plot theta over time
simulation.theta_plot(frame.ax2, frame.ax3, frame.ax5, frame.ax6, ...
    euler_method_1, ...
    euler_method_2, ...
    trapezoid_method_1, ...
    trapezoid_method_2, ...
    runge_kutta_method_1, ...
    runge_kutta_method_2, ...
    ode45_method_1, ...
    ode45_method_2)

% Animate simulation and plot results
euler_method_1.animate("Initial Condition 1 - Euler Method", animation_speed, frame.ax1)
euler_method_2.animate("Initial Condition 2 - Euler Method", animation_speed, frame.ax4)

trapezoid_method_1.animate("Initial Condition 1 - Trapezoid Method 1", animation_speed, frame.ax1)
trapezoid_method_2.animate("Initial Condition 2 - Trapezoid Method", animation_speed, frame.ax4)

runge_kutta_method_1.animate("Initial Condition 1 - Runge-Kutta Method", animation_speed, frame.ax1)
runge_kutta_method_2.animate("Initial Condition 2 - Runge-Kutta Method", animation_speed, frame.ax4)

ode45_method_1.animate("Initial Condition 1 - ode45 Method", animation_speed, frame.ax1)
ode45_method_2.animate("Initial Condition 2 - ode45 Method", animation_speed, frame.ax4)

% Performance plots
p_frame = simulation.initialize_performance();

simulation.performance_plot(euler_method_1, ode45_method_1, p_frame.ax1)
simulation.performance_plot(euler_method_2, ode45_method_2, p_frame.ax2)

simulation.performance_plot(trapezoid_method_1, ode45_method_1, p_frame.ax3)
simulation.performance_plot(trapezoid_method_2, ode45_method_2, p_frame.ax4)

simulation.performance_plot(runge_kutta_method_1, ode45_method_1, p_frame.ax5)
simulation.performance_plot(runge_kutta_method_2, ode45_method_2, p_frame.ax6)