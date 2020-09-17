% take the UCF data and transform into the inputSet and querySet

function UCFTransformData

    global inputSet querySet CompMoveData
    
    inputSet = {[]};
    querySet = {[]};
    inputSetCnt = 1;
    querySetCnt = 1;
    
    CompMoveData = sortrows(CompMoveData,[1,2,3]); % sort by class,subject,seq id
    
    allClasses = CompMoveData(:,1);
    classes = unique(allClasses); % list of unique classes
    
    % translate the trajetories so the first vertex x,y,z coordinate of
    % TORS is (0,0,0)
    for i = 1:size(CompMoveData,1)
        tmpTraj = cell2mat(CompMoveData(i,4)); % all the trajectories for this tag
        % get first vertex x,y,z coordinate of TORS trajectory and multiply by -1
        transPoint = [tmpTraj(1,7)*-1 tmpTraj(1,8)*-1 tmpTraj(1,9)*-1];
        % translate all traj by transPoint
        tmpTraj = [tmpTraj(:,1:3)+transPoint tmpTraj(:,4:6)+transPoint ...
                   tmpTraj(:,7:9)+transPoint tmpTraj(:,10:12)+transPoint ...
                   tmpTraj(:,13:15)+transPoint tmpTraj(:,16:18)+transPoint ...
                   tmpTraj(:,19:21)+transPoint tmpTraj(:,22:24)+transPoint ...
                   tmpTraj(:,25:27)+transPoint tmpTraj(:,28:30)+transPoint ...
                   tmpTraj(:,31:33)+transPoint tmpTraj(:,34:36)+transPoint ...
                   tmpTraj(:,37:39)+transPoint tmpTraj(:,40:42)+transPoint ...
                   tmpTraj(:,43:45)+transPoint ];
        CompMoveData(i,4) = mat2cell(tmpTraj,size(tmpTraj,1),size(tmpTraj,2)); % save result
    end
    
%     % translate each traj to start at position (0,0,0)
%     for i = 1:size(CompMoveData,1)
%         tmpTraj = cell2mat(CompMoveData(i,4)); % all the trajectories for this tag
%         % get first vertex x,y,z coordinate of each trajectory and multiply by -1
%         transPoint1 = [tmpTraj(1,1)*-1 tmpTraj(1,2)*-1 tmpTraj(1,3)*-1];
%         transPoint2 = [tmpTraj(1,4)*-1 tmpTraj(1,5)*-1 tmpTraj(1,6)*-1];
%         transPoint3 = [tmpTraj(1,7)*-1 tmpTraj(1,8)*-1 tmpTraj(1,9)*-1];
%         transPoint4 = [tmpTraj(1,10)*-1 tmpTraj(1,11)*-1 tmpTraj(1,12)*-1];
%         transPoint5 = [tmpTraj(1,13)*-1 tmpTraj(1,14)*-1 tmpTraj(1,15)*-1];
%         transPoint6 = [tmpTraj(1,16)*-1 tmpTraj(1,17)*-1 tmpTraj(1,18)*-1];
%         transPoint7 = [tmpTraj(1,19)*-1 tmpTraj(1,20)*-1 tmpTraj(1,21)*-1];
%         transPoint8 = [tmpTraj(1,22)*-1 tmpTraj(1,23)*-1 tmpTraj(1,24)*-1];
%         transPoint9 = [tmpTraj(1,25)*-1 tmpTraj(1,26)*-1 tmpTraj(1,27)*-1];
%         transPoint10 = [tmpTraj(1,28)*-1 tmpTraj(1,29)*-1 tmpTraj(1,30)*-1];
%         transPoint11 = [tmpTraj(1,31)*-1 tmpTraj(1,32)*-1 tmpTraj(1,33)*-1];
%         transPoint12 = [tmpTraj(1,34)*-1 tmpTraj(1,35)*-1 tmpTraj(1,36)*-1];
%         transPoint13 = [tmpTraj(1,37)*-1 tmpTraj(1,38)*-1 tmpTraj(1,39)*-1];
%         transPoint14 = [tmpTraj(1,40)*-1 tmpTraj(1,41)*-1 tmpTraj(1,42)*-1];
%         transPoint15 = [tmpTraj(1,43)*-1 tmpTraj(1,44)*-1 tmpTraj(1,45)*-1];
%         % translate all traj by transPoint
%         tmpTraj = [tmpTraj(:,1:3)+transPoint1 tmpTraj(:,4:6)+transPoint2 ...
%                    tmpTraj(:,7:9)+transPoint3 tmpTraj(:,10:12)+transPoint4 ...
%                    tmpTraj(:,13:15)+transPoint5 tmpTraj(:,16:18)+transPoint6 ...
%                    tmpTraj(:,19:21)+transPoint7 tmpTraj(:,22:24)+transPoint8 ...
%                    tmpTraj(:,25:27)+transPoint9 tmpTraj(:,28:30)+transPoint10 ...
%                    tmpTraj(:,31:33)+transPoint11 tmpTraj(:,34:36)+transPoint12 ...
%                    tmpTraj(:,37:39)+transPoint13 tmpTraj(:,40:42)+transPoint14 ...
%                    tmpTraj(:,43:45)+transPoint15 ];
%         CompMoveData(i,4) = mat2cell(tmpTraj,size(tmpTraj,1),size(tmpTraj,2)); % save result
%     end

    for i = 1:size(classes,1) % process each unique tag
        classIDs = find(ismember(allClasses,classes(i)));
        numSample = floor(size(classIDs,1) * 3/4); % 3/4 training, 1/4 test
        tmpValue = [];
        [tmpValue,tagIdIndex] = datasample(classIDs,numSample,'Replace',false); % randomly choose indexes without replacement from classIDs list
        for j = 1:size(classIDs,1) % process each item in classIDs list
            tmpTraj = cell2mat(CompMoveData(classIDs(j),4)); % all the trajectories for this tag
            CompMoveData(classIDs(j),5) = num2cell(i); % store a unique ID for each tag (class)
            if ismember(j,tagIdIndex) % put this one in the inputSet
                inputSet(inputSetCnt,1) = num2cell(classIDs(j)); % source id
                inputSet(inputSetCnt,2) = num2cell(i);         % tag
                
                for k=1:15 % process each of the 15 trajectories
                    inputSet(inputSetCnt,k+2) = mat2cell(tmpTraj(:,3*k-2:3*k),size(tmpTraj(:,3*k-2:3*k),1),size(tmpTraj(:,3*k-2:3*k),2));
                end
                
