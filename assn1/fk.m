function [joint_positions] = fk( link_lengths, joint_angles )

joint_positions = zeros(3, numel(link_lengths) + 1);
rot_matrix = ones(3);

%create rotation matrix which is an nx3x3 array
for k=1:size(link_lengths,2)
    rot_matrix(:,:,k) = 1;
end

for link = size(link_lengths, 2) : -1 : 1
    % get a rotation matrix from the joint (Euler) angles     
    rotation = eul2rotm(joint_angles(:, link)');
    
    %put rotation matrix in array 
    rot_matrix(:,:,link) = rotation;
    % translate along x because that is the principal axis of the link    
    translation = [link_lengths(link) 0 0]';
    
    % Basically we translate along x and then rotate with respect to the
    % frame of the previous joint. Each rotation rotates all of the
    % downstram links so at the end everything is rotated correctly with 
    % respect to the origin.     
    joint_positions(:, link+1:end) = rotation * (joint_positions(:, link+1:end) + translation);
end

display(rot_matrix);

final_rotation =  rot_matrix(:,:,4)*rot_matrix(:,:,3)*rot_matrix(:,:,2)*rot_matrix(:,:,1);
final_quaternion = rotm2quat(final_rotation);
display(final_quaternion);
end
