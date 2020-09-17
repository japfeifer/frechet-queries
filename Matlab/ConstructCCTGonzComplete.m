% Construct CCT using exact radii build with Complete Gonzalez ('full')
%
function ConstructCCTGonzComplete()

    global trajData clusterNode clusterTrajNode numCFD numDP

    tic
    
    clusterList = {[]};
    totalTraj = size(trajData,1);  % get number of trajectories to process
    totNode = (totalTraj * 2) - 1;  % calc total nodes
    numCFD = 0;
    numDP = 0;
    largestRSize = 0;
    furthestTrajID = 0;
    currNodeID = 0;
    tDistList = [];
    clusterNode = [];
    clusterTrajNode = [];
    
    distFact = 1; % distance factor

    if totNode > 0
        h = waitbar(0, 'Build Cluster');
        clusterNode(totNode,7) = 0;
        clusterTrajNode(totalTraj,1) = 0;

        % randomly choose a traj as the first center
        % newCenterTrajID = randi(totalTraj,1);

        % for testing purposes hardcode the first center ID so that it is easy to do
        % comparisons of code changes and recreate the same output 
        newCenterTrajID = 1;
        
%         newCenterTrajID = 13; % for hurdat2 dataset

        % create the initial list of traj that belong to the center
        tDistList = [1:totalTraj]'; % all traj id's
        tDistList = [tDistList ones(totalTraj,1)*-1 ones(totalTraj,1)*-1 ones(totalTraj,1)*-1];

        % remove center from tDistList
        TF1 = tDistList(:,1) == newCenterTrajID;
        tDistList([TF1],:) = [];

        % call proc to get max Rsize and associated traj ID
        [furthestTrajID,largestRSize,tDistList] = GetFurthestTrajGonzLite(newCenterTrajID,tDistList);

        % save info to clusterNode
        currNodeID = 1;
        clusterNode(currNodeID,:) = [0 0 0 largestRSize 0 newCenterTrajID newCenterTrajID];
        clusterTrajNode(newCenterTrajID,1) = currNodeID;

        % save new center to clusterList
        clusterList(1,1) = num2cell(newCenterTrajID);
        clusterList(1,2) = num2cell(furthestTrajID);
        clusterList(1,3) = num2cell(largestRSize);
        clusterList(1,4) = mat2cell(tDistList,size(tDistList,1),size(tDistList,2));
        clusterList(1,5) = num2cell(0); % when set to 1, it will be deleted down below

        for k = 2:totalTraj

            % get largest cluster in clusterList
            clusterList = sortrows(clusterList,3,'descend'); % sort descending by radii 
            i=1;
            prevCenterTrajID = cell2mat(clusterList(i,1));
            newCenterTrajID = cell2mat(clusterList(i,2));
            prevRadius = cell2mat(clusterList(i,3));
            tDistList = cell2mat(clusterList(i,4));
            nTraj = cell2mat(trajData(newCenterTrajID,1)); % new center traj

            % save new center to clusterNode CCT
            parentNodeID = clusterTrajNode(prevCenterTrajID,1);
            clusterNode(currNodeID+1,:) = [parentNodeID 0 0 0 0 prevCenterTrajID prevCenterTrajID];
            clusterNode(currNodeID+2,:) = [parentNodeID 0 0 0 0 newCenterTrajID newCenterTrajID];
            clusterNode(parentNodeID,2:end) = [currNodeID+1 currNodeID+2 prevRadius 0 prevCenterTrajID newCenterTrajID];
            clusterTrajNode(prevCenterTrajID,1) = currNodeID+1;
            clusterTrajNode(newCenterTrajID,1) = currNodeID+2;
            currNodeID = currNodeID + 2;

            % remove new center from prev cluster
            TF1 = tDistList(:,1) == newCenterTrajID;
            tDistList([TF1],:) = [];

            if size(tDistList,1) == 0 % prev cluster is now empty, so delete from clusterList
                clusterList(i,:) = [];
            else % prev cluster still has some elements in it, so update it
                [furthestTrajID,largestRSize,tDistList] = GetFurthestTrajGonzLite(prevCenterTrajID,tDistList);
                clusterList(i,2) = num2cell(furthestTrajID);
                clusterList(i,3) = num2cell(largestRSize);
                clusterList(i,4) = mat2cell(tDistList,size(tDistList,1),size(tDistList,2));
            end

            % loop thru each cluster
            nDistList = [];
            nDistList(totNode,4) = 0;
            nDistCnt = 1;
            for i=1:size(clusterList,1)

                prevCenterTrajID = cell2mat(clusterList(i,1));
                pTraj = cell2mat(trajData(prevCenterTrajID,1)); % prev center traj 
                prevFurthTrajID = cell2mat(clusterList(i,2));
                prevRadius = cell2mat(clusterList(i,3));
                tDistList = cell2mat(clusterList(i,4));
                sztDistList = size(tDistList,1);
                pDistList = [];
                pDistList(1:sztDistList,1) = 0;
                pDistList(1:sztDistList,2) = 0;
                pDistList(1:sztDistList,3) = 0;
                pDistList(1:sztDistList,4) = 0;
                pDistCnt = 1;
                updFurthestFlg = false;

                % check if we can exclude this cluster
                lowBnd = GetBestConstLB(pTraj,nTraj,Inf,2,prevCenterTrajID,newCenterTrajID); 

                if lowBnd/2 < prevRadius % we must check the elements in the cluster
                    for j=1:size(tDistList,1) % check if each element is closer to prev center or new center

                        currTrajID = tDistList(j,1);

                        % use a series of upper/lower bounds to check if traj belongs to prev or new center
                        pCenter = 0; nCenter = 0; foundCenter = 0; 

                        % get the upper/lower bounds from traj to new and prev center
                        cTraj = cell2mat(trajData(currTrajID,1)); % curr traj

                        nLowBnd = GetBestConstLB(nTraj,cTraj,Inf,2,newCenterTrajID,currTrajID);
                        pLowBnd = tDistList(j,3);
                        nUpBnd = GetBestUpperBound(nTraj,cTraj,2,newCenterTrajID,currTrajID,pLowBnd);
                        pUpBnd = tDistList(j,4);

                        if nLowBnd > nUpBnd % this fixes a precision error with the football data
                            nLowBnd = round(nLowBnd * 10^9) / 10^9;
                            nUpBnd = round(nUpBnd * 10^9) / 10^9;
                        end

                        cDist = tDistList(j,2);
                        if cDist == -1 && pLowBnd == pUpBnd 
                            cDist = pLowBnd;
                        end

                        if nUpBnd * distFact <= pLowBnd % no overlapping and traj is closer to new center
                            foundCenter = 1;
                            nCenter = 1;
                        elseif pUpBnd <= nLowBnd * distFact % no overlapping and traj is closer to prev center
                            foundCenter = 1;
                            pCenter = 1;
                        else % try linear LB checks
                            linearLB = GetBestLinearLBDP(pTraj,cTraj,nUpBnd * distFact,2,prevCenterTrajID,currTrajID);
                            if linearLB == true
                                foundCenter = 1;
                                nCenter = 1;
                            else
                                linearLB = GetBestLinearLBDP(nTraj,cTraj,pUpBnd / distFact,2,newCenterTrajID,currTrajID);
                                if linearLB == true
                                    foundCenter = 1;
                                    pCenter = 1;
                                end
                            end
                        end

                        if foundCenter == 0 
                            % get dist from P to previous center

                            if cDist == -1
                                cDist = ContFrechet(cTraj,pTraj);
                                pLowBnd = cDist; 
                                pUpBnd = cDist;
                                numCFD = numCFD + 1;
                            end

                            % Compare known distance (curr traj to prev center traj) to best 
                            % up/low bound dist (curr traj to new center traj)
                            if foundCenter == 0
                                if cDist <= nLowBnd * distFact % prev center is closer
                                    pCenter = 1;
                                    foundCenter = 1;
                                elseif cDist > nUpBnd * distFact % new center is closer
                                    nCenter = 1;
                                    foundCenter = 1;
                                else % finally try linear LB check
                                    linearLB = GetBestLinearLBDP(nTraj,cTraj,cDist / distFact,2,newCenterTrajID,currTrajID);
                                    if linearLB == true % prev center is closer
                                        pCenter = 1;
                                        foundCenter = 1;
                                    end
                                end
                            end

                            % at this point we have to do more quadratic calcs
                            if foundCenter == 0 
                                decResult = FrechetDecide(cTraj,nTraj,cDist / distFact,1);
                                numDP = numDP + 1;
                                if decResult == 1 % new center
                                    nCenter = 1;
                                else % old center
                                    pCenter = 1;
                                end
                            end

                        end

                        % assign traj to the new or prev center
                        if nCenter == 1
                            % closer to new center
                            newExactDist = -1;
                            if nLowBnd == nUpBnd
                                newExactDist = nLowBnd;
                            end
                            nDistList(nDistCnt,:) = [currTrajID newExactDist nLowBnd nUpBnd];
                            nDistCnt = nDistCnt + 1;

                            if currTrajID == prevFurthTrajID
                                updFurthestFlg = true;
                            end
                        else
                            % closer to prev center
                            pDistList(pDistCnt,:) = [currTrajID cDist pLowBnd pUpBnd];
                            pDistCnt = pDistCnt + 1;
                        end

                    end
                    
                    sPrev = pDistCnt - 1;
                    pDistList(pDistCnt:end,:) = [];
    
                    if sPrev == 0 % mark the prev cluster for deletion
                        clusterList(i,5) = num2cell(1);
                    else % update the prev cluster in clusterList
                        clusterList(i,4) = mat2cell(pDistList,size(pDistList,1),size(pDistList,2));
                        if updFurthestFlg == true
                            [furthestTrajID,largestRSize,pDistList] = GetFurthestTrajGonzLite(prevCenterTrajID,pDistList);
                            clusterList(i,2) = num2cell(furthestTrajID);
                            clusterList(i,3) = num2cell(largestRSize);
                        end
                    end
                end
            end
            
            sNew = nDistCnt - 1;
            nDistList(nDistCnt:end,:) = [];

            % save the new cluster in clusterList if its not empty
            if sNew > 0 
                [furthestTrajID,largestRSize,nDistList] = GetFurthestTrajGonzLite(newCenterTrajID,nDistList);
                cellIdx = size(clusterList,1) + 1;
                clusterList(cellIdx,1) = num2cell(newCenterTrajID);
                clusterList(cellIdx,2) = num2cell(furthestTrajID);
                clusterList(cellIdx,3) = num2cell(largestRSize);
                clusterList(cellIdx,4) = mat2cell(nDistList,size(nDistList,1),size(nDistList,2));
                clusterList(cellIdx,5) = num2cell(0);
            end

            % delete any rows in clusterList marked for deletion
            TF1 = [clusterList{:,5}]' == 1;
            clusterList([TF1],:) = [];

            if mod(k,10) == 0
                X = ['Build Cluster:',num2str(k),'/',num2str(totalTraj), ...
                    ' #CFD:',num2str(numCFD),' #Clust:',num2str(size(clusterList,1))];
                waitbar(k/totalTraj, h, X);
            end

        end

        close(h);

        h = waitbar(0, 'Build Cluster');

        % the tree is built.
        % now, update ancestor node leaf counts, and potentially radii and furthest trajectory
        for i=1:totalTraj
            % update ancestor node leaf count
            leafNodeID = clusterTrajNode(i,1);
            clusterNode(leafNodeID,5) = clusterNode(leafNodeID,5) + 1;
            parentNodeID = clusterNode(leafNodeID,1);
            P = cell2mat(trajData(i,1)); % leaf traj
            while parentNodeID ~= 0 % now go up tree towards root
                % update ancestor node leaf count
                clusterNode(parentNodeID,5) = clusterNode(parentNodeID,5) + 1;

                % get up bnd from query (leaf traj) to the centre traj
                centerTrajID = clusterNode(parentNodeID,6);
                centreTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
                upBnd = GetBestUpperBound(centreTraj,P,2,centerTrajID,i);
                parentRad = clusterNode(parentNodeID,4);
                checkFreFlag = false;

                % potentially update the radius and furthest traj
                if upBnd > parentRad % leaf traj may be further than cluster radius

                    linRes = GetBestLinearLBDP(centreTraj,P,parentRad,2,centerTrajID,i);
                    if linRes == true
                        checkFreFlag = true;
                    else
                        decProRes = FrechetDecide(centreTraj,P,parentRad,1);
                        numDP = numDP + 1;
                        if decProRes == 0
                            checkFreFlag = true;
                        end
                    end

                    if checkFreFlag == true
                        currDist = ContFrechet(P,centreTraj);
                        numCFD = numCFD + 1;
                        if currDist > parentRad
                            clusterNode(parentNodeID,4) = currDist; % update cluster radius
                            clusterNode(parentNodeID,7) = i; % update furthest traj ID to leaf traj ID
                        end
                    end
                end

                % get the next higher parent 
                parentNodeID = clusterNode(parentNodeID,1);
            end    
            if mod(i,100) == 0
                X = ['Update Cluster:',num2str(i),'/',num2str(totalTraj)];
                waitbar(i/totalTraj, h, X);
            end
        end
        close(h);
    end 
    
    timeElapsed = toc;

    disp(['------------------']);
    disp(['numCFD: ',num2str(numCFD)]);
    disp(['numDP: ',num2str(numDP)]);
    disp(['timeElapsed: ',num2str(timeElapsed)]);
    disp(['Runtime per trajectory (ms): ',num2str(timeElapsed/totalTraj*1000)]);

end