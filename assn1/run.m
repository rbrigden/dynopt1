num_links = 4;

% TODO: Need to croak if we can't reach the final position given these
% link lengths.
link_lengths = ones(1, num_links) * 2;

% Position target
x_d = [ 5 5 1 ].';

% Rotation target
x_q = [ 1 0 0 0 ].';

% Overall target
x = [ x_d ; x_q ];

% Joint angle limits
min_roll = (-pi / 2) * ones(1, num_links);
max_roll = (pi / 2) * ones(1, num_links);

min_pitch = (-pi / 2) * ones(1, num_links);
max_pitch = (pi / 2) * ones(1, num_links);

min_yaw = (-pi / 2) * ones(1, num_links);
max_yaw = ( pi / 2) * ones(1, num_links);

lower_bounds = [ min_yaw; min_pitch; min_roll ];
upper_bounds = [ max_yaw; max_pitch; max_roll ];

% Optimize joint angles (Just joint position. No rotation or obstacles yet).
[final_angles] = optim(x, link_lengths, lower_bounds, upper_bounds);

% Do the forward kinematics again
[joint_positions, final_rot] = fk(link_lengths, final_angles);
draw3(joint_positions);
