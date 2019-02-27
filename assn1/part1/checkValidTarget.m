function [isValid] = checkValidTarget(link_lengths, target)
    target_pos = target(1:4);
    mag = sqrt(sum(target_pos .* target_pos))
    length = sum(link_lengths);
    isValid = length > mag;
end