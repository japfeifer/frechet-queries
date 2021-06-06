% Constructs a Trajectory Simplification Tree for input traj P
% Keeps on creating new levels until last parent level nodes each only have
% at most two vertices
%
% Inputs:
% P - input trajectory vertices
% erd - error reduction factor from one tree level to the next
%
% Global outputs:
% inpTrajVert - rows are vertices, columns levels, each level occupies one
%               column to store index to P's vertex 
% inpTrajPtr -  rows are vertices, columns levels, each level occupies one
%               column to store index to the next level vertices,
%               (the last level is not stored since it is the leaf level)
% inpTrajErr -  stores the error at each tree level (1 row, mtl columns)
% inpTrajSz -   stores the size of simplified P at each tree level (1 row, mtl columns)

function ConstTrajSimpTree3(P,erd,simpType)

    global inpTrajVert inpTrajPtr inpTrajErr inpTrajSz inpLen
    
    switch nargin
    case 2
        simpType = 1;
    end

    inpTrajVert = []; inpTrajPtr = []; inpTrajErr = []; inpTrajSz = []; inpTrajErrF = []; inpLen = [];
    mtl = 0; i = 0;
    numDim = size(P,2);  % number of dimensions in P 
    numVert = size(P,1); % number of vertices in P
   
    % pre-populate inpTrajVert and inpTrajPtr (faster runtimes)
    inpTrajVert(1:numVert,1:50) = 0;
    inpTrajPtr(1:numVert,1:50-1) = 0;

    er = TrajReach(P); % get the root error which is reach of P
    
    % construct the tree
    while er > 0 % loop until leaf level which has err = 0
        i = i + 1;
        if i == 1 % we are at root
            inpTrajVert(1,1) = 1; % first vertex index of P
            inpTrajVert(2,1) = numVert; % last vertex index of P
            inpTrajErr(i) = er; % root has error that is the reach of the trajectory
            levelSzCnt = 2; % root has just 2 vertices (it is a single segment)
        else % we are at non-root parent
            levelSzCnt = 0;
            leafFlg = 1;
            for j = 1:inpTrajSz(i-1) - 1 % check if we can make this the leaf level
                seIdx = inpTrajVert(j:j+1,i-1);  % get level i-1 segment start and end vertex index
                if seIdx(2,1) - seIdx(1,1) + 1 > 3 % the segment has > 3 vertices, so cannot make this the leaf level
                    leafFlg = 0;
                    break
                end
            end
            if leafFlg == 1 % we can make this the leaf level
                er = 0; % set error to 0
            end
            % construct each node at level i, and link each start/end node to its parent at level i-1 
            for j = 1:inpTrajSz(i-1) - 1  % loop through the segments from the level i-1 
                seIdx = inpTrajVert(j:j+1,i-1);  % get level i-1 segment start and end vertex index
                if seIdx(2,1) - seIdx(1,1) + 1 > 2 % the segment has > 2 vertices
                    if simpType == 1
                        [simpP,idxListP] = LinearSimp(P(seIdx(1,1):seIdx(2,1),:),er);  % simplify level i-1 curve using Driemel method
                    elseif simpType == 2
                        [simpP,idxListP] = BallSimp(P(seIdx(1,1):seIdx(2,1),:),er);  % simplify level i-1 curve using Intra-ball method
                    elseif simpType == 3
                        [simpP,idxListP] = AgarwalSimp(P(seIdx(1,1):seIdx(2,1),:),er);  % simplify level i-1 curve using Agarwal method
                    end
                else
                    simpP = P(seIdx(1,1):seIdx(2,1),:);
                    idxListP = [1 2];
                end
                for k = 1:size(simpP,1) % loop through each node at level i
                    if ~(k==1 && j > 1)
                        levelSzCnt = levelSzCnt + 1;
                        inpTrajVert(levelSzCnt,i) = idxListP(k) + seIdx(1,1) - 1;
                    end 
                    if k == 1
                        inpTrajPtr(j,i-1) = levelSzCnt;
                    end
                end
            end
            inpTrajPtr(inpTrajSz(i-1),i-1) = levelSzCnt; % update last inpTrajPtr for level i-1
        end
        inpTrajSz(i) = levelSzCnt;
        inpTrajErr(i) = er; % store the level error
        er = er / erd; % reduce error for next tree level
    end
    
    inpTrajVert = inpTrajVert(1:numVert,1:i);
    inpTrajPtr = inpTrajPtr(1:numVert,1:i-1);
    
    % for each parent level compute the segment lengths
    sz1 = size(inpTrajSz,2) - 1;
    inpLen(1:numVert,1:sz1) = 0; % pre-allocate memory
    for i = 1:sz1 % for each parent level
        idx1 = inpTrajVert(1:inpTrajSz(i),i);
        simpP = P(idx1,:);
        segLengths = GetSegLen(simpP);
        inpLen(1:size(segLengths,1),i) = segLengths;
    end
    inpLen = inpLen(1:size(segLengths,1),1:sz1);

end