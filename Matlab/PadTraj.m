% Pad Traj with a certain number of vertices between each original vertex
% in the Traj.  This is required to get better results from the discrete
% frechet distance function as it only looks at vertices in it's calc, and
% the distances between vertices can cause large errors.
% Works for N-dimensional trajectories.

function newP = PadTraj(P,numVert)
    vertDiff = [];
    newP = [];
    nextVert = [];
    sP = size(P,1);
    
    if numVert == 0 && sP <=32
        if sP <=2
            numVert = 64;
        elseif sP <= 4
            numVert = 16;
        elseif sP <= 8
            numVert = 8;
        elseif sP <= 16
            numVert = 4;
        elseif sP <= 32
            numVert = 1;
        else
            numVert = 0;
        end
    end
    
    if numVert > 0
        for j = 1:sP % for each vertex
            if j==1
                newP = P(j,:); % set newP to first vertex
            else
                % determine diff between current vertex and prev vertex
                vertDiff = P(j,:) - P(j-1,:);
                % insert one or more vertices
                for i = 1:numVert
                    nextVert = ((vertDiff / (numVert + 1)) * i) + P(j-1,:);
                    newP = [newP; nextVert];
                end
                % insert current vertex in P
                newP = [newP; P(j,:)];
            end        
        end
    else
        newP = P;
    end
    
end
