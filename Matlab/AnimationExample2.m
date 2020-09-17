x = 0:.01:6;
y = sin(x);
px = 0;
py = 0;

 figure(100); %This is so it will replot over the previous figure, and not make a new one.
for i=1:100
   
    plot(x,y, px, py,'o');
    pause(0.1);
    px = px+6/100;
    py = sin(px);
end