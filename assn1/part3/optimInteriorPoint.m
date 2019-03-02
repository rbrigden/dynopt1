function [final_angles, cost, output] = optimInteriorPoint( x, link_lengths, obs, low, high)
    num_links = numel(link_lengths);
    initial_angles = (2 * pi * rand(3, num_links)) - pi;
    f = @(angles) objective(x, link_lengths, angles, obs);
    options = optimoptions('fmincon','Display', 'off');
    [final_angles, cost, ~, output] = fmincon(f, initial_angles, [], [], [], [], low, high, [], options);
end
