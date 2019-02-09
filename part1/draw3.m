function pos = draw3( joints )
% do forward kinematics of 3 link arm

global x_d;
global l1 l2 l3
global h_axes


a1 = joints(1);
a12 = joints(1) + joints(2);
a123 = joints(1) + joints(2) + joints(3);

pos1 = [l1*cos(a1) l1*sin(a1) 0]';
pos2 = pos1 + [l2*cos(a12) l2*sin(a12) 0]';
pos = pos2 + [l3*cos(a123) l2*sin(a123) 0]';

origin = [0 0 0]';
pos1 = [origin pos1];
pos2 = [pos1 pos2];
pos = [pos2 pos];

hold on

plot3(pos1(1, :), pos1(2, :), pos1(3, :), 'visible', 'on', 'Parent', h_axes, 'LineWidth',3, 'Color', [0 1 0]);

plot3(pos2(1, :), pos2(2, :), pos2(3, :), 'visible', 'on', 'Parent', h_axes, 'LineWidth',3, 'Color', [1 0 0]);

plot3(pos(1, :), pos(2, :), pos(3, :), 'visible', 'on', 'Parent', h_axes, 'LineWidth', 3, 'Color', 'r')

% Draw the target
% plot3([x_d(1)-0.01 x_d(1)+0.01],[x_d(2)-0.01 x_d(2)+0.01],[-0.01 0.01], ...
%   'visible', 'on', 'Parent', h_axes, 'LineWidth', 1)


% set(link1,'Parent',h_axes,'Xdata',[0 pos1(1)], ...
% 'Ydata',[0 pos1(2)],'Zdata',[0, 0], 'visible','on');
% set(link2,'Parent',h_axes,'Xdata',[pos1(1) pos2(1)], ...
% 'Ydata', [pos1(2)  pos2(2)],'Zdata',[0, 0], 'visible','on');
% set(link3,'Parent',h_axes,'Xdata',[pos2(1) pos(1)], ...
% 'Ydata', [pos2(2) pos(2)],'Zdata',[0, 0], 'visible','on');
% set(target,'Parent',h_axes,'Xdata',[x_d(1)-0.01 x_d(1)+0.01], ...
% 'Ydata', [x_d(2)-0.01 x_d(2)+0.01],'Zdata', [0, 0],'visible','on');
drawnow
% delay
 for j = 1:1000000
   z = sin(sqrt(100.0*j));
 end

end
