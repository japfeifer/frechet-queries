
function [meanDist,MedDist,StddevDist] = GetJointDist(seq,fromJoint,toJoint)

    A = [];
    for i=1:size(seq,1)
        dist = CalcPointDist(seq(i,fromJoint),seq(i,toJoint));
        A = [A; dist];
    end
    
    meanDist = mean(A);
    MedDist = median(A);
    StddevDist = std(A);
    
end
