function cost = objective( x, link_lengths, angles, obs)
  [joint_positions] = fk(link_lengths, angles);
  [position_error] = residual(joint_positions, x);
  %[obstacle_cost] = obstacleCost(joint_positions, obs);
  cost = sum(position_error .^ 2); %+ 0.2 * obstacle_cost;
end
