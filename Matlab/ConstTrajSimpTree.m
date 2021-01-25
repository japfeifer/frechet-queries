% Constructs a Trajectory Simplification Tree for input traj P
%
% Inputs:
% P - input trajectory vertices
% erd - error reduction factor from one tree level to the next
% mtl - maximum number of tree levels, i.e. this shows what level the leaves are at
%
% Global outputs:
% inpTrajVert - rows are vertices, columns levels, each level occupies one
%               column to store index to P's vertex 
% inpTrajPtr -  rows are vertices, columns levels, each level occupies one
%               column to store index to the next level vertices,
%               (the last level is not stored since it is the leaf level)
% inpTrajErr -  stores the error at each tree level (1 row, mtl columns)
% inpTrajSz -   stores the size of simplified P at each tree level (1 row, mtl columns)

function ConstTrajSimpTree(P,erd,mtl)

    global inpTrajVert inpTrajPtr inpTrajErr inpTrajSz 

    inpTrajVert = []; inpTrajPtr = []; inpTrajErr = []; inpTrajSz = []; 
    numDim = size(P,2);  % number of dimensions in P 
    numVert = size(P,1); % number of vertices in P
   
    % pre-populate inpTrajVert and inpTrajPtr (faster runtimes)
    inpTrajVert(1:numVert,1:mtl) = 0;
    inpTrajPtr(1:numVert,1:mtl-1) = 0;

    er = TrajReach(P); % get the root error which is reach of P
    
    % construct the tree
    for i = 1:mtl
        if i == 1 % we are at root
            inpTrajVert(1,1) = 1; % first vertex index of P
            inpTrajVert(2,1) = numVert; % last vertex index of P
            inpTrajErr(i) = er; % root has error that is the reach of the trajectory
            levelSzCnt = 2; % root has just 2 vertices (it is a single segment)
        else % we are at non-root parent
            levelSzCnt = 0;
            % construct each node at level i, and link each start/end node to its parent at level i-1 
            for j = 1:inpTrajSz(i-1) - 1  % loop through the segments from the level i-1 
                seIdx = inpTrajVert(j:j+1,i-1);  % get level i-1 segment start and end vertex index
                if i == mtl % leaf level
                    er = 0; % set error to 0
                end
                [simpP,idxListP] = DriemelSimp(P(seIdx(1,1):seIdx(2,1),:),er);  % simplify level i-1 curve using Driemel method
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

end