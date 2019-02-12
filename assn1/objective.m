function cost = objective( x, link_lengths, angles)
  [joint_positions] = fk(link_lengths, angles);
  [position_error] = residual(joint_positions, x);
  cost = sum(position_error .^ 2);
end
