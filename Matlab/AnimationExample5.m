clc; clear all ;
x = rand(4,1) ;
y = rand(4,1) ;
for i = 1:20
    z = rand(4,1) ;
    plot3(x,y,z) ;
    drawnow
    pause(0.2)
end