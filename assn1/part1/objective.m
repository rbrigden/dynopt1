function cost = objective( x, link_lengths, angles, obs)
  [joint_positions, final_q] = fk(link_lengths, angles);
  [position_error] = residual(joint_positions, x);
  obstacle_cost = obstacleCost(joint_positions, obs);
  orientation_cost = quatDistance(final_q, x(4:7));
  cost = sum(position_error .^ 2) + 0.2 * obstacle_cost + orientation_cost;
end
