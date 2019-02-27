function [gradient] = objGradient(joint_angles, link_lengths, target, obstacles)
    joint_positions = fk(link_lengths, joint_angles);
    nabla_cost_p = 2 * (joint_positions(size(link_lengths) - 1) - target);
    Jp


end