% % Mass 2 Angular Acceleration
function theta2_doot = M2AA(g, m1, m2, theta1, theta1_dot, theta2, theta2_dot, L1, L2)
    numerator = 2 * sin(theta1 - theta2) * ((theta1_dot * theta1_dot) * L1 * (m1 + m2) + g * (m1 + m2) * cos(theta1) + (theta2_dot * theta2_dot) * L2 * m2 * cos(theta1 - theta2));    
    denominator = L2 * (2 * m1 + m2 - m2 * cos(2 * theta1 - 2 * theta2));
    theta2_doot = numerator / denominator;
end