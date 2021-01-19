function ConnectJoint(seq,i,a,b,currColor,currLineWidth)

    switch nargin
    case 4
        currColor = [0 0 0];
        currLineWidth = 1;
    case 5
        currLineWidth = 1;
    end
        
    xplot = [seq(i,a(1)) seq(i,b(1))];
    yplot = [seq(i,a(2)) seq(i,b(2))];
    zplot = [seq(i,a(3)) seq(i,b(3))];
    plot3(xplot,yplot,zplot,'linewidth',currLineWidth,'Color',currColor);
    hold on;

end