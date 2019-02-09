% optimize 3 link inverse kinematics

global x_d p_d;
global l1 l2 l3
global h_axes link1 link2 link3 target

x_d
p_d
p0

% do optimization
[answer,fval,exitflag]=fminunc(@criterion,p0);

answer
fval
exitflag

