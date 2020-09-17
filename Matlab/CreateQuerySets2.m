% Create k-fold cross-subject validation training sets
% Separate based on subject

function CreateQuerySets2(numSets)

    global CompMoveData querySetKFold
    
    querySetKFold = [];
    currEnd(1:numSets) = 1;
    CompMoveData2 = sortrows(CompMoveData,[2,1,3]); % sort by subject,class,seq id
    allSubjects = CompMoveData2(:,2);
    subjects = unique(allSubjects);
    
    % create matrix of subject Id's
    subList = [];
    i = 1; j = 1;
    while size(subjects,1) > 0
        [SubjectName,subjectID] = datasample(subjects,1,'Replace',false);
        [garbage subjectNum] = strtok(cell2mat(SubjectName)); % get subject number
        subjectNum = str2num(subjectNum); % convert subject number into 'double' datatype
        subList(i,j) = subjectNum;
        i = i + 1; % set new indices
        if i > numSets
            i = 1; j = j + 1;
        end
        subjects(subjectID,:) = []; % remove subject from list
    end
    
    % assign each seq in CompMoveData to a spot in querySetKFold
    for i = 1:size(CompMoveData,1)
        [garbage subjectNum] = strtok(cell2mat(CompMoveData(i,2))); % get subject number
        subjectNum = str2num(subjectNum); % convert subject number into 'double' datatype
        for j = 1:size(subList,1)
            if ismember(subjectNum,subList(j,:)) % find subNum
                querySetKFold(j,currEnd(j)) = i;
                currEnd(j) = currEnd(j) + 1;
            end
        end
    end
    
end
