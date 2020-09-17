function MHADTransformData(extractMethod)

    global querySet trainSet CompMoveData
    
    trainSet = {[]};
    querySet = {[]};
    trainSetCnt = 1;
    querySetCnt = 1;
    
    CompMoveData = sortrows(CompMoveData,[1,2,3]); % sort by class,subject,seq id
    
    allClasses = CompMoveData(:,1);
    classes = unique(allClasses); % list of unique classes

    for i = 1:size(classes,1) % process each unique class
        classIDs = find(ismember(allClasses,classes(i))); % get list of class ID's for this unique class label

        % determine where to put the seq - trainSet or querySet
        for j = 1:size(classIDs,1) % process each item in classIDs list
%             seq = cell2mat(CompMoveData(classIDs(j),4)); % all the trajectories for this seq
%             CompMoveData(classIDs(j),5) = num2cell(i); % store a unique class ID for each seq
%             
%             seq = MHADNormalizeSeq(seq); % normalize the data
%             
            seq = cell2mat(CompMoveData(classIDs(j),6)); % all the normalized trajectories for this seq
            seq = MHADExtractFeatures(seq,extractMethod); % extract a set of features from the data

            % get subject number
            [garbage subject] = strtok(cell2mat(CompMoveData(classIDs(j),2)));
            subject = str2num(subject);

            if subject <= 7 % put first seven subjects in trainSet, last 5 subjects in querySet
                trainSet(trainSetCnt,1) = num2cell(classIDs(j)); % source id
                trainSet(trainSetCnt,2) = num2cell(i);         % class
                for k=1:size(seq,2)/3 % process each traj
                    trainSet(trainSetCnt,k+2) = mat2cell(seq(:,3*k-2:3*k),size(seq(:,3*k-2:3*k),1),size(seq(:,3*k-2:3*k),2));
                end
                trainSetCnt = trainSetCnt + 1;
            else % put this one in the querySet
                querySet(querySetCnt,1) = num2cell(classIDs(j)); % source id
                querySet(querySetCnt,2) = num2cell(i);         % class
                for k=1:size(seq,2)/3 % process each traj
                    querySet(querySetCnt,k+2) = mat2cell(seq(:,3*k-2:3*k),size(seq(:,3*k-2:3*k),1),size(seq(:,3*k-2:3*k),2));
                end                
                querySetCnt = querySetCnt + 1;            
            end
        end
    end
end
