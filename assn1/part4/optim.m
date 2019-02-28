function [final_angles] = optim( x, link_lengths, obs, low, high, initial_angles)
    num_links = numel(link_lengths);
    f = @(angles) objective(x, link_lengths, angles, obs);
    [final_angles, cost] = fmincon(f, initial_angles, [], [], [], [], low, high);
end
