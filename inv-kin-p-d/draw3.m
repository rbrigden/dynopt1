function pos = draw3( joints )
% do forward kinematics of 3 link arm

global x_d;
global l1 l2 l3
global h_axes link1 link2 link3 target

a1 = joints(1);
a12 = joints(1) + joints(2);
a123 = joints(1) + joints(2) + joints(3);

pos1 = [l1*cos(a1) l1*sin(a1)]';
pos2 = pos1 + [l2*cos(a12) l2*sin(a12)]';
pos = pos2 + [l3*cos(a123) l2*sin(a123)]';

set(link1,'Parent',h_axes,'Xdata',[0 pos1(1)], ...
'Ydata',[0 pos1(2)],'visible','on');
set(link2,'Parent',h_axes,'Xdata',[pos1(1) pos2(1)], ...
'Ydata', [pos1(2)  pos2(2)],'visible','on');
set(link3,'Parent',h_axes,'Xdata',[pos2(1) pos(1)], ...
'Ydata', [pos2(2) pos(2)],'visible','on');
set(target,'Parent',h_axes,'Xdata',[x_d(1)-0.01 x_d(1)+0.01], ...
'Ydata', [x_d(2)-0.01 x_d(2)+0.01],'visible','on');
drawnow
% delay
 for j = 1:1000000
   z = sin(sqrt(100.0*j));
 end

end
