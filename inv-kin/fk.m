function pos = fk( joints )
% do forward kinematics of 3 link arm

global l1 l2 l3

a1 = joints(1);
a12 = joints(1) + joints(2);
a123 = joints(1) + joints(2) + joints(3);

pos1 = [l1*cos(a1) l1*sin(a1)]';
pos2 = pos1 + [l2*cos(a12) l2*sin(a12)]';
pos = pos2 + [l3*cos(a123) l2*sin(a123)]';
