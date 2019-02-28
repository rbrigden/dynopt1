num_links = 4;

% TODO: Need to croak if we can't reach the final position given these
% link lengths.
link_lengths = ones(1, num_links) * 2;

% Position target
x_d = [ 5 3 1 ].';

% Rotation target
x_q = [ 1 0 0 1 ].';

% Overall target
x = [ x_d ; x_q ];

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

N = 180;
for w = 1:N
    initial_angles = repmat(A, 1,num_links) * -(2 * w * pi)/N;
    [final_angles] = optim(x, link_lengths, obs, lower_bounds, upper_bounds, initial_angles);
end
draw3(joint_positions, obs);
