function ConnectJoint(seq,i,a,b,currColor,currLineWidth)

    if ~exist('currColor','var')
        currColor = [0 0 0];
    end
    
    if ~exist('currLineWidth','var')
        currLineWidth = 1;
    end

    xplot = [seq(i,a(1)) seq(i,b(1))];
    yplot = [seq(i,a(2)) seq(i,b(2))];
    zplot = [seq(i,a(3)) seq(i,b(3))];
    plot3(xplot,yplot,zplot,'linewidth',currLineWidth,'Color',currColor);
    hold on;

end