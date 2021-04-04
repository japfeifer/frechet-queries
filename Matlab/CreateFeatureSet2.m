function featureSet = CreateFeatureSet2(fSetNum,featureSetClass,fSetIgnoreSubFlg)

    global trainSet CompMoveData
    
    featureSet = {[]};

    if fSetNum == 0
        cnt = 1;
        for i = 1:size(trainSet,1)
            currClassID = cell2mat(trainSet(i,2));
            if isempty(featureSetClass) == 1 || ismember(currClassID,featureSetClass) == 1
                featureSet(cnt,1) = {i};
                cnt = cnt + 1;
            end
        end
    else
        tSet = [];
        for i = 1:size(trainSet,1)
            tSet(i,1) = cell2mat(trainSet(i,1));
            tSet(i,2) = cell2mat(trainSet(i,2));
            [garbage subjectNum] = strtok(cell2mat(CompMoveData(tSet(i,1),2))); % get subject number
            if isempty(subjectNum) == 1
                subjectNum = 1;
            else
                subjectNum = str2num(subjectNum); % convert subject number into 'double' datatype
            end
            tSet(i,3) = subjectNum;
            tSet(i,4) = i;
        end
        tSet = sortrows(tSet,[2,3,1]); % sort by class,subject,CompMove id
        
        allClasses = tSet(:,2);
        classes = unique(allClasses); % list of unique classes
        cnt = 1;
        
        for i = 1:size(classes,1) % process each unique class
            if isempty(featureSetClass) == 1 || ismember(classes(i),featureSetClass) == 1
                tSetIDs1 = find(ismember(allClasses,classes(i))); % get list of tSet row ID's
                tSet1 = tSet(tSetIDs1',:);
                if fSetIgnoreSubFlg == 0
                    allSubjects = tSet1(:,3);
                    subjects = unique(allSubjects); % list of unique subjects for this particular class
                    for j = 1:size(subjects,1) % process each unique subject for this class
                        tSetIDs2 = find(ismember(allSubjects,subjects(j)));
                        if size(tSetIDs2,1) <= fSetNum 
                            for k = 1: size(tSetIDs2,1)
                                featureSet(cnt,1) = num2cell(tSet1(tSetIDs2(k),4));
                                cnt = cnt + 1;
                            end
                        else
                            % randomly choose indexes without replacement from tSetIDs2 list
                            [tmpIds,garbage] = datasample(tSetIDs2,fSetNum,'Replace',false);
                            for k = 1: size(tmpIds,1)
                                featureSet(cnt,1) = num2cell(tSet1(tmpIds(k),4));
                                cnt = cnt + 1;
                            end
                        end
                    end
                else
                    if size(tSetIDs1,1) <= fSetNum 
                        for k = 1: size(tSet1,1)
                            featureSet(cnt,1) = num2cell(tSet1(k,4));
                            cnt = cnt + 1;
                        end
                    else
                        % randomly choose indexes without replacement from tSetIDs1 list
                        [garbage,tmpIds] = datasample(tSetIDs1,fSetNum,'Replace',false);
                        for k = 1: size(tmpIds,2)
                            featureSet(cnt,1) = num2cell(tSet1(tmpIds(k),4));
                            cnt = cnt + 1;
                        end
                    end
                end
            end
        end
    end

    % values in featureSet point to trainSet ID's.  Chnage this to point to
    % CompMoveData ID's
    for i = 1:size(featureSet,1)
        tSetIdx = cell2mat(featureSet(i,1));
        featureSet(i,1) = trainSet(tSetIdx,1);
        featureSet(i,2) = trainSet(tSetIdx,2);
    end

end