classdef simulation
    properties
        integration_function
        gravity
        mass1
        mass2
        length1
        length2
        theta1
        theta1_dot
        theta2
        theta2_dot
        step
        duration
        thetas1 % Remove, for debugging
        thetas2 % Remove, for debugging
    end

    methods

        % Instantiate a simulation object with specified integration function
        % and initial conditions
        function obj = simulation(integration_function, gravity, mass1, mass2, length1, length2, theta1, theta1_dot, theta2, theta2_dot, step, duration)
            obj.integration_function = integration_function;
            obj.gravity = gravity;
            obj.mass1 = mass1;
            obj.mass2 = mass2;
            obj.length1 = length1;
            obj.length2 = length2;
            obj.theta1 = theta1;
            obj.theta1_dot = theta1_dot;
            obj.theta2 = theta2;
            obj.theta2_dot = theta2_dot;
            obj.step = step;
            obj.duration = duration;
            obj.thetas1 = zeros(1, floor(obj.duration / obj.step) + 1); % Remove, for debugging
            obj.thetas2 = zeros(1, floor(obj.duration / obj.step) + 1); % Remove, for debugging

        end
        
        % Run Simulation: Given initial conditions, compute subsequent states
        function run(obj)

            % Initial state
            pendulum_state = state(obj.theta1, obj.theta1_dot, obj.theta2, obj.theta2_dot);

            % Loop for each time step
            num_iterations = floor(obj.duration / obj.step) + 1;
            for t = 2:num_iterations
                pendulum_state = obj.integration_function(pendulum_state, obj.gravity, obj.mass1, obj.mass2, obj.length1, obj.length2, obj.step);
                
                % Store theta1 and theta2 in each state to plot / time
                obj.thetas1(t) = pendulum_state.theta1; % Remove, for debugging
                obj.thetas2(t) = pendulum_state.theta2; % Remove, for debugging
            end

            % Plot theta1 & theta2 / time
            xaxis = 0:obj.step:obj.duration;              % Remove, for debugging
            plot(xaxis, obj.thetas1, 'LineWidth', 1.5);   % Remove, for debugging
            hold on;                                      % Remove, for debugging
            plot(xaxis, obj.thetas2, 'LineWidth', 1.5);   % Remove, for debugging
            xlabel('Time (s)');                           % Remove, for debugging
            ylabel('\theta (rad)');                       % Remove, for debugging
            title('Double Pendulum \theta_1 and \theta_2 Over Time'); % R, f dbug
            legend('\theta_1', '\theta_2');  % Legend     % Remove, for debugging
            grid on;                                      % Remove, for debugging
            hold off;                                     % Remove, for debugging
        end
    end
end