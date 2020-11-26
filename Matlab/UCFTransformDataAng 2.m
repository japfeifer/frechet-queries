% take the UCF data and transform into the inputSet and querySet

function UCFTransformDataAng

    global inputSet querySet CompMoveData
    
    inputSet = {[]};
    querySet = {[]};
    inputSetCnt = 1;
    querySetCnt = 1;
    
    TORS = [7,8,9];
    NECK = [4,5,6];
    HEAD = [1,2,3];
    LSHO = [10,11,12];
    LELB = [13,14,15];
    LWST = [16,17,18];
    RSHO = [19,20,21];
    RELB = [22,23,24];
    RWST = [25,26,27];
    LHIP = [28,29,30];
    LKNE = [31,32,33];
    LANK = [34,35,36];
    RHIP = [37,38,39];
    RKNE = [40,41,42];
    RANK = [43,44,45];
    
    CompMoveData = sortrows(CompMoveData,[1,2,3]); % sort by class,subject,seq id
    
    allClasses = CompMoveData(:,1);
    classes = unique(allClasses); % list of unique classes

    for i = 1:size(classes,1) % process each unique tag
        classIDs = find(ismember(allClasses,classes(i)));
        numSample = floor(size(classIDs,1) * 3/4); % 3/4 training, 1/4 test
        tmpValue = [];
        [tmpValue,tagIdIndex] = datasample(classIDs,numSample,'Replace',false); % randomly choose indexes without replacement from classIDs list
        for j = 1:size(classIDs,1) % process each item in classIDs list
            tmpTraj = cell2mat(CompMoveData(classIDs(j),4)); % all the trajectories for this tag
            CompMoveData(classIDs(j),5) = num2cell(i); % store a unique ID for each tag (class)
            
            % compute the angles for this seq
            tmpTraj2 = [];
            for k = 1:size(tmpTraj,1) % for each frame

                ang1 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,RSHO),tmpTraj(k,RELB));
                ang2 = AngDeg3DVec(tmpTraj(k,RSHO),tmpTraj(k,RELB),tmpTraj(k,RWST));
                ang3 = AngDeg3DVec(tmpTraj(k,TORS),tmpTraj(k,NECK),tmpTraj(k,RELB));
                ang4 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,RELB),tmpTraj(k,TORS));
                ang5 = AngDeg3DVec(tmpTraj(k,RELB),tmpTraj(k,TORS),tmpTraj(k,NECK));
                ang6 = AngDeg3DVec(tmpTraj(k,TORS),tmpTraj(k,NECK),tmpTraj(k,RWST));
                ang7 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,RWST),tmpTraj(k,TORS));
                ang8 = AngDeg3DVec(tmpTraj(k,RWST),tmpTraj(k,TORS),tmpTraj(k,NECK));
                ang9 = AngDeg3DVec(tmpTraj(k,RHIP),tmpTraj(k,RKNE),tmpTraj(k,RANK));
                ang10 = AngDeg3DVec(tmpTraj(k,LHIP),tmpTraj(k,LKNE),tmpTraj(k,LANK));

                ang18 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,LSHO),tmpTraj(k,LELB));
                ang19 = AngDeg3DVec(tmpTraj(k,LSHO),tmpTraj(k,LELB),tmpTraj(k,LWST));
                ang20 = AngDeg3DVec(tmpTraj(k,TORS),tmpTraj(k,NECK),tmpTraj(k,LELB));
                ang21 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,LELB),tmpTraj(k,TORS));
                ang22 = AngDeg3DVec(tmpTraj(k,LELB),tmpTraj(k,TORS),tmpTraj(k,NECK));
                ang23 = AngDeg3DVec(tmpTraj(k,TORS),tmpTraj(k,NECK),tmpTraj(k,LWST));
                ang24 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,LWST),tmpTraj(k,TORS));
                ang25 = AngDeg3DVec(tmpTraj(k,LWST),tmpTraj(k,TORS),tmpTraj(k,NECK));

                tmpTraj2(k,:) = [ang1 ang2 ang3 ang4 ang5 ang6 ang7 ang8 ang9 ang10  ...
                                 ang18 ang19 ang20 ang21 ang22 ang23 ang24 ang25 ];

            end
            
            if ismember(j,tagIdIndex) % put this one in the inputSet
                inputSet(inputSetCnt,1) = num2cell(classIDs(j)); % source id
                inputSet(inputSetCnt,2) = num2cell(i);         % tag
                inputSet(inputSetCnt,3) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
                inputSetCnt = inputSetCnt + 1;
            else % put this one in the querySet
                querySet(querySetCnt,1) = num2cell(classIDs(j)); % source id
                querySet(querySetCnt,2) = num2cell(i);         % tag
                querySet(querySetCnt,3) = mat2cell(tmpTraj2,size(tmpTraj2,1),size(tmpTraj2,2));
                querySetCnt = querySetCnt + 1;            
            end
        end
    end
end
