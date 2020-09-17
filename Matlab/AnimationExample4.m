% animation_point.m

clear; close all;

% Create data
t = 0:0.001:1;   % Time data
x = sin(2*pi*t); % Position data

% Draw initial figure
figure(1);
set(gcf,'Renderer','OpenGL'); 
h = plot(x(1),0,'o','MarkerSize',20,'MarkerFaceColor','b');
% set(h,'EraseMode','normal');
xlim([-1.5,1.5]);
ylim([-1.5,1.5]);

% Animation Loop
i = 1;
while i<=length(x)
    set(h,'XData',x(i));
    drawnow;
    i = i+1;
end