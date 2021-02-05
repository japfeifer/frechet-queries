% Function: SubNNSimpTreeDP
%
% Perform a sub-trajectory NN on query Qid using the simplification tree.
% Can be used in conjunction with the CCT, i.e. the CCT search is run first and 
% the approximate result is returned (has tree level and start/end vertex Idx).
% Can also be used stand-alone, i.e. just call it from the root (level=1,sVertexList=1,eVertexList=2).
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

    global queryStrData inpTrajSz inpTrajPtr
    
    sumCellCheck = 0;
    sumDPCalls = 0;
    sumSPVert = 0;

    Q = queryStrData(Qid).traj; % query trajectory vertices and coordinates
    maxLevel = size(inpTrajSz,2); % the leaf level for the simplification tree
    
    loopCntList = [];
    loopCntList(1:maxLevel) = 0;
    loopCntList(maxLevel) = Inf;
    for i = 2:maxLevel
        loopCntList(i) = floor(40 / (maxLevel - i));
    end
    
    for i = level+1:maxLevel % traverse the simplification tree one level at a time, start at level + 1
        
        % get this level sVertList,eVertList
        for j = 1:size(sVertList,1)
            sVertList(j,1) = inpTrajPtr(sVertList(j,1),i-1);
            eVertList(j,1) = inpTrajPtr(eVertList(j,1),i-1);
        end
        
        % get this level new list of start and end vertex points on input curve P
        maxLoopCnt = loopCntList(i);
        [frechetDist,totCellCheck,totDPCalls,totSPVert,sP,eP] = ContFrechetSubTraj2(Q,i,sVertList,eVertList,maxLoopCnt);
        sumCellCheck = sumCellCheck + totCellCheck;
        sumDPCalls = sumDPCalls + totDPCalls;
        sumSPVert = sumSPVert + totSPVert;
        
        % compute new sVertList,eVertList from sP,eP 
        sVertList = [];
        eVertList = [];
        for j = 1:size(sP)
            sVertList(j,1) = sP(j,1);
            eVertList(j,1) = eP(j,1) + 1;
        end
    end

    queryStrData(Qid).subsvert = sVertList(1,1);
    queryStrData(Qid).subsseginterior = sP(1,2);
    queryStrData(Qid).subevert = eVertList(1,1);
    queryStrData(Qid).subeseginterior = eP(1,2);
    queryStrData(Qid).subfredist = frechetDist;
    queryStrData(Qid).subcntcellcheck = sumCellCheck;
    queryStrData(Qid).subcntdpcalls = sumDPCalls;
    queryStrData(Qid).subcntspvert = sumSPVert;

end