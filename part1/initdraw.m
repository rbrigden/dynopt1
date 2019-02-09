% global h_axes link1 link2 link3 target

scrsz = get(0,'ScreenSize');
animation = figure(1);

color0 = [0 0 0];
color1 = [1 0 0];
color2 = [0 0 1];
color3 = [0 1 0];
color4 = [1 0 1];

set(animation,'name','My Robot','Position',[20 100 500 500]);
h_axes = axes('Parent',animation,'Units','Pixels','Position',[0 0 500 500],'Ylim',[-1.0 1.0],'Xlim',[-1.0 1.0], 'Zlim',[-1.0 1.0]);
% 
% target = line('Parent',h_axes,'Color',color4,'Visible','off','LineWidth',10);
% link1 = line('Parent',h_axes,'Color',color1,'Visible','off','LineWidth',10);
% link2 = line('Parent',h_axes,'Color',color2,'Visible','off','LineWidth',10);
% link3 = line('Parent',h_axes,'Color',color3,'Visible','off','LineWidth',10);

% set(h_axes,'visible','on');
