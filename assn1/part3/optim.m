function [final_angles, cost, fmin_output] = optim( x, link_lengths, obs, low, high, options)
    num_links = numel(link_lengths);
    A = [1 0 0]';  
    initial_angles = repmat(A, 1,num_links) * -pi;
    f = @(angles) objective(x, link_lengths, angles, obs);
    [final_angles, cost ,exitflag, fmin_output] = fmincon(f, initial_angles, [], [], [], [], low, high, [], options);
    %final_angles = fmincon(f, initial_angles, [], [], [], [], low, high, [], options);
end
