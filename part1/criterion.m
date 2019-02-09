function score = criterion(p)
%%% optimization criterion: p is vector of joint angles

global x_d;

% do graphics
draw3(p);

x = fk(p);

score = (x - x_d)'*(x-x_d);

% final end
end
