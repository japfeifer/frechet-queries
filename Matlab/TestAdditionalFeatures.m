% test additional features

HIP  = [1,2,3]; SPIN = [4,5,6]; NECK = [7,8,9]; HEAD = [10,11,12];
LSHO = [13,14,15]; LELB = [16,17,18]; LWST = [19,20,21]; LHND = [22,23,24];
RSHO = [25,26,27]; RELB = [28,29,30]; RWST = [31,32,33]; RHND = [34,35,36];
LHIP = [37,38,39]; LKNE = [40,41,42]; LANK = [43,44,45]; LFOT = [46,47,48];
RHIP = [49,50,51]; RKNE = [52,53,54]; RANK = [55,56,57]; RFOT = [58,59,60];
SHO  = [61,62,63]; LTIP = [64,65,66]; LTHM = [67,68,69]; RTIP = [70,71,72]; RTHM = [73,74,75];
    
if trainQueryType == 1
    currSet = trainSet;
else
    currSet = querySet;
end

addFeat = [];

for fi = 1:size(currSet,1)
    currCompID = cell2mat(currSet(fi,1));
    currSeq = cell2mat(CompMoveData(currCompID,6));
    a = 1;

    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,RTIP,HEAD);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,RTIP,NECK);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,RTIP,SPIN);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,RTIP,HIP);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,RTIP,SHO);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,RTIP,RTHM);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,RTIP,RHND);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,RTIP,RWST);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,LTIP,HEAD);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,LTIP,NECK);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,LTIP,SPIN);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,LTIP,HIP);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,LTIP,SHO);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,LTIP,LTHM);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,LTIP,LHND);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,LTIP,LWST);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,RTIP,LTIP);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,RHND,HEAD);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,RHND,NECK);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,RHND,SPIN);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,RHND,HIP);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,RHND,SHO);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,RHND,RWST);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,LHND,HEAD);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,LHND,NECK);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,LHND,SPIN);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,LHND,HIP);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,LHND,SHO);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    [meanDist,MedDist,StddevDist] = GetJointDist(currSeq,LHND,RWST);
    addFeat(fi,a:a+2) = [meanDist MedDist StddevDist]; a = a + 3;
    
end

if trainQueryType == 1
    trainMat = [trainMat addFeat];
else
    testMat = [testMat addFeat];
end