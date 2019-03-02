function cost = objective( x, link_lengths, angles, obs)
  [joint_positions] = fk(link_lengths, angles);
  [position_error] = residual(joint_positions, x);
  obstacle_cost = obstacleCost(joint_positions, obs);
  lambda = 0.12;
  cost = (1.0 - lambda) * sum(position_error .^ 2) + lambda * obstacle_cost ;
end
