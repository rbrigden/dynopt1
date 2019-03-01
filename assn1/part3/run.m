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

% Optimize joint angles (Just joint position. No rotation yet).
formatSpec = '%s took %f seconds, had a final cost of %f and ran for %d iterations\n';

algo = 'sqp';
options = optimoptions(@fmincon,'Algorithm',algo,'MaxFunctionEvaluations',1500, 'Display', 'off');
tic;
[final_angles, cost, output] = optim(x, link_lengths, obs, lower_bounds, upper_bounds, options);
timerVal = toc;
fprintf(formatSpec, algo, tic-timerVal, cost, output.iterations);

algo = 'interior-point';
options = optimoptions(@fmincon,'Algorithm',algo,'MaxFunctionEvaluations',1500, 'Display', 'off');
tic;
[final_angles, cost, output] = optim(x, link_lengths, obs, lower_bounds, upper_bounds, options);
timerVal = toc;
fprintf(formatSpec, algo, tic-timerVal, cost, output.iterations);

algo = 'active-set';
options = optimoptions(@fmincon,'Algorithm',algo,'MaxFunctionEvaluations',1500, 'Display', 'off');
tic;
[final_angles, cost, output] = optim(x, link_lengths, obs, lower_bounds, upper_bounds, options);
timerVal = toc;
fprintf(formatSpec, algo, timerVal, cost, output.iterations);