classdef state
    properties
        theta1
        theta1_dot
        theta2
        theta2_dot
    end
    
    methods
        function obj = state(theta1, theta1_dot, theta2, theta2_dot)
            obj.theta1 = theta1;
            obj.theta1_dot = theta1_dot;
            obj.theta2 = theta2;
            obj.theta2_dot = theta2_dot;
        end
    end
end