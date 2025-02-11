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
        end

        function run(obj)

            % Initial state
            pendulum_state = state(obj.theta1, obj.theta1_dot, obj.theta2, obj.theta2_dot);

            % Loop for each time step
            for t = 0:obj.step:obj.duration
                pendulum_state = obj.integration_function(pendulum_state, obj.step);
            end

        end
    end
end