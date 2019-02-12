function cost = objective( x, link_lengths, angles)
  [points, final_rot] = fk(link_lengths, angles);
  [position_error] = residual(points, x);
  cost = sum(position_error .^ 2);
end
