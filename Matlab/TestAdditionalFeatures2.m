% test additional features 2

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
% addFeat(1:size(currSet,1),1) = 0;

parfor fi = 1:size(currSet,1)
    currCompID = cell2mat(currSet(fi,1));
    currSeq = cell2mat(CompMoveData(currCompID,6));
    a = 1;
    tmpFeat = [];

    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RTIP,HEAD);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RTIP,NECK);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RTIP,SPIN);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RTIP,HIP);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RTIP,SHO);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RTIP,RTHM);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RTIP,RHND);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RTIP,RWST);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LTIP,HEAD);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LTIP,NECK);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LTIP,SPIN);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LTIP,HIP);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LTIP,SHO);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LTIP,LTHM);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LTIP,LHND);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LTIP,LWST);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RTIP,LTIP);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RHND,HEAD);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RHND,NECK);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RHND,SPIN);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RHND,HIP);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RHND,SHO);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RHND,RWST);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LHND,HEAD);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LHND,NECK);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LHND,SPIN);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LHND,HIP);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LHND,SHO);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LHND,RWST);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,HEAD,SHO);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,HEAD,RSHO);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,HEAD,LSHO);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RFOT,RKNE);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RFOT,RHIP);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,RANK,RHIP);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LFOT,LKNE);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LFOT,LHIP);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    [meanDist,medDist,stddevDist,minDist,maxDist] = GetJointDist2(currSeq,LANK,LHIP);
    tmpFeat(1,a:a+4) = [meanDist medDist stddevDist minDist maxDist]; a = a + 5;
    
    addFeat(fi,:) = tmpFeat;
end

if trainQueryType == 1
    trainMat = [trainMat addFeat];
else
    testMat = [testMat addFeat];
end

if trainQueryType == 1
    trainLabels = cell2mat(trainSet(:,2));
else
    testLabels = cell2mat(querySet(:,2));
end