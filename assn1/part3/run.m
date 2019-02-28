num_links = 6;

% TODO: Need to croak if we can't reach the final position given these
% link lengths.
link_lengths = ones(1, num_links) * 1.5;

% Position target
x_d = [2 2 2].';


if ~checkValidTarget(link_lengths, x_d)
    display("Cannot reach target. Will get as near as possible.");
end

% Overall target
x = x_d;

% Define obstables (x, y, z, r)
num_obstacles = 3;
obs = zeros(4, num_obstacles);

obs(:, 1) = [0.7 0.9 1.2 0.5].';
obs(:, 2) = [2 2 3 0.5].';
obs(:, 3) = [2 2 1 0.5].';
obs(:, 4) = [2 4 3 0.5];
obs(:, 5) = [3 2 3 0.5];

min_angle = - pi / 4;
max_angle = pi / 4;

% Joint angle limits
min_roll = min_angle * ones(1, num_links);
max_roll = max_angle * ones(1, num_links);

min_pitch = min_angle * ones(1, num_links);
max_pitch = max_angle * ones(1, num_links);

min_yaw = min_angle * ones(1, num_links);
max_yaw = max_angle * ones(1, num_links);

lower_bounds = [ min_yaw; min_pitch; min_roll ];
upper_bounds = [ max_yaw; max_pitch; max_roll ];

[final_angles_ip, obj_val_ip] = optimInteriorPoint(x, link_lengths, obs, lower_bounds, upper_bounds);
display(['(Interior Point) angles ', mat2str(final_angles_ip)])
display(['(Interior Point) obj func val ', num2str(obj_val_ip)])

[final_angles_sqp, obj_val_sqp] = optimSqp(x, link_lengths, obs, lower_bounds, upper_bounds);
display(['(SQP) angles ', mat2str(final_angles_sqp)])
display(['(SQP) obj func val ', num2str(obj_val_sqp)])

[final_angles_aset, obj_val_aset] = optimActiveSet(x, link_lengths, obs, lower_bounds, upper_bounds);
display(['(Active Set) angles ', mat2str(final_angles_aset)])
display(['(Active Set) obj func val ', num2str(obj_val_aset)])


% Do the forward kinematics again
[joint_positions] = fk(link_lengths, final_angles_aset);

draw3(joint_positions, obs);
