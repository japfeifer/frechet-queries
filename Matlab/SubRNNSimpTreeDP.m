% Function: SubRNNSimpTreeDP
%
% Perform a sub-trajectory RNN on query Qid using the simplification tree.
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

function SubRNNSimpTreeDP(Qid,alpha,level,sVertList,eVertList)

    global queryStrData inpTrajSz inpTrajPtr
    
    sumCellCheck = 0;
    sumDPCalls = 0;
    sumSPVert = 0;

    Q = queryStrData(Qid).traj; % query trajectory vertices and coordinates
    maxLevel = size(inpTrajSz,2); % the leaf level for the simplification tree

    for i = level+1:maxLevel % traverse the simplification tree one level at a time, start at level + 1
        
        % get this level sVertList,eVertList
        for j = 1:size(sVertList,1)
            sVertList(j,1) = inpTrajPtr(sVertList(j,1),i-1);
            eVertList(j,1) = inpTrajPtr(eVertList(j,1),i-1);
        end
        
        % get this level new list of start and end vertex points on input curve P
        [totCellCheck,totDPCalls,totSPVert,sP,eP] = SubRNNSimpTreeLevelDP(Q,alpha,i,sVertList,eVertList);
        sumCellCheck = sumCellCheck + totCellCheck;
        sumDPCalls = sumDPCalls + totDPCalls;
        sumSPVert = sumSPVert + totSPVert;
        
        % compute new sVertList,eVertList from sP,eP 
        sVertList = [];
        eVertList = [];
        if size(sP,1) > 0
            for j = 1:size(sP,1)
                sVertList(j,1) = sP(j,1);
                eVertList(j,1) = eP(j,1) + 1;
            end
        else
            break % we are done range search - no sub-traj were found within this range
        end
    end

    if size(sVertList,1) > 0
        queryStrData(Qid).sub2svert = sVertList(:,1);
        queryStrData(Qid).sub2sseginterior = sP(:,2);
        queryStrData(Qid).sub2evert = eVertList(:,1);
        queryStrData(Qid).sub2eseginterior = eP(:,2);
    else
        queryStrData(Qid).sub2svert = [];
        queryStrData(Qid).sub2sseginterior = [];
        queryStrData(Qid).sub2evert = [];
        queryStrData(Qid).sub2eseginterior = [];        
    end
    queryStrData(Qid).sub2fredist = alpha;
    queryStrData(Qid).sub2cntcellcheck = sumCellCheck;
    queryStrData(Qid).sub2cntdpcalls = sumDPCalls;
    queryStrData(Qid).sub2cntspvert = sumSPVert;

end