
function [meanAng,medAng,stddevAng,minAng,maxAng] = GetJointAng(seq,joint1,joint2,joint3)

    A = [];
    for i=1:size(seq,1)
        ang = AngDeg3DVec(seq(i,joint1),seq(i,joint2),seq(i,joint3));
        A = [A; ang];
    end
    
    meanAng = mean(A);
    medAng = median(A);
    stddevAng = std(A);
    minAng = min(A);
    maxAng = max(A);
    
end
