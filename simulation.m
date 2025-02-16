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
    end % Properties

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
        end % Run

        % Animate double pendulum motion
        function animate(obj, title_name, frameax, speed)

            % % Establish pendulum subplot
            axes(frameax)
            title(title_name);
            % legend({'\theta_1', '\theta_2'}); -- Removed to improve performance (See loop below)
            hold on;

            % % Establish figure edges to center the pendulum

            % Initialize Pendulum Arms
            arm1 = plot([0, 0], [0, 0], 'Color', '#8357eb', 'LineWidth', 3);
            arm2 = plot([0, 0], [0, 0], 'Color', '#60a871', 'LineWidth', 3);

            % Initialize Pendulum Balls
            ball1 = plot(0, 0, 'o', 'MarkerSize', (11 * sqrt(obj.mass1)), 'MarkerFaceColor', '#8f390e', 'MarkerEdgeColor', 'k');
            ball2 = plot(0, 0, 'o', 'MarkerSize', (11 * sqrt(obj.mass2)), 'MarkerFaceColor', '#8f390e', 'MarkerEdgeColor', 'k');

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

                % Update legend -- Removed to improve performance
                % set(pendulum_legend, 'String', {sprintf('\\theta_1 = %.2f rad', obj.theta1_array(t)), sprintf('\\theta_2 = %.2f rad', obj.theta2_array(t))});

                % Step forward
                pause(obj.step * speed);
            end
        end % Animate

        function theta_plot(obj, frameax)

            % Establish subplot
            axes(frameax)
            xaxis = 0:obj.step:obj.duration;
            hold on;

            % Change all existing lines to black
            lines = findall(frameax, 'Type', 'Line');
            set(lines, 'Color', [0.7 0.7 0.7], 'LineWidth', 0.5); % Light gray (RGB: 0.7,0.7

            % Normalize thetas to [-π, π] (Avoid blowup plot)
            theta1_norm = mod(obj.theta1_array + pi, 2*pi) - pi;
            theta2_norm = mod(obj.theta2_array + pi, 2*pi) - pi;

            % Plot theta_1 and theta_2
            p1 = plot(xaxis, theta1_norm, 'LineWidth', 1.5, 'Color', '#8357eb');
            p2 = plot(xaxis, theta2_norm, 'LineWidth', 1.5, 'Color', '#60a871');
            legend([p1, p2], {'\theta_1', '\theta_2'});
        end
    end % Methods

    methods(Static)

        function frame = initialize_plots(L1, L2)

            frame = figure;
            figure(frame)

            % Animation subplots
            ax1 = subplot(2, 2, 1);
            max_L2 = max(L2);
            xlim([(-L1 - max_L2) * 1.1, (L1 + max_L2) * 1.1])
            ylim([(-L1 - max_L2) * 1.1, (L1 + max_L2) * 1.1])

            ax3 = subplot(2, 2, 3);
            max_L2 = max(L2);
            xlim([(-L1 - max_L2) * 1.1, (L1 + max_L2) * 1.1])
            ylim([(-L1 - max_L2) * 1.1, (L1 + max_L2) * 1.1])

            % Theta subplots
            ax2 = subplot(2, 2, 2);
            xlabel('Time (s)');
            ylabel('\theta (radians normalized to [-π, π])');
            title('Initial Condition 1 - \theta_1 and \theta_2 Over Time');
            grid on;

            ax4 = subplot(2, 2, 4);
            xlabel('Time (s)');
            ylabel('\theta (radians normalized to [-π, π])');
            title('Initial Condition 2 - \theta_1 and \theta_2 Over Time');
            grid on;

            frame = struct('figure', frame, 'ax1', ax1, 'ax2', ax2, 'ax3', ax3, 'ax4', ax4);
        end % initialize_subplots

        function pframe = initialize_performance()

            % Initialize performance subplots
            pframe = figure;
            figure(pframe)

            % IC subplots
            ax1 = subplot(3, 2, 1);
            title("Initial Condition 1 - Euler Performance Against ode45: Absolute Error in \theta_1 and \theta_2 Over Time")
            ax2 = subplot(3, 2, 2);
            title("Initial Condition 2 - Euler Performance Against ode45: Absolute Error in \theta_1 and \theta_2 Over Time")
            ax3 = subplot(3, 2, 3);
            title("Initial Condition 1 - Trapezoid Performance Against ode45: Absolute Error in \theta_1 and \theta_2 Over Time")
            ax4 = subplot(3, 2, 4);
            title("Initial Condition 2 - Trapezoid Performance Against ode45: Absolute Error in \theta_1 and \theta_2 Over Time")
            ax5 = subplot(3, 2, 5);
            title("Initial Condition 1 - Runge-Kutta Performance Against ode45: Absolute Error in \theta_1 and \theta_2 Over Time")
            ax6 = subplot(3, 2, 6);
            title("Initial Condition 2 - Runge-Kutta Performance Against ode45: Absolute Error in \theta_1 and \theta_2 Over Time")

            pframe = struct('figure', pframe, 'ax1', ax1, 'ax2', ax2, 'ax3', ax3, 'ax4', ax4, 'ax5', ax5, 'ax6', ax6);
        end % Initialize Performance Plots

        function performance_plot(actual, attempt, frameax)

            % Create plot
            axes(frameax);
            xaxis = 0:actual.step:actual.duration;
            hold on;
        
            % Compute the per-step absolute error
            theta1_error = abs(actual.theta1_array' - attempt.theta1_array);
            theta2_error = abs(actual.theta2_array' - attempt.theta2_array);
        
            % Plot the errors
            plot(xaxis, theta1_error, 'LineWidth', 1.5, 'Color', '#8357eb');
            plot(xaxis, theta2_error, 'LineWidth', 1.5, 'Color', '#60a871'); 
        
            % Label axes
            xlabel('Time (s)');
            ylabel('Error in \theta (radians)');
            legend({'Error in \theta_1', 'Error in \theta_2'});
            grid on;
        end % Plot Performance
    end % Methods (Static)
end % Class