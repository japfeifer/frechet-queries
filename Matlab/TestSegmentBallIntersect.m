% test the function SegmentBallIntersect

disp(['----------']);

% 1) segment is outside ball
[sp,ep] = SegmentBallIntersect([3 0],[10 0],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

[sp,ep] = SegmentBallIntersect([10 0],[3 0],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

% 2) segment is in interior of ball 
[sp,ep] = SegmentBallIntersect([6.5 2],[7.5 2],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

[sp,ep] = SegmentBallIntersect([7.5 2],[6.5 2],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

[sp,ep] = SegmentBallIntersect([6.5 2],[6.5 4],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

[sp,ep] = SegmentBallIntersect([6.5 4],[6.5 2],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

% 3) segment intersects ball once - seg touches "edge" of ball
[sp,ep] = SegmentBallIntersect([3 1],[10 1],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

[sp,ep] = SegmentBallIntersect([10 1],[3 1],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

% 4) segment intersects ball once - seg starts in ball and exists
[sp,ep] = SegmentBallIntersect([6 3],[10 3],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

[sp,ep] = SegmentBallIntersect([6 3],[1 3],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

[sp,ep] = SegmentBallIntersect([7 2],[7 10],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

[sp,ep] = SegmentBallIntersect([7 4],[7 0],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

% 5) segment intersects ball once - seg starts outside ball and enters 
[sp,ep] = SegmentBallIntersect([0 3],[8 3],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

[sp,ep] = SegmentBallIntersect([12 3],[8 3],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

[sp,ep] = SegmentBallIntersect([7 0],[7 4],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

[sp,ep] = SegmentBallIntersect([7 10],[7 4],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

% 6) segment intersects ball twice - seg starts outside ball and enters and then exits
[sp,ep] = SegmentBallIntersect([0 3],[12 3],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

[sp,ep] = SegmentBallIntersect([12 3],[0 3],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

[sp,ep] = SegmentBallIntersect([7 0],[7 10],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);

[sp,ep] = SegmentBallIntersect([7 10],[7 0],[7 3],2,0);
disp(['sp: ',num2str(sp),' ep: ',num2str(ep)]);