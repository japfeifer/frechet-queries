% take the MSRDA data and transform into the inputSet and querySet
%
% use the following coordinates:
% TORS (1,2,3)
% SPIN (4,5,6)
% NECK (7,8,9)
% HEAD (10,11,12)
% LSHO (13,14,15)
% LELB (16,17,18)
% LWST (19,20,21)
% LHND (22,23,24)
% RSHO (25,26,27)
% RELB (28,29,30)
% RWST (31,32,33)
% RHND (34,35,36)
% LHIP (37,38,39)
% LKNE (40,41,42)
% LANK (43,44,45)
% LFOT (46,47,48)
% RHIP (49,50,51)
% RKNE (52,53,54)
% RANK (55,56,57)
% RFOT (58,59,60)

function MSRDATransformData

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
        tmpTraj = cell2mat(CompMoveData(i,4)); % all the trajectories for this seq
        % get first vertex x,y,z coordinate of TORS trajectory and multiply by -1
        transPoint = [tmpTraj(1,1)*-1 tmpTraj(1,2)*-1 tmpTraj(1,3)*-1];
        % translate all traj by transPoint
        tmpTraj = [tmpTraj(:,1:3)+transPoint tmpTraj(:,4:6)+transPoint ...
                   tmpTraj(:,7:9)+transPoint tmpTraj(:,10:12)+transPoint ...
                   tmpTraj(:,13:15)+transPoint tmpTraj(:,16:18)+transPoint ...
                   tmpTraj(:,19:21)+transPoint tmpTraj(:,22:24)+transPoint ...
                   tmpTraj(:,25:27)+transPoint tmpTraj(:,28:30)+transPoint ...
                   tmpTraj(:,31:33)+transPoint tmpTraj(:,34:36)+transPoint ...
                   tmpTraj(:,37:39)+transPoint tmpTraj(:,40:42)+transPoint ...
                   tmpTraj(:,43:45)+transPoint tmpTraj(:,46:48)+transPoint ...
                   tmpTraj(:,49:51)+transPoint tmpTraj(:,52:54)+transPoint ...
                   tmpTraj(:,55:57)+transPoint tmpTraj(:,58:60)+transPoint ];
        CompMoveData(i,4) = mat2cell(tmpTraj,size(tmpTraj,1),size(tmpTraj,2)); % save result
    end
    
%     % translate each traj to start at position (0,0,0)
%     for i = 1:size(CompMoveData,1)
%         tmpTraj = cell2mat(CompMoveData(i,4)); % all the trajectories for this seq
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
%         transPoint16 = [tmpTraj(1,46)*-1 tmpTraj(1,47)*-1 tmpTraj(1,48)*-1];
%         transPoint17 = [tmpTraj(1,49)*-1 tmpTraj(1,50)*-1 tmpTraj(1,51)*-1];
%         transPoint18 = [tmpTraj(1,52)*-1 tmpTraj(1,53)*-1 tmpTraj(1,54)*-1];
%         transPoint19 = [tmpTraj(1,55)*-1 tmpTraj(1,56)*-1 tmpTraj(1,57)*-1];
%         transPoint20 = [tmpTraj(1,58)*-1 tmpTraj(1,59)*-1 tmpTraj(1,60)*-1];
% 
%         % translate all traj by transPoint
%         tmpTraj = [tmpTraj(:,1:3)+transPoint1 tmpTraj(:,4:6)+transPoint2 ...
%                    tmpTraj(:,7:9)+transPoint3 tmpTraj(:,10:12)+transPoint4 ...
%                    tmpTraj(:,13:15)+transPoint5 tmpTraj(:,16:18)+transPoint6 ...
%                    tmpTraj(:,19:21)+transPoint7 tmpTraj(:,22:24)+transPoint8 ...
%                    tmpTraj(:,25:27)+transPoint9 tmpTraj(:,28:30)+transPoint10 ...
%                    tmpTraj(:,31:33)+transPoint11 tmpTraj(:,34:36)+transPoint12 ...
%                    tmpTraj(:,37:39)+transPoint13 tmpTraj(:,40:42)+transPoint14 ...
%                    tmpTraj(:,43:45)+transPoint15 tmpTraj(:,46:48)+transPoint16 ...
%                    tmpTraj(:,49:51)+transPoint17 tmpTraj(:,52:54)+transPoint18 ...
%                    tmpTraj(:,55:57)+transPoint19 tmpTraj(:,58:60)+transPoint20 ];
%         CompMoveData(i,4) = mat2cell(tmpTraj,size(tmpTraj,1),size(tmpTraj,2)); % save result
%     end

    for i = 1:size(classes,1) % process each unique class
        classIDs = find(ismember(allClasses,classes(i)));
        for j = 1:size(classIDs,1) % process each item in classIDs list
            tmpTraj = cell2mat(CompMoveData(classIDs(j),4)); % all the trajectories for this seq
            CompMoveData(classIDs(j),5) = num2cell(i); % store a unique ID for each class
            % get subject number
            [garbage subject] = strtok(cell2mat(CompMoveData(classIDs(j),2)));
            subject = str2num(subject);
            if mod(subject,2) == 1 % put all odd numbered subjects in the inputSet
                inputSet(inputSetCnt,1) = num2cell(classIDs(j)); % source id
                inputSet(inputSetCnt,2) = num2cell(i);         % seq
                
                for k=1:12 % only process upper body trajectories
                    inputSet(inputSetCnt,k+2) = mat2cell(tmpTraj(:,3*k-2:3*k),size(tmpTraj(:,3*k-2:3*k),1),size(tmpTraj(:,3*k-2:3*k),2));
                end
                
