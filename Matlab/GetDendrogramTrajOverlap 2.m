function GetDendrogramTrajOverlap(nodeID,depth)

    global tmpCCT tmpCCTDepth dendroOverlapList overlapWeight leafTrajIDList trajStrData
    
    if depth <= tmpCCTDepth % only process up to a ce rtain tree depth
        % only do calc if both children are non-leafs
        if tmpCCT(tmpCCT(nodeID,2),5) ~= 1 && tmpCCT(tmpCCT(nodeID,3),5) ~= 1
            cRad = tmpCCT(nodeID,4); % cluster radius
            child1Rad = tmpCCT(tmpCCT(nodeID,2),4);
            child2Rad = tmpCCT(tmpCCT(nodeID,3),4);
            if cRad - child1Rad - child2Rad >= 0 
                pctOverlap = 0;
            else % have to calc number of traj in overlap
                % get list of traj id's for each child
                leafTrajIDList = [];
                GetNodeLeafTraj(tmpCCT(nodeID,2));
                child1TrajList = leafTrajIDList;
                leafTrajIDList = [];
                GetNodeLeafTraj(tmpCCT(nodeID,3));
                child2TrajList = leafTrajIDList;
                
                potentialList = [];
                centerTrajID = tmpCCT(tmpCCT(nodeID,3),6);
                centreTraj = trajStrData(centerTrajID).traj;
                for i = 1:size(child2TrajList,1)
                    child2SmallRad = cRad - child1Rad;
                    Qid = child2TrajList(i,1);
                    Q = trajStrData(Qid).traj;
                    lowBnd1 = GetBestConstLB(centreTraj,Q,Inf,2,centerTrajID,Qid);
                    if lowBnd1 > child2SmallRad
                        potentialList(end+1) = Qid;
                    else
                        upBnd = GetBestUpperBound(centreTraj,Q,2,centerTrajID,Qid);
                        if upBnd > child2SmallRad
                            linearLB = GetBestLinearLBDP(centreTraj,Q,child2SmallRad,2,centerTrajID,Qid);
                            if linearLB == true
                                potentialList(end+1) = Qid;
                            else % now we have to check quadratic time FDP
                                decProRes = FrechetDecide(centreTraj,Q,child2SmallRad,1);
                                if decProRes == false
                                    potentialList(end+1) = Qid;
                                end
                            end
                        end
                    end
                end
                
                numInIntersection = 0;
                if size(potentialList,2) > 0 % now check potentialList against the other child cluster centre
                    centerTrajID = tmpCCT(tmpCCT(nodeID,2),6);
                    centreTraj = trajStrData(centerTrajID).traj;
                    for i = 1:size(potentialList,2)
                        Qid = potentialList(i);
                        Q = trajStrData(Qid).traj;
                        lowBnd1 = GetBestConstLB(centreTraj,Q,Inf,2,centerTrajID,Qid);
                        if lowBnd1 < child1Rad
                            upBnd = GetBestUpperBound(centreTraj,Q,2,centerTrajID,Qid);
                            if upBnd < child1Rad
                                numInIntersection = numInIntersection + 1;
                            else
                                linearLB = GetBestLinearLBDP(centreTraj,Q,child1Rad,2,centerTrajID,Qid);
                                if linearLB == false
                                    % now we have to check quadratic time FDP
                                    decProRes = FrechetDecide(centreTraj,Q,child1Rad,1);
                                    if decProRes == true
                                        numInIntersection = numInIntersection + 1;
                                    end
                                end
                            end
                        end
                    end
                end
                
                % compute the pctOverlap
                if numInIntersection == 0
                    pctOverlap = 0;
                else
                    pctOverlap = numInIntersection / tmpCCT(nodeID,5);
                end
                
            end

            dendroOverlapList(end+1) = pctOverlap;
            overlapWeight(end+1) = tmpCCT(nodeID,5);
        else
            pctOverlap = 0;
        end

        tmpCCT(nodeID,8) = pctOverlap;

        if tmpCCT(tmpCCT(nodeID,2),4) > 0
            GetDendrogramTrajOverlap(tmpCCT(nodeID,2),depth+1);
        end

        if tmpCCT(tmpCCT(nodeID,3),4) > 0
            GetDendrogramTrajOverlap(tmpCCT(nodeID,3),depth+1);
        end
    end

end