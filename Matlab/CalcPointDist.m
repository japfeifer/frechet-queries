function pointDist = CalcPointDist(u,v)    
    pointDist = sqrt(sum( (u-v).^2 ));
end