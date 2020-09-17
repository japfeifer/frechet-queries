% find intersection point in 2D space
function p = LineIntersect2D(p1,p2,p3,p4)
    p = [p1(1)*p2(2)-p2(1)*p1(2),p3(1)*p4(2)-p4(1)*p3(2)]/[p2(2)-p1(2),p4(2)-p3(2);-(p2(1)-p1(1)),-(p4(1)-p3(1))];
end