% % Initialize parameters

% System constants
g  = 9.81;            % gravity (m/s^2)
m1 = 1;               % mass 1 (kg)
m2 = 1;               % mass 2 (kg)
L1 = 1;               % pendulum arm 1 length (m)
L2 = [.25, .50];      % pendulum arm 2 length (m) - [1st simulation, 2nd simulation]

% Initial conditions
theta1_init = 1 / (3*pi);  % initial angle of arm 1 from equilibrium (radians)
theta1_dot  = 0;           % initial angular velocity of arm 1 (rad/s) 
theta2_init = 2 / (3*pi);  % initial angle of arm 2 from equilibrium (radians)
theta2_dot  = 0;           % initial angular velocity of arm 2 (rad/s)

% Simulation settings
t_step    = [0.1, .01];   % simulation timestamp precision (s/step) - [1st simulation, 2nd simulation]
duration  = 5;            % simulation duration (s)

% % Simulations

% Initialize plots
frame = simulation.initialize_plots(L1, L2);

% Initialize double pendulum simulation states
euler_method_1 = simulation(@euler_method, g, m1, m2, L1, L2(1), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step(1), duration);
euler_method_2 = simulation(@euler_method, g, m1, m2, L1, L2(2), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step(2), duration);

trapezoid_method_1 = simulation(@trapezoid_method, g, m1, m2, L1, L2(1), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step(1), duration);
trapezoid_method_2 = simulation(@trapezoid_method, g, m1, m2, L1, L2(2), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step(2), duration);

runge_kutta_method_1 = simulation(@runge_kutta_method, g, m1, m2, L1, L2(1), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step(1), duration);
runge_kutta_method_2 = simulation(@runge_kutta_method, g, m1, m2, L1, L2(2), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step(2), duration);

ode45_method_1 = simulation(@ode45_method, g, m1, m2, L1, L2(1), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step(1), duration);
ode45_method_2 = simulation(@ode45_method, g, m1, m2, L1, L2(2), theta1_init, theta1_dot, theta2_init, theta2_dot, t_step(2), duration);

% Run simulations
euler_method_1.run()
euler_method_2.run()

trapezoid_method_1.run()
trapezoid_method_2.run()

runge_kutta_method_1.run()
runge_kutta_method_2.run()

ode45_method_1.run()
ode45_method_2.run()

% Animate simulation and plot results
euler_method_1.theta_plot(frame.ax2)
euler_method_1.animate("Initial Condition 1 - Euler Method", 1.00, frame.ax1)

euler_method_2.theta_plot(frame.ax4)
euler_method_2.animate("Initial Condition 2 - Euler Method", 1.00, frame.ax3)

trapezoid_method_1.theta_plot(frame.ax2)
trapezoid_method_1.animate("Initial Condition 1 - Trapezoid Method 1", 1.00, frame.ax1)

trapezoid_method_2.theta_plot(frame.ax4)
trapezoid_method_2.animate("Initial Condition 2 - Trapezoid Method", 1.00, frame.ax3)

runge_kutta_method_1.theta_plot(frame.ax2)
runge_kutta_method_1.animate("Initial Condition 1 - Runge-Kutta Method", 1.00, frame.ax1)

runge_kutta_method_2.theta_plot(frame.ax4)
runge_kutta_method_2.animate("Initial Condition 2 - Runge-Kutta Method", 1.00, frame.ax3)

ode45_method_1.theta_plot(frame.ax2)
ode45_method_1.animate("Initial Condition 1 - Initial Condition ode45 Method", 1.00, frame.ax1)

ode45_method_2.theta_plot(frame.ax4)
ode45_method_2.animate("Initial Condition 2 - ode45 Method", 1.00, frame.ax3)

% % Performance plots
p_frame = simulation.initialize_performance();

simulation.performance_plot(euler_method_1, ode45_method_1, p_frame.ax1)
simulation.performance_plot(euler_method_2, ode45_method_2, p_frame.ax2)

simulation.performance_plot(trapezoid_method_1, ode45_method_1, p_frame.ax3)
simulation.performance_plot(trapezoid_method_2, ode45_method_2, p_frame.ax4)

simulation.performance_plot(runge_kutta_method_1, ode45_method_1, p_frame.ax5)
simulation.performance_plot(runge_kutta_method_2, ode45_method_2, p_frame.ax6)