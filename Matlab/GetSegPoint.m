% gets point on line segment p1 p2, using val (if xyFlg = 1 then val is x, else it is y)
% use y = mx + b

function p = GetSegPoint(p1,p2,val,xyFlg)

    if p1(1) == p2(1) && xyFlg == 2
        p = p1(1);
    elseif p1(2) == p2(2) && xyFlg == 1
        p = p1(2);
    else
        m = (p2(2) - p1(2)) / (p2(1) - p1(1));
        b = p1(2) - (m * p1(1));

        if xyFlg == 1 % val is x coordinate, compute y
            p = (m*val) + b;
        else % val is y coordinate, compute x
            p = (val - b) / m;
        end
    end

end