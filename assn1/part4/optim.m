function [final_angles, cost] = optim( x, link_lengths, obs, low, high, initial_angles)
    num_links = numel(link_lengths);
    f = @(angles) objective(x, link_lengths, angles, obs);
    options = optimoptions(@fmincon, 'Display', 'off');
    [final_angles, cost] = fmincon(f, initial_angles, [], [], [], [], low, high,[], options);
end
