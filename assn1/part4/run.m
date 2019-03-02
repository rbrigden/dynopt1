num_links = 4;

% TODO: Need to croak if we can't reach the final position given these
% link lengths.
link_lengths = ones(1, num_links) * 2;

% Position target
target_d = [ 5 3 1 ].';

% Rotation target
target_q = [ 1 0 0 1 ].';

% Overall target
target = [ target_d ; target_q ];

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



totalRuns = 8;
costArray = zeros(2,totalRuns);
initialAnglesArray = zeros(3, num_links, totalRuns);
finalAnglesArray = zeros(3, num_links, totalRuns);

i = 1;
minCost = 0;
for x = 0: pi/3 : (2*pi)
    for y = 0: pi/3 : (2*pi)
        for z = 0: pi/3 : (2*pi)
            initial_angles = repmat([x y z].', 1, num_links);
            [final_angles, cost] = optim(target, link_lengths, obs, lower_bounds, upper_bounds, initial_angles);
            costArray(:,i) = [cost;i];
            initialAnglesArray(:,:,i) = initial_angles;
            finalAnglesArray(:,:,i) = final_angles;
            i = i+1;
        end 
    end
end

bestRuns = maxk(costArray,3,2);
bestInitialAngles = zeros(3, num_links, 3);
bestFinalAnglesArray = zeros(3, num_links, 3);

for costI = 1:totalRuns
    if costArray(1,costI) == bestRuns(1,1)
        bestInitialAngles(:,:,1) = initialAnglesArray(:,:,costI);
        bestFinalAnglesAngles(:,:,1) = finalAnglesArray(:,:,costI);
    end
    if costArray(1,costI) == bestRuns(1,2)
        bestInitialAngles(:,:,2) = initialAnglesArray(:,:,costI);
        bestFinalAnglesAngles(:,:,2) = finalAnglesArray(:,:,costI);
    end
    if costArray(1,costI) == bestRuns(1,3)
        bestInitialAngles(:,:,3) = initialAnglesArray(:,:,costI);
        bestFinalAnglesAngles(:,:,3) = finalAnglesArray(:,:,costI);
    end
end

[joint_positions] = fk(link_lengths, bestFinalAnglesAngles(:,:,1));
draw3(joint_positions, obs);
hold on

[joint_positions] = fk(link_lengths, bestFinalAnglesAngles(:,:,2));
draw3(joint_positions, obs);
hold on

[joint_positions] = fk(link_lengths, bestFinalAnglesAngles(:,:,3));
draw3(joint_positions, obs);
hold on
