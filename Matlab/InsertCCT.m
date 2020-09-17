
function InsertCCT(i,newTrajID,insType)

    global numInsCFD numInsDP queryTraj trajData clusterNode 
    global clusterTrajNode szNode

    PreprocessQuery(i); % compute the "query" BB, ST

    Q = cell2mat(queryTraj(i,1)); % insert traj

    if szNode > 0
        if insType == 1 % get exact NN
            NN(i,1,0);
            numInsCFD = numInsCFD + cell2mat(queryTraj(i,10));
            numInsDP = numInsDP + cell2mat(queryTraj(i,11));
        elseif insType == 2 % get implicit NN
            NN(i,3,0);
        elseif insType == 3 % standard method, 
            StandardInsertSearch(i);
        end

        % set some variables
        Pid = cell2mat(queryTraj(i,12)); % NN traj id - will become the parent of traj Q
        P = cell2mat(trajData(Pid,1)); % NN traj
        nnNodeID = clusterTrajNode(Pid,1); % NN traj node id

        if insType == 1 % get exact frechet distance
            distNN = ContFrechet(P,Q);
            numInsCFD = numInsCFD + 1;
        else % get UB (for both implicit NN, and standard methods)
            distNN = GetBestUpperBound(P,Q,1,Pid,i);
        end

        % perform insert
        % update leaf P that was NN to a parent node
        clusterNode(nnNodeID,2) = szNode+1;
        clusterNode(nnNodeID,3) = szNode+2;
        clusterNode(nnNodeID,4) = distNN;
        clusterNode(nnNodeID,5) = 2;
        clusterNode(nnNodeID,7) = newTrajID;

        % create new leaf - same traj as parent P
        clusterNode(szNode+1,1) = nnNodeID;
        clusterNode(szNode+1,2) = 0;
        clusterNode(szNode+1,3) = 0;
        clusterNode(szNode+1,4) = 0;
        clusterNode(szNode+1,5) = 1;
        clusterNode(szNode+1,6) = Pid;
        clusterNode(szNode+1,7) = Pid;

        % create new leaf Q - "query" traj that is inserted
        clusterNode(szNode+2,1) = nnNodeID;
        clusterNode(szNode+2,2) = 0;
        clusterNode(szNode+2,3) = 0;
        clusterNode(szNode+2,4) = 0;
        clusterNode(szNode+2,5) = 1;
        clusterNode(szNode+2,6) = newTrajID;
        clusterNode(szNode+2,7) = newTrajID;

        % update clusterTrajNode since one node id changed and one is inserted
        clusterTrajNode(Pid,1) = szNode+1; % NN found traj
        clusterTrajNode(newTrajID,1) = szNode+2; % newly inserted traj

        szNode = szNode + 2;
        
        % update ancestor node leaf counts, and potentially radii
        parentNodeID = clusterNode(nnNodeID,1);
        while parentNodeID ~= 0
            % update leaf count
            clusterNode(parentNodeID,5) = clusterNode(parentNodeID,5) + 1;

            % get up bnd from query (insert traj) to the centre traj
            centerTrajID = clusterNode(parentNodeID,6);
            centreTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
            upBnd = GetBestUpperBound(centreTraj,Q,1,centerTrajID,i);
            parentRad = clusterNode(parentNodeID,4);
            checkFreFlag = false;
            % potentially update the radius and furthest traj
            if upBnd > parentRad % newly inserted traj may be further than cluster radius
                if insType == 1
                    linRes = GetBestLinearLBDP(centreTraj,Q,parentRad,1,centerTrajID,i);
                    if linRes == true
                        checkFreFlag = true;
                    else
                        decProRes = FrechetDecide(centreTraj,Q,parentRad,1);
                        numInsDP = numInsDP + 1;
                        if decProRes == 0
                            checkFreFlag = true;
                        end
                    end

                    if checkFreFlag == true
                        currDist = ContFrechet(Q,centreTraj);
                        numInsCFD = numInsCFD + 1;
                        if currDist > parentRad
                            clusterNode(parentNodeID,4) = currDist; % update cluster radius
                            clusterNode(parentNodeID,7) = newTrajID; % update furthest traj ID to newly inserted traj ID
                        end
                    end
                else % just do UB (for both implicit NN, and standard methods)
                    clusterNode(parentNodeID,4) = upBnd; % update cluster radius
                    clusterNode(parentNodeID,7) = newTrajID; % update furthest traj ID to newly inserted traj ID
                end
            end

            % get the next higher parent 
            parentNodeID = clusterNode(parentNodeID,1);
        end

    else
        % this is the first node in CCT, just create the root
        clusterNode(szNode+1,1) = 0;
        clusterNode(szNode+1,2) = 0;
        clusterNode(szNode+1,3) = 0;
        clusterNode(szNode+1,4) = 0;
        clusterNode(szNode+1,5) = 1;
        clusterNode(szNode+1,6) = newTrajID;
        clusterNode(szNode+1,7) = newTrajID;

        clusterTrajNode(newTrajID,1) = szNode+1;
        
        szNode = szNode + 1;
    end

end

