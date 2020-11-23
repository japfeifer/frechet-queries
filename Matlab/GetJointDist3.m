
function [meanDist,MedDist,stddevDist,minDist,maxDist] = GetJointDist3(seq,fromJoint)

    A = [];
    for i=1:size(seq,1)
        dist = CalcPointDist(seq(1,fromJoint),seq(i,fromJoint));
        A = [A; dist];
    end
    
    meanDist = mean(A);
    MedDist = median(A);
    stddevDist = std(A);
    minDist = min(A);
    maxDist = max(A);
    
end
