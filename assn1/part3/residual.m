function [position_error] = residual(joint_positions, x)
    x_d = x(1:3);
    position_error = joint_positions(:, end) - x_d;
end
