a = [41.50,   -70.95];
 b = [ 41.80 , -70.50];
 % straight line function from a to b
 func = @(x)a(2) + (a(2)-b(2))/(a(1)-b(1))*(x-a(1));
 % determine the x values
 x = linspace(a(1),b(1),50);
 % determine the y values
 y = func(x);
 % create the figure
 figure;
 % get a handle to a plot graphics object
 hPlot = plot(NaN,NaN,'ro');
 % set the axes limits
 xlim([min(a(1),b(1)) max(a(1),b(1))]);
 ylim([min(a(2),b(2)) max(a(2),b(2))]);
 % iterate through each point on line
 pause(0.5);
 for k=1:length(x)
     % update the plot graphics object with the next position
     set(hPlot,'XData',x(k),'YData',y(k));
     % pause for 0.5 seconds
     pause(0.1);
 end