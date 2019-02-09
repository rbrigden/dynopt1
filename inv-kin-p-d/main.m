% main for optimize 3 link inverse kinematics

global x_d p_d;
global l1 l2 l3
global h_axes link1 link2 link3 target

x_d = [0.5 0.5]'
% x_d = rand([2,1])

p_d = [0.0 0.0 0.0]'

l1 = 0.4;
l2 = 0.3;
l3 = 0.3;

% set up drawing stuff
initdraw

% p0 is the intitial parameter vector
p0=[0.0 0.0 0.0]'
% p0= (rand([3,1]) - 0.5)*2*pi

