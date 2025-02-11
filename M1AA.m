% % Mass 1 Angular Acceleration
function theta1_doot = M1AA(g, m1, m2, theta1, theta1_dot, theta2, theta2_dot, L1, L2)
    numerator = (-1) * g * (2 * m1 + m2) * sin(theta1) - (m2 * g * sin(theta1 - (2 * theta2))) - 2 * sin(theta1 - theta2) * m2 * ((theta2_dot * theta2_dot) * L2 + (theta1_dot * theta1_dot) * L1 * cos(theta1 - theta2));
    denominator = L1 * (2 * m1 + m2 - m2 * cos(2 * theta1 - 2 * theta2));
    theta1_doot = numerator / denominator;
end