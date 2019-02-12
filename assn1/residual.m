function [position_error] = residual(joint_positions, x)
    delta_position = joint_positions(:, end) - x(1:3);
    position_error = delta_position;
end
