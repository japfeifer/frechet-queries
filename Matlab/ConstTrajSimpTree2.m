% Constructs a Trajectory Simplification Tree for input traj P.
% Automatically determine number of tree levels and error for each level.
% Attempts to double the number of vertices at each level
%
% Inputs:
% P - input trajectory vertices
% polyExp - polylog exponent, used to determine number of times to seach
%           for optimal error value
% simpType - simplification type, 1 = Driemel, 2 = Intra-ball
%
% Global outputs:
% inpTrajVert - rows are vertices, columns levels, each level occupies one
%               column to store index to P's vertex 
% inpTrajPtr -  rows are vertices, columns levels, each level occupies one
%               column to store index to the next level vertices,
%               (the last level is not stored since it is the leaf level)
% inpTrajErr -  stores the error at each tree level (1 row, mtl columns)
% inpTrajSz -   stores the size of simplified P at each tree level (1 row, mtl columns)

function ConstTrajSimpTree2(P,polyExp,simpType,compFreErr)

    global inpTrajVert inpTrajPtr inpTrajErr inpTrajErrF inpTrajSz inpLen inpTrajRad

    switch nargin
    case 1
        polyExp = 2; % polylog exponent
        simpType = 1;
        compFreErr = 0;
    case 2
        simpType = 1;
        compFreErr = 0;
    case 3
        compFreErr = 0;
    end
    
    inpTrajVert = []; inpTrajPtr = []; inpTrajErr = []; inpTrajSz = []; inpTrajErrF = []; inpLen = []; inpTrajRad = [];
    numDim = size(P,2);  % number of dimensions in P 
    numVert = size(P,1); % number of vertices in P
   
    mtl = ceil(log2(numVert)); % number of levels in simplification tree
    
    % pre-populate inpTrajVert and inpTrajPtr (faster runtimes)
    inpTrajVert(1:numVert,1:mtl) = 0;
    inpTrajPtr(1:numVert,1:mtl-1) = 0;
    inpTrajRad(1:numVert,1:50-1) = 0;

    er = TrajReach(P); % get the root error which is reach of P
    
    % construct the tree
    for i = 1:mtl
        if i == 1 % we are at root
            inpTrajVert(1,1) = 1; % first vertex index of P
            inpTrajVert(2,1) = numVert; % last vertex index of P
            inpTrajRad(1,i) = er;
            levelSzCnt = 2; % root has just 2 vertices (it is a single segment)
        else % we are at non-root parent
            levelSzCnt = 0;
            radCnt = 0;
            if i == mtl % leaf level
                er = 0; % set error to 0
            else
                er = GetSimpTreeErr(P,pow2(i),polyExp,simpType);
            end
            % construct each node at level i, and link each start/end node to its parent at level i-1 
            for j = 1:inpTrajSz(i-1) - 1  % loop through the segments from the level i-1 
                seIdx = inpTrajVert(j:j+1,i-1);  % get level i-1 segment start and end vertex index
                if simpType == 1
                    [simpP,idxListP,radList] = LinearSimp(P(seIdx(1,1):seIdx(2,1),:),er);  % simplify level i-1 curve using Driemel method
                elseif simpType == 2
                    [simpP,idxListP] = BallSimp(P(seIdx(1,1):seIdx(2,1),:),er);  % simplify level i-1 curve using Intra-ball method
                elseif simpType == 3
                    [simpP,idxListP] = AgarwalSimp(P(seIdx(1,1):seIdx(2,1),:),er);  % simplify level i-1 curve using Agarwal method
                end
                for k = 1:size(simpP,1) % loop through each node at level i
                    if j == 1 || k > 1
                        levelSzCnt = levelSzCnt + 1;
                        inpTrajVert(levelSzCnt,i) = idxListP(k) + seIdx(1,1) - 1;
                    end 
                    if k == 1
                        inpTrajPtr(j,i-1) = levelSzCnt;
                    end
                end
                if er ~= 0
                    for k = 1:size(radList,1)
                        radCnt = radCnt + 1;
                        inpTrajRad(radCnt,i) = radList(k,1);
                    end
                end
            end
            inpTrajPtr(inpTrajSz(i-1),i-1) = levelSzCnt; % update last inpTrajPtr for level i-1
        end
        inpTrajSz(i) = levelSzCnt;
        inpTrajErr(i) = er; % store the level error
    end
    
    inpTrajVert = inpTrajVert(1:numVert,1:i);
    inpTrajPtr = inpTrajPtr(1:numVert,1:i-1);
    inpTrajRad = inpTrajRad(1:numVert,1:i-1);
    
    % for each parent level compute the segment lengths
    sz1 = size(inpTrajSz,2);
    for i = 1:sz1 % for each parent level
        idx1 = inpTrajVert(1:inpTrajSz(i),i);
        simpP = P(idx1,:);
        segLengths = GetSegLen(simpP);
        inpLen(1:size(segLengths,1),i) = segLengths;
    end
    
    % compute the Frechet distance from each segment in the tree to its underlying non-simp vertices
    inpTrajErrF(1:numVert-1,1:mtl-1) = Inf;
    if compFreErr == 1
        for i = 1:size(inpTrajSz,2) - 1 % for each parent level
            for j = 1:inpTrajSz(i) - 1 % for each segment in the level
                idx1 = inpTrajVert(j,i);
                idx2 = inpTrajVert(j+1,i);
                segP = P([idx1 idx2],:);
                nonsimpSegP = P(idx1:idx2,:);
                cDist = ContFrechet(segP,nonsimpSegP);
                inpTrajErrF(j,i) = cDist;
            end
        end
    end
    
end