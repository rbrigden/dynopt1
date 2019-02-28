num_links = 4;

% TODO: Need to croak if we can't reach the final position given these
% link lengths.
link_lengths = ones(1, num_links) * 2;

% Position target
x_d = [ 5 3 1 ].';

% Rotation target
x_q = [ 1 0 0 1 ].';

% Overall target
target = [ x_d ; x_q ];

% Define obstables (x, y, z, r)
num_obstacles = 3;
obs = zeros(4, num_obstacles);
obs(:, 1) = [0.5 0.5 0.5 0.1].';
obs(:, 2) = [0.3 0.2 0.4 0.2].';
obs(:, 3) = [2 2 1 0.5].';
obs(:, 4) = [5 2 -5 0.8];
obs(:,5) = [3 2 1 1.7];

% Joint angle limits
min_roll = (-pi / 2) * ones(1, num_links);
max_roll = (pi / 2) * ones(1, num_links);

min_pitch = (-pi / 2) * ones(1, num_links);
max_pitch = (pi / 2) * ones(1, num_links);

min_yaw = (-pi / 2) * ones(1, num_links);
max_yaw = ( pi / 2) * ones(1, num_links);

lower_bounds = [ min_yaw; min_pitch; min_roll ];
upper_bounds = [ max_yaw; max_pitch; max_roll ];


minCost = 0;
for x = 0: 1 : (2*pi)
    for y = 0: 1 : (2*pi)
        for z = 0: 1 : (2*pi)
            initial_angles = repmat([x y z].', 1,num_links) * pi;
            [final_angles, cost] = optim(target, link_lengths, obs, lower_bounds, upper_bounds, initial_angles);
            
            if (cost < minCost)
                minCost = cost;
                best_initial = initial_angles;
                best_final_angles = final_angles;
            end
        end 
    end
end
[joint_positions] = fk(link_lengths, best_final_angles);
draw3(joint_positions, obs);
