function [position_error] = residual(joint_positions, x)
    x_d = x(1:3);
    x_q = x(3:7);

    % Euclidean distance between target and current effector end     
    delta_position = joint_positions(:, end) - x_d;
    
    % Angular difference between 
    
    position_error = delta_position;
end
