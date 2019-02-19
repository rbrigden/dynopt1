function draw3(joint_positions, obs)
    figure
        
    % Plot the links
    plot3(joint_positions(1, :), joint_positions(2, :), joint_positions(3, :))
    hold on

    % Plot the joint positions
    for i = 1 : size(joint_positions, 2)
        plot3(joint_positions(1, i), joint_positions(2, i), joint_positions(3, i), 'bo')
        hold on
    end
    
    
    % Plot the obstables
    for j = 1 : size(obs, 2)
        r = obs(4, j);
        [x, y, z] = ellipsoid(obs(1, j), obs(2, j), obs(3, j), r, r, r, 20);
        surf(x, y, z);
        hold on;
    end

    axis equal
    grid on
end
