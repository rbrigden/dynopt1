function [final_angles] = optim( x, link_lengths, low, high)
    num_links = numel(link_lengths);
    initial_angles = (2 * pi * rand(3, num_links)) - pi;
    f = @(angles) objective(x, link_lengths, angles);
    [final_angles, cost] = fmincon(f, initial_angles, [], [], [], [], low, high);
end