%                 tmpTraj2 = tmpTraj(:,25:27) - tmpTraj(:,7:9); % RSHO relative to NECK
%                 inputSet(inputSetCnt,3) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,28:30) - tmpTraj(:,7:9); % RELB relative to NECK
%                 inputSet(inputSetCnt,4) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,31:33) - tmpTraj(:,7:9); % RWST relative to NECK
%                 inputSet(inputSetCnt,5) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,34:36) - tmpTraj(:,7:9); % RHND relative to NECK
%                 inputSet(inputSetCnt,6) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,13:15) - tmpTraj(:,7:9); % LSHO relative to NECK
%                 inputSet(inputSetCnt,7) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,16:18) - tmpTraj(:,7:9); % LELB relative to NECK
%                 inputSet(inputSetCnt,8) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,19:21) - tmpTraj(:,7:9); % LWST relative to NECK
%                 inputSet(inputSetCnt,9) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,22:24) - tmpTraj(:,7:9); % LHND relative to NECK
%                 inputSet(inputSetCnt,10) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 
%                 tmpTraj2 = tmpTraj(:,49:51) - tmpTraj(:,1:3); % RHIP relative to TORS
%                 inputSet(inputSetCnt,11) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,52:54) - tmpTraj(:,1:3); % RKNE relative to TORS
%                 inputSet(inputSetCnt,12) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,55:57) - tmpTraj(:,1:3); % RANK relative to TORS
%                 inputSet(inputSetCnt,13) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,58:60) - tmpTraj(:,1:3); % RFOT relative to TORS
%                 inputSet(inputSetCnt,14) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,37:39) - tmpTraj(:,1:3); % LHIP relative to TORS
%                 inputSet(inputSetCnt,15) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,40:42) - tmpTraj(:,1:3); % LKNE relative to TORS
%                 inputSet(inputSetCnt,16) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,43:45) - tmpTraj(:,1:3); % LANK relative to TORS
%                 inputSet(inputSetCnt,17) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,46:48) - tmpTraj(:,1:3); % LFOT relative to TORS
%                 inputSet(inputSetCnt,18) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));

                inputSetCnt = inputSetCnt + 1;
            else % put this one in the querySet
                querySet(querySetCnt,1) = num2cell(classIDs(j)); % source id
                querySet(querySetCnt,2) = num2cell(i);         % seq
                
                for k=1:12 % only process upper body trajectories
                    querySet(querySetCnt,k+2) = mat2cell(tmpTraj(:,3*k-2:3*k),size(tmpTraj(:,3*k-2:3*k),1),size(tmpTraj(:,3*k-2:3*k),2));
                end
                
%                 tmpTraj2 = tmpTraj(:,25:27) - tmpTraj(:,7:9); % RSHO relative to NECK
%                 querySet(querySetCnt,3) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,28:30) - tmpTraj(:,7:9); % RELB relative to NECK
%                 querySet(querySetCnt,4) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,31:33) - tmpTraj(:,7:9); % RWST relative to NECK
%                 querySet(querySetCnt,5) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,34:36) - tmpTraj(:,7:9); % RHND relative to NECK
%                 querySet(querySetCnt,6) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,13:15) - tmpTraj(:,7:9); % LSHO relative to NECK
%                 querySet(querySetCnt,7) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,16:18) - tmpTraj(:,7:9); % LELB relative to NECK
%                 querySet(querySetCnt,8) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,19:21) - tmpTraj(:,7:9); % LWST relative to NECK
%                 querySet(querySetCnt,9) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,22:24) - tmpTraj(:,7:9); % LHND relative to NECK
%                 querySet(querySetCnt,10) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 
%                 tmpTraj2 = tmpTraj(:,49:51) - tmpTraj(:,1:3); % RHIP relative to TORS
%                 querySet(querySetCnt,11) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,52:54) - tmpTraj(:,1:3); % RKNE relative to TORS
%                 querySet(querySetCnt,12) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,55:57) - tmpTraj(:,1:3); % RANK relative to TORS
%                 querySet(querySetCnt,13) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,58:60) - tmpTraj(:,1:3); % RFOT relative to TORS
%                 querySet(querySetCnt,14) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,37:39) - tmpTraj(:,1:3); % LHIP relative to TORS
%                 querySet(querySetCnt,15) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,40:42) - tmpTraj(:,1:3); % LKNE relative to TORS
%                 querySet(querySetCnt,16) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,43:45) - tmpTraj(:,1:3); % LANK relative to TORS
%                 querySet(querySetCnt,17) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
%                 tmpTraj2 = tmpTraj(:,46:48) - tmpTraj(:,1:3); % LFOT relative to TORS
%                 querySet(querySetCnt,18) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));

                querySetCnt = querySetCnt + 1;            
            end
        end
    end
end
