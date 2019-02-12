function [joint_positions, final_rot] = fk( link_lengths, joint_angles )

joint_positions = zeros(3, numel(link_lengths) + 1);
final_rot = eye(3);

for i = numel(link_lengths) : -1 : 1
  rot = eul2rotm(joint_angles(:, i)');
  joint_positions(:, i + 1:end) = rot * (joint_positions(:, i + 1:end) + [ link_lengths(i) 0 0 ]');
  final_rot = rot * final_rot;
end

end
