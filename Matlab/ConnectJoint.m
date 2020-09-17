function ConnectJoint(seq,i,a,b)

    xplot = [seq(i,a(1)) seq(i,b(1))];
    yplot = [seq(i,a(2)) seq(i,b(2))];
    zplot = [seq(i,a(3)) seq(i,b(3))];
    plot3(xplot,yplot,zplot,'-k','linewidth',1,'markerfacecolor','b');
    hold on;

end