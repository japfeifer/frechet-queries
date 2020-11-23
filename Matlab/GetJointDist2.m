
function [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(seq,fromJoint,toJoint)

    A = [];
    for i=1:size(seq,1)
        dist = CalcPointDist(seq(i,fromJoint),seq(i,toJoint));
        A = [A; dist];
    end
    
    meanDist = mean(A);
    medDist = median(A);
    stddevDist = std(A);
    minDist = min(A);
    maxDist = max(A);
    
end
