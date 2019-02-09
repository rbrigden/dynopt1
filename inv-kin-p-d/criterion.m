function score = criterion(p)
%%% optimization criterion: p is vector of joint angles

global x_d p_d;

% do graphics
draw3(p);

x = fk(p);

score = (x - x_d)'*(x - x_d) + 0.05*(p - p_d)'*(p - p_d);

% final end
end
