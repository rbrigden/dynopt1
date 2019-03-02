function [final_angles, cost, output] = optimActiveSet( x, link_lengths, obs, low, high)
    num_links = numel(link_lengths);
    initial_angles = (2 * pi * rand(3, num_links)) - pi;
    options = optimoptions('fmincon', 'Algorithm','active-set', 'Display', 'off');
    f = @(angles) objective(x, link_lengths, angles, obs);
    [final_angles, cost, ~, output] = fmincon(f, initial_angles, [], [], [], [], low, high, [], options);
end
