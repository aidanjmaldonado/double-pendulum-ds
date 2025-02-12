classdef simulation < handle % 'handle' ensures that the object properties can be updated within its methods
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
        theta1_array
        theta2_array
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
            obj.theta1_array = zeros(1, floor(obj.duration / obj.step) + 1);
            obj.theta2_array = zeros(1, floor(obj.duration / obj.step) + 1);

        end
        
        % Run Simulation: Given initial conditions, compute subsequent states
        function run(obj)

            % Initial state
            pendulum_state = state(obj.theta1, obj.theta1_dot, obj.theta2, obj.theta2_dot);

            % Loop for each time step if not ode45 method
            num_iterations = floor(obj.duration / obj.step) + 1;

            if ~(strcmp(func2str(obj.integration_function), 'ode45_method')) % Not ode45 case
                for t = 1:num_iterations
                    pendulum_state = obj.integration_function(pendulum_state, obj.gravity, obj.mass1, obj.mass2, obj.length1, obj.length2, obj.step);
                    
                    % Store theta1 and theta2 in each state to plot / time
                    obj.theta1_array(t) = pendulum_state.theta1;
                    obj.theta2_array(t) = pendulum_state.theta2;
                end
            else % ode45 case
                state_array = obj.integration_function(obj.gravity, obj.mass1, obj.mass2, obj.length1, obj.length2, obj.theta1, obj.theta1_dot, obj.theta2, obj.theta2_dot, obj.step, obj.duration);
                obj.theta1_array = state_array(:, 1);
                obj.theta2_array = state_array(:, 3);
            end
        end

        % Animate double pendulum motion
        function animate(obj, title_name)

            
            % Establish figure edges to center the pendulum
            theta_legend = legend({sprintf('\\theta_1 = %.2f rad', obj.theta1_array(1)), sprintf('\\theta_2 = %.2f rad', obj.theta2_array(1))},'Location', 'northeast');

            % % Initialize
            % Pendulum Arms
            arm1 = plot([0, 0], [0, 0], 'Color', '#4DBEEE', 'LineWidth', 3);
            arm2 = plot([0, 0], [0, 0], 'Color', '#4DBEEE', 'LineWidth', 3);

            % Pendulum Balls
            ball1 = plot(0, 0, 'o', 'MarkerSize', 11, 'MarkerFaceColor', '#D95319', 'MarkerEdgeColor', 'k');
            ball2 = plot(0, 0, 'o', 'MarkerSize', 11, 'MarkerFaceColor', '#D95319', 'MarkerEdgeColor', 'k');

            % % Update Animation
            num_iterations = floor(obj.duration / obj.step) + 1;

            for t = 1:num_iterations
                
                % Get new joint positions
                arm1_bot_x = obj.length1 * sin(obj.theta1_array(t));
                arm1_bot_y = -obj.length1 * cos(obj.theta1_array(t));

                arm2_top_x = arm1_bot_x;
                arm2_top_y = arm1_bot_y;

                arm2_bot_x = arm2_top_x + obj.length2 * sin(obj.theta2_array(t));
                arm2_bot_y = arm2_top_y - obj.length2 * cos(obj.theta2_array(t));

                % Replace joint positions
                set(arm1, 'XData', [0, arm1_bot_x], 'YData', [0, arm1_bot_y]);
                set(arm2, 'XData', [arm2_top_x, arm2_bot_x], 'YData', [arm2_top_y, arm2_bot_y]);
                set(ball1, 'XData', arm1_bot_x, 'YData', arm1_bot_y);
                set(ball2, 'XData', arm2_bot_x, 'YData', arm2_bot_y);
                title(title_name);

                % Update legend
                set(theta_legend, 'String', {sprintf('\\theta_1 = %.2f rad', obj.theta1_array(t)), sprintf('\\theta_2 = %.2f rad', obj.theta2_array(t))});

                % Step forward
                pause(obj.step);
            end
        end
    end
end