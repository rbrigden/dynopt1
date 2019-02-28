function [final_angles, cost] = optimInteriorPoint( x, link_lengths, obs, low, high)
    num_links = numel(link_lengths);
    initial_angles = (2 * pi * rand(3, num_links)) - pi;
    f = @(angles) objective(x, link_lengths, angles, obs);
%    options = optimoptions('fmincon','Display','iter');
    [final_angles, cost] = fmincon(f, initial_angles, [], [], [], [], low, high);
end
