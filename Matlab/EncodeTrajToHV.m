% function EncodeTrajToHV
%
% Encodes trajectory P into a hyper-vector v.  This function extracts
% features from trajectory P, encodes each unique feature into a random
% index (RI), and adds the RI's into a a hyper-vector v.  
%
% The features extracted from trajectory P are: 
% 1) trajectory start location
% 2) trajectory end location
% 3) trajectory stabbing order

function v = EncodeTrajToHV(P,v)

    global ballSet pointPrunedNodes
    
    global tHV timeHV

    % get disc nodes that cover trajectory start vertex point
    PStartVertex = P(1,:);
    pointPrunedNodes = [];
    GetPrunedPointNodes(1,PStartVertex);
    startNodes = pointPrunedNodes;
    
    % add trajectory start location feature RI's to hyper-vector v
    tHV = tic;
    if isempty(startNodes) == false
        for i=1:size(startNodes,2)
            ri = GetVertexRI(startNodes(i),'S'); % get start vertex RI
            v(ri(1:10)) = v(ri(1:10)) + 1; % the first 10 RI are +1
            v(ri(11:20)) = v(ri(11:20)) - 1; % the remaining 10 RI are -1
        end
    end
    timeHV = timeHV + toc(tHV);

    % get disc nodes that cover trajectory end vertex point
    PEndVertex = P(end,:);
    pointPrunedNodes = [];
    GetPrunedPointNodes(1,PEndVertex);
    endNodes = pointPrunedNodes;
    
    % add trajectory end location feature RI's to hyper-vector v
    tHV = tic;
    if isempty(endNodes) == false
        for i=1:size(endNodes,2)
            ri = GetVertexRI(endNodes(i),'E'); % get start vertex RI
            v(ri(1:10)) = v(ri(1:10)) + 1; % the first 10 RI are +1
            v(ri(11:20)) = v(ri(11:20)) - 1; % the remaining 10 RI are -1
        end   
    end
    timeHV = timeHV + toc(tHV);

    % get a set of stabbing orders, and add their RI's to hyper-vector v
    
    % first get the most detailed stabbing order
    so = GetTrajectoryStabOrder(P); % get the disc stab order
    
    if isempty(so) == false
        radiiList = unique(so(:,2)); % get list of unique disc radii values

        % now take subsets of the stabbing order and create RI and add to hyper-vector v
        tHV = tic;
        for m = 1:size(radiiList,1)
            so1 = so(so(:,2) == radiiList(m),1);  % get ordered stabbing list for this unique radius
            for i = 1:size(ballSet,1) % attempt to create a RI for each ball set
                tmpSO = [];
                for j = 1:size(so1,1) % generate new subset stabbing order
                    currBallSet = ballSet(i,:);
                    currBallSet(currBallSet==0) = [];
                    if ismember(mod(so1(j),8)+1,currBallSet)
                        tmpSO = [tmpSO; so1(j)];
                    end
                end
                szTmpSO = size(tmpSO,1);
                for k = 1:szTmpSO
                    ri = GetSORI(tmpSO(k)); % get RI for this single disc
                    v(ri(1:10)) = v(ri(1:10)) + 1; % the first 10 RI are +1
                    v(ri(11:20)) = v(ri(11:20)) - 1; % the remaining 10 RI are -1
                    if k < szTmpSO
                        ri = GetSORI(tmpSO(k:k+1)); % get RI for this single stab
                        v(ri(1:10)) = v(ri(1:10)) + 1; % the first 10 RI are +1
                        v(ri(11:20)) = v(ri(11:20)) - 1; % the remaining 10 RI are -1
                    end
%                     if k < szTmpSO - 1
%                         ri = GetSORI(tmpSO(k:k+2)); % get RI for this double stab (3 discs)
%                         v(ri(1:10)) = v(ri(1:10)) + 1; % the first 10 RI are +1
%                         v(ri(11:20)) = v(ri(11:20)) - 1; % the remaining 10 RI are -1
%                     end
                end
            end
        end
        timeHV = timeHV + toc(tHV);
    end

%     szSO = size(so,1);
%     for i = 1:szSO
%         ri = GetSORI(so(i)); % get RI for this single disc
%         v(ri(1:10)) = v(ri(1:10)) + 1; % the first 10 RI are +1
%         v(ri(11:20)) = v(ri(11:20)) - 1; % the remaining 10 RI are -1
%         if i < szSO
%             ri = GetSORI(so(i:i+1)); % get RI for this single stab
%             v(ri(1:10)) = v(ri(1:10)) + 1; % the first 10 RI are +1
%             v(ri(11:20)) = v(ri(11:20)) - 1; % the remaining 10 RI are -1
%         end
% %         if i+1 < szSO
% %             ri = GetSORI([so(i); so(i+2)]); % get RI for this single stab
% %             v(ri(1:10)) = v(ri(1:10)) + 1; % the first 10 RI are +1
% %             v(ri(11:20)) = v(ri(11:20)) - 1; % the remaining 10 RI are -1            
% %         end
%     end
    
%     % now take subsets of the stabbing order and create RI and add to hyper-vector v
%     for i = 1:size(ballSet,1) % attempt to create a RI for each ball set
%         tmpSO = [];
%         for j = 1:size(so,1) % generate new subset stabbing order
%             currBallSet = ballSet(i,:);
%             currBallSet(currBallSet==0) = [];
%             if ismember(mod(so(j),8)+1,currBallSet)
%                 tmpSO = [tmpSO; so(j)];
%             end
%         end
%         if isempty(tmpSO) == false
%             ri = GetSORI(tmpSO); % get RI for this particular stabbing order
%             v(ri(1:10)) = v(ri(1:10)) + 1; % the first 10 RI are +1
%             v(ri(11:20)) = v(ri(11:20)) - 1; % the remaining 10 RI are -1
%         end
%     end

end