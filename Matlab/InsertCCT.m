
function newTrajID = InsertCCT(i,newTrajID,insType,doQPreproc,errFlg,err)

%     global queryTraj trajData
    global trajStrData queryStrData
    
    global numInsCFD numInsDP clusterNode 
    global clusterTrajNode szNode
    
    global time2 time3 time4 t2 t3 t4
    
    time2 = 0; time3 = 0; time4 = 0;
    
    switch nargin
    case 3
        doQPreproc = 1;
        errFlg = 0;
        err = 0;
    case 4
        errFlg = 0;
        err = 0;
    end

    if doQPreproc == 1
        PreprocessQuery(i); % compute the "query" BB, ST
    end

%     Q = cell2mat(queryTraj(i,1)); % insert traj
    Q = queryStrData(i).traj;

    if szNode > 0
        t2 = tic;
        if insType == 1 || errFlg == 1 % get exact NN
            NN(i,1,0);
%             numInsCFD = numInsCFD + cell2mat(queryTraj(i,10));
%             numInsDP = numInsDP + cell2mat(queryTraj(i,11));
            numInsCFD = numInsCFD + queryStrData(i).decidecfdcnt;
            numInsDP = numInsDP + queryStrData(i).decidedpcnt;
        elseif insType == 2 % get implicit NN
            NN(i,3,0);
        elseif insType == 3 % standard method, 
            StandardInsertSearch(i);
        end
        time2 =  toc(t2);

        % set some variables
%         Pid = cell2mat(queryTraj(i,12)); % NN traj id - will become the parent of traj Q
        Pid = queryStrData(i).decidetrajids;
%         P = cell2mat(trajData(Pid,1)); % NN traj
        P = trajStrData(Pid).traj;
        nnNodeID = clusterTrajNode(Pid,1); % NN traj node id

        t3 = tic;
        if insType == 1 % get exact frechet distance
            distNN = ContFrechet(P,Q);
            numInsCFD = numInsCFD + 1;
        else % get UB (for both implicit NN, and standard methods)
            distNN = GetBestUpperBound(P,Q,1,Pid,i);
        end
        time3 =  toc(t3);
        
        if errFlg == 1 % check if we should insert, i.e. insert if NN is > err distance away
            doIns = 1;
            if distNN > err
                unsimpP = trajStrData(Pid).ustraj;
                unsimpQ = queryStrData(i).ustraj;
                ans = FrechetDecide(unsimpP,unsimpQ,err,1); % use unsimplified P and Q
                if ans == 1
                    doIns = 0;
                end
            end
        end

        if doIns == 1
            t4 = tic;
            % perform insert
            % update leaf P that was NN to a parent node
            clusterNode(nnNodeID,2) = szNode+1;
            clusterNode(nnNodeID,3) = szNode+2;
            clusterNode(nnNodeID,4) = distNN;
            clusterNode(nnNodeID,5) = 2;
            clusterNode(nnNodeID,7) = newTrajID;

            % create new leaf - same traj as parent P
            clusterNode(szNode+1,1:7) = [nnNodeID 0 0 0 1 Pid Pid];

            % create new leaf Q - "query" traj that is inserted
            clusterNode(szNode+2,1:7) = [nnNodeID 0 0 0 1 newTrajID newTrajID];

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
    %             centreTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
                centreTraj = trajStrData(centerTrajID).traj;
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
            newTrajID = newTrajID + 1;
            time4 = toc(t4);
        end

    else
        % this is the first node in CCT, just create the root
        clusterNode(szNode+1,1:7) = [0 0 0 0 1 newTrajID newTrajID];
        clusterTrajNode(newTrajID,1) = szNode+1;
        szNode = szNode + 1;
        newTrajID = newTrajID + 1;
    end

end

