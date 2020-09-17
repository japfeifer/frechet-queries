function featureSet = CreateFeatureSet(fSetNum)

    global trainSet CompMoveData
    
    if fSetNum == 0
        featureSet = [1:size(trainSet,1)];
        featureSet = featureSet';
    else
        
        featureSet = [];
        tSet = [];
        for i = 1:size(trainSet,1)
            tSet(i,1) = cell2mat(trainSet(i,1));
            tSet(i,2) = cell2mat(trainSet(i,2));
            [garbage subjectNum] = strtok(cell2mat(CompMoveData(tSet(i,1),2))); % get subject number
            subjectNum = str2num(subjectNum); % convert subject number into 'double' datatype
            tSet(i,3) = subjectNum;
            tSet(i,4) = i;
        end
        tSet = sortrows(tSet,[2,3,1]); % sort by class,subject,CompMove id
        
        allClasses = tSet(:,2);
        classes = unique(allClasses); % list of unique classes
        
        for i = 1:size(classes,1) % process each unique class
            tSetIDs1 = find(ismember(allClasses,classes(i))); % get list of tSet row ID's
            tSet1 = tSet(tSetIDs1',:);
            allSubjects = tSet1(:,3);
            subjects = unique(allSubjects); % list of unique subjects for this particular class
            for j = 1:size(subjects,1) % process each unique subject for this class
                tSetIDs2 = find(ismember(allSubjects,subjects(j)));
                if size(tSetIDs2,1) <= fSetNum 
                    for k = 1: size(tSetIDs2,1)
                        featureSet(end+1,:) = tSet1(tSetIDs2(k),4);
                    end
                else
                    % randomly choose indexes without replacement from tSetIDs2 list
                    [tmpIds,garbage] = datasample(tSetIDs2,fSetNum,'Replace',false);
                    for k = 1: size(tmpIds,1)
                        featureSet(end+1,:) = tSet1(tmpIds(k),4);
                    end
                end
            end
        end
    end

end