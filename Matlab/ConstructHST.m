% Construct Simp Tree and CCT with a Truck dataset input traj
% Only use Driemel simplification (not Agarwal)
%
% dataName: e.g. 'FootballData'
% sourceName: e.g. 'MatlabData\RealInputData\FootballData.mat'
% realSynFlg: 1 = real, 2 = synthetic
% inpSz: size of input curve P
% constMeth: HST construction method, 1 = halven radius, 2 = double nodes
% trajDataType: 1 = trajData, 2 = trajStrData, 3 = trajOrigData
% numLevels: number of levels for constMeth 1
% logFactor: log factor for constMeth 2
% intrDim: intrinsic dimensionality for synthetic traj. 1 = low, 2 = high
% numQ: number of queries to generate

function ConstructHST(dataName,sourceName,realSynFlg,inpSz,constMeth,trajDataType,numLevels,logFactor,intrDim,numQ)

    global inP trajData trajStrData trajOrigData queryStrData

    % create input curve inP
    inP = [];
    if realSynFlg == 1 % real data set
        
        % load source traj data
        load(sourceName);
        InitDatasetVars(dataName);
        doDFD = false;
        
        % put traj data source into tData
        if trajDataType == 1 % use trajData
            tData = trajData;
        elseif trajDataType == 2 % use trajStrData
            tData = {[]};
            for i = 1:size(trajStrData,2)
                P = trajStrData(i).traj;
                tData(i,1) = mat2cell(P,size(P,1),size(P,2));
            end
        else % trajDataType == 3 % use trajOrigData
            tData = trajOrigData;
        end

        % remove duplicate vertices
        for i = 1:size(tData,1)
            P = DriemelSimp(cell2mat(tData(i,1)),0);
            tData(i,1) = mat2cell(P,size(P,1),size(P,2));
        end
        
        % keep on appending vertices to inP until reach inpSz, or run out of trajectories
        currSz = 0;
        while size(tData,1) > 0
            if currSz == 0 % randomly choose 1st traj
                idx = randi(size(tData,1));
                P = cell2mat(tData(idx,1));
                tData(idx,:) = []; % remove trajectory
            else % choose traj whose start point is closest to inP end point
                bestDist = Inf;
                for i = 1:size(tData,1)
                    Q = cell2mat(tData(i,1));
                    dist = CalcPointDist(inP(end,:),Q(1,:));
                    if dist < bestDist
                        bestDist = dist;
                        idx = i;
                    end
                end
                P = cell2mat(tData(idx,1));
                tData(idx,:) = []; % remove trajectory
            end
            szP = size(P,1);
            if szP + currSz <= inpSz
                inP = [inP; P];
                currSz = currSz + size(P,1);
            else
                inP = [inP; P(1:inpSz - currSz,:)];
                currSz = inpSz;
            end
            if currSz >= inpSz
                break 
            end
        end
    else % synthetic data set
        inP = [];
        if intrDim == 1 % low intrinsic dimensionality inP, straighter traj and not boxed in
            numDim = 2;
            dimUnits = 100;
            maxVertDist = 10;
            straightFactor = 0.9999;
            for i = 1:inpSz
                dimPos = [];
                if i==1
                    for j = 1:numDim
                        dimPos = [dimPos dimUnits*rand];
                    end
                elseif i==2
                    for j = 1:numDim
                        dimPos = [dimPos (-maxVertDist + (maxVertDist+maxVertDist) *rand) + inP(i-1,j)];
                    end
                else
                    for j = 1:numDim
                        dimPos = [dimPos (-maxVertDist + (maxVertDist+maxVertDist) *rand) + (inP(i-1,j)) + straightFactor.*(inP(i-1,j) - inP(i-2,j))];
                    end
                end  
                inP(i,:) = dimPos;
            end
        else % high intrinsic dimensionality inP, curvier trajectory and boxed in
            numDim = 2;
            dimUnits = 500;
            maxVertDist = 15;
            straightFactor = 0.60;
            for i = 1:inpSz
                dimPos = [];
                if i==1
                    for j = 1:numDim
                        dimPos = [dimPos dimUnits*rand];
                    end
                elseif i==2
                    for j = 1:numDim
                        coord = (-maxVertDist + (maxVertDist+maxVertDist) *rand) + inP(i-1,j);
                        coord = min(max(coord,0),dimUnits);
                        dimPos = [dimPos coord];
                    end
                else
                    for j = 1:numDim
                        coord = (-maxVertDist + (maxVertDist+maxVertDist) *rand) + (inP(i-1,j)) + straightFactor.*(inP(i-1,j) - inP(i-2,j));
                        coord = min(max(coord,0),dimUnits);
                        dimPos = [dimPos coord];
                    end
                end  
                inP(i,:) = dimPos;
            end
        end
    end
    
    % construct the HST
    tic
    if constMeth == 1
        ConstTrajSimpTree(inP,2,numLevels); % construct the HST, halven radius at each subsequent level
    else
        ConstTrajSimpTree2(inP,logFactor);  % construct the HST, double nodes at each subsequent level
    end
    t = toc;
    disp(['HST construction time (ms): ',num2str(t * 1000)]);

    % create queries
    queryStrData = [];
    inPSz = size(inP,1);
    qSzMax = ceil(log2(inPSz)) * 2;
    reachP = TrajReach(inP);
    for i = 1:numQ % create numQ queries
        sPos = randi(inPSz-1); % randomly choose start/end positions
        ePos = min(randi(qSzMax) + sPos , inPSz);
        Q = inP(sPos:ePos,:); % set Q to a sub-traj of inP
        % perturb each of the vertices in Q a percentage of the reach
        reachQ = TrajReach(Q); % get reach of Q
        while reachQ * 10 > reachP % if Q's reach is too large, generate a different Q, until it's reach is relatively small
            sPos = randi(inPSz-1); % randomly choose start/end positions
            ePos = min(randi(qSzMax) + sPos , inPSz);
            Q = inP(sPos:ePos,:); % set Q to a sub-traj of inP
            reachQ = TrajReach(Q); % get reach of Q
        end
        szQ = size(Q,1);
        % perturb each of the vertices in Q a percentage of the reach
        perturb = reachQ * 0.03;
        Q = Q + ((-perturb + (perturb+perturb).*rand(size(Q,2),szQ))');
        % now randomly translate Q a percentage of the reach
        perturb = reachQ * 0.05;
        for j = 1:size(Q,2)
            transValue = (-perturb + (perturb+perturb).*rand(1,1));
            Q(:,j) = Q(:,j) + transValue;
        end
        % store the result
        queryStrData(i).traj = Q;
        PreprocessQuery(i);
    end

end