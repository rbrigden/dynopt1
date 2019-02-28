function [final_angles, cost] = optimActiveSet( x, link_lengths, obs, low, high)
    num_links = numel(link_lengths);
    initial_angles = (2 * pi * rand(3, num_links)) - pi;
    options = optimoptions('fmincon', 'Algorithm','active-set');
    f = @(angles) objective(x, link_lengths, angles, obs);
    [final_angles, cost] = fmincon(f, initial_angles, [], [], [], [], low, high, [], options);
end
