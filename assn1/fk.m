function [joint_positions] = fk( link_lengths, joint_angles )

joint_positions = zeros(3, numel(link_lengths) + 1);

for link = size(link_lengths, 2) : -1 : 1
    % get a rotation matrix from the joint (Euler) angles     
    rotation = eul2rotm(joint_angles(:, link)');
    
    % translate along x because that is the principal axis of the link    
    translation = [ link_lengths(link) 0 0 ]';
    joint_positions(:, link + 1:end) = rotation * (joint_positions(:, link + 1:end) + translation);
end

end
