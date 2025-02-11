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
        thetas1
        thetas2
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
            obj.thetas1 = zeros(1, floor(obj.duration / obj.step) + 1);
            obj.thetas2 = zeros(1, floor(obj.duration / obj.step) + 1);

        end
        
        % Run Simulation: Given initial conditions, compute subsequent states
        function run(obj)

            % Initial state
            pendulum_state = state(obj.theta1, obj.theta1_dot, obj.theta2, obj.theta2_dot);

            % Loop for each time step
            num_iterations = floor(obj.duration / obj.step) + 1;
            for t = 2:num_iterations
                pendulum_state = obj.integration_function(pendulum_state, obj.gravity, obj.mass1, obj.mass2, obj.length1, obj.length2, obj.step);
                
                % Store thetas for debugging
                obj.thetas1(t) = pendulum_state.theta1;
                obj.thetas2(t) = pendulum_state.theta2;
                disp(t);
            end

            xaxis = 0:obj.step:obj.duration;  % Proper time axis
            
            plot(xaxis, obj.thetas1, 'b', 'LineWidth', 1.5); % Theta 1 in blue
            hold on;
            plot(xaxis, obj.thetas2, 'r', 'LineWidth', 1.5); % Theta 2 in red
            
            xlabel('Time (s)');
            ylabel('\theta (rad)');
            title('Double Pendulum \theta_1 and \theta_2 Over Time');
            legend('\theta_1', '\theta_2');  % Adding the legend
            grid on;
            hold off;

            
            
        end
    end
end