%                 tmpTraj2 = tmpTraj(:,19:21) - tmpTraj(:,4:6); % RSHO relative to NECK
%                 inputSet(inputSetCnt,3) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,22:24) - tmpTraj(:,4:6); % RELB relative to NECK
%                 inputSet(inputSetCnt,4) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,25:27) - tmpTraj(:,4:6); % RHND relative to NECK
%                 inputSet(inputSetCnt,5) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,10:12) - tmpTraj(:,4:6); % LSHO relative to NECK
%                 inputSet(inputSetCnt,6) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,13:15) - tmpTraj(:,4:6); % LELB relative to NECK
%                 inputSet(inputSetCnt,7) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,16:18) - tmpTraj(:,4:6); % LHND relative to NECK
%                 inputSet(inputSetCnt,8) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 
%                 tmpTraj2 = tmpTraj(:,37:39) - tmpTraj(:,7:9); % RHIP relative to TORS
%                 inputSet(inputSetCnt,9) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,40:42) - tmpTraj(:,7:9); % RKNE relative to TORS
%                 inputSet(inputSetCnt,10) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,43:45) - tmpTraj(:,7:9); % RFOT relative to TORS
%                 inputSet(inputSetCnt,11) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,28:30) - tmpTraj(:,7:9); % LHIP relative to TORS
%                 inputSet(inputSetCnt,12) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,31:33) - tmpTraj(:,7:9); % LKNE relative to TORS
%                 inputSet(inputSetCnt,13) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,34:36) - tmpTraj(:,7:9); % LFOT relative to TORS
%                 inputSet(inputSetCnt,14) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));

                inputSetCnt = inputSetCnt + 1;
            else % put this one in the querySet
                querySet(querySetCnt,1) = num2cell(classIDs(j)); % source id
                querySet(querySetCnt,2) = num2cell(i);         % tag
                
                for k=1:15 % process each of the 15 trajectories
                    querySet(querySetCnt,k+2) = mat2cell(tmpTraj(:,3*k-2:3*k),size(tmpTraj(:,3*k-2:3*k),1),size(tmpTraj(:,3*k-2:3*k),2));
                end
                
%                 tmpTraj2 = tmpTraj(:,19:21) - tmpTraj(:,4:6); % RSHO relative to NECK
%                 querySet(querySetCnt,3) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,22:24) - tmpTraj(:,4:6); % RELB relative to NECK
%                 querySet(querySetCnt,4) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,25:27) - tmpTraj(:,4:6); % RHND relative to NECK
%                 querySet(querySetCnt,5) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,10:12) - tmpTraj(:,4:6); % LSHO relative to NECK
%                 querySet(querySetCnt,6) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,13:15) - tmpTraj(:,4:6); % LELB relative to NECK
%                 querySet(querySetCnt,7) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,16:18) - tmpTraj(:,4:6); % LHND relative to NECK
%                 querySet(querySetCnt,8) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 
%                 tmpTraj2 = tmpTraj(:,37:39) - tmpTraj(:,7:9); % RHIP relative to TORS
%                 querySet(querySetCnt,9) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,40:42) - tmpTraj(:,7:9); % RKNE relative to TORS
%                 querySet(querySetCnt,10) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,43:45) - tmpTraj(:,7:9); % RFOT relative to TORS
%                 querySet(querySetCnt,11) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,28:30) - tmpTraj(:,7:9); % LHIP relative to TORS
%                 querySet(querySetCnt,12) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,31:33) - tmpTraj(:,7:9); % LKNE relative to TORS
%                 querySet(querySetCnt,13) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,34:36) - tmpTraj(:,7:9); % LFOT relative to TORS
%                 querySet(querySetCnt,14) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));

                querySetCnt = querySetCnt + 1;            
            end
        end
    end
end
