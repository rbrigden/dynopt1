function draw3(joint_positions)
    figure
        
    % Plot the links
    plot3(joint_positions(1, :), joint_positions(2, :), joint_positions(3, :))
    hold on

    % Plot the joint positions
    for i = 1 : size(joint_positions, 2)
        plot3(joint_positions(1, i), joint_positions(2, i), joint_positions(3, i), 'bo')
        hold on
    end

    axis equal
    grid on
end
