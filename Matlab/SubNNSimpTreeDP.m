% Function: SubNNSimpTreeDP
%
% Perform a sub-trajectory NN on query Qid using the simplification tree.
% 
% Inputs:
% Qid - query ID
% level - simplification tree level to start at
% sVertexList - start vertex list in simplification tree
% eVertexList - end vertex list in simplification tree
%
% Outputs:
% queryStrData - various results stored here

function SubNNSimpTreeDP(Qid,level,sVertList,eVertList)

    global queryStrData inpTrajSz inpTrajPtr inP
    
    tSearch = tic;
    
    sumCellCheck = 0;
    sumDPCalls = 0;
    sumSPVert = 0;
    sumUBVert = 0;
    totTimeUB = 0;
    totTimeSP = 0;
    totTimeDP = 0;
    maxBnd = 0;
    subtrajSz = []; % size of each sub-traj candidate, cols: level, size, start vertex, end vertex

    Q = queryStrData(Qid).traj; % query trajectory vertices and coordinates
    maxLevel = size(inpTrajSz,2); % the leaf level for the simplification tree
    
    loopCntList = [];
    loopCntList(1:maxLevel) = 0;
    loopCntList(maxLevel) = Inf;
    for i = 2:maxLevel
%         loopCntList(i) = floor(40 / (maxLevel - i));
        loopCntList(i) = i;
        if i==maxLevel
            loopCntList(i) = Inf;
        end
    end
    
    for i = level+1:maxLevel % traverse the simplification tree one level at a time, start at level + 1
        
        % get this level sVertList,eVertList
        for j = 1:size(sVertList,1)
            sVertList(j,1) = inpTrajPtr(sVertList(j,1),i-1);
            eVertList(j,1) = inpTrajPtr(eVertList(j,1),i-1);
        end
        
        % get this level new list of start and end vertex points on input curve P
        maxLoopCnt = loopCntList(i);
        [lowBnd,upBnd,totCellCheck,totDPCalls,totSPVert,totUBVert,sP,eP,timeUB,timeSP,timeDP,maxBnd,levelSubTrajSz] = ...
            SubNNSimpTreeLevelDP(Q,i,sVertList,eVertList,maxLoopCnt,1);
        sumCellCheck = sumCellCheck + totCellCheck;
        sumDPCalls = sumDPCalls + totDPCalls;
        sumSPVert = sumSPVert + totSPVert;
        sumUBVert = sumUBVert + totUBVert;
        totTimeUB = totTimeUB + timeUB;
        totTimeSP = totTimeSP + timeSP;
        totTimeDP = totTimeDP + timeDP;
        subtrajSz = [subtrajSz; levelSubTrajSz];
        
        % compute new sVertList,eVertList from sP,eP 
        sVertList = [];
        eVertList = [];
        for j = 1:size(sP,1)
            sVertList(j,1) = sP(j,1);
            eVertList(j,1) = eP(j,1) + 1;
        end
    end
    
    timeSearch = toc(tSearch);

    queryStrData(Qid).sub2svert = sP(1,1);
    queryStrData(Qid).sub2sseginterior = sP(1,2);
    queryStrData(Qid).sub2evert = eP(1,1);
    queryStrData(Qid).sub2eseginterior = eP(1,2);
    queryStrData(Qid).sub2lb = lowBnd;
    queryStrData(Qid).sub2ub = upBnd;
    queryStrData(Qid).sub2szinP = size(inP,1);
    queryStrData(Qid).sub2cntdpcalls = sumDPCalls;
    queryStrData(Qid).sub2cntcellcheck = sumCellCheck;
    queryStrData(Qid).sub2cntspvert = sumSPVert;
    queryStrData(Qid).sub2cntubvert = sumUBVert;
    queryStrData(Qid).sub2timesearch = timeSearch;
    queryStrData(Qid).sub2timeub = totTimeUB;
    queryStrData(Qid).sub2timesp = totTimeSP;
    queryStrData(Qid).sub2timedp = totTimeDP;
    queryStrData(Qid).sub2subtrajsz = subtrajSz;

end