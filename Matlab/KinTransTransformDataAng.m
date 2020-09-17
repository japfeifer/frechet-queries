% take the KinTrans data and transform into the inputSet and querySet

function KinTransTransformDataAng(numSample)

    global inputSet querySet CompMoveData
    
    inputSet = {[]};
    querySet = {[]};
    inputSetCnt = 1;
    querySetCnt = 1;
    
    TORS = [4,5,6];
    NECK = [1,2,3];
    LSHO = [19,20,21];
    LELB = [22,23,24];
    LWST = [25,26,27];
    LHND = [28,29,30];
    RSHO = [7,8,9];
    RELB = [10,11,12];
    RWST = [13,14,15];
    RHND = [16,17,18];
    
    CompMoveData = sortrows(CompMoveData,[1,2,3]); % sort by class,subject,seq id
    
    allClasses = CompMoveData(:,1);
    classes = unique(allClasses); % list of unique classes

    for i = 1:size(classes,1) % process each unique tag
        classIDs = find(ismember(allClasses,classes(i)));
        tmpValue = [];
        [tmpValue,tagIdIndex] = datasample(classIDs,numSample,'Replace',false); % randomly choose indexes without replacement from classIDs list
        for j = 1:size(classIDs,1) % process each item in classIDs list
            tmpTraj = cell2mat(CompMoveData(classIDs(j),4)); % all the trajectories for this tag
            CompMoveData(classIDs(j),5) = num2cell(i); % store a unique ID for each tag (class)
            
            % compute the angles for this seq
            tmpTraj2 = [];
            for k = 1:size(tmpTraj,1) % for each frame
                
                ang1 = AngDeg3DVec(tmpTraj(k,RSHO),tmpTraj(k,RELB),tmpTraj(k,RWST));
                ang2 = AngDeg3DVec(tmpTraj(k,LSHO),tmpTraj(k,LELB),tmpTraj(k,LWST));
                ang3 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,RSHO),tmpTraj(k,RELB));
                ang4 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,LSHO),tmpTraj(k,LELB));
                ang5 = AngDeg3DVec(tmpTraj(k,RWST),tmpTraj(k,NECK),tmpTraj(k,TORS));
                ang6 = AngDeg3DVec(tmpTraj(k,LWST),tmpTraj(k,NECK),tmpTraj(k,TORS));
                ang7 = AngDeg3DVec(tmpTraj(k,RELB),tmpTraj(k,NECK),tmpTraj(k,TORS));
                ang8 = AngDeg3DVec(tmpTraj(k,LELB),tmpTraj(k,NECK),tmpTraj(k,TORS));
                ang9 = AngDeg3DVec(tmpTraj(k,RWST),tmpTraj(k,TORS),tmpTraj(k,NECK));
                ang10 = AngDeg3DVec(tmpTraj(k,LWST),tmpTraj(k,TORS),tmpTraj(k,NECK));
                ang11 = AngDeg3DVec(tmpTraj(k,RELB),tmpTraj(k,TORS),tmpTraj(k,NECK));
                ang12 = AngDeg3DVec(tmpTraj(k,LELB),tmpTraj(k,TORS),tmpTraj(k,NECK));
                ang13 = AngDeg3DVec(tmpTraj(k,RHND),tmpTraj(k,NECK),tmpTraj(k,TORS));
                ang14 = AngDeg3DVec(tmpTraj(k,LHND),tmpTraj(k,NECK),tmpTraj(k,TORS));
                ang15 = AngDeg3DVec(tmpTraj(k,RHND),tmpTraj(k,TORS),tmpTraj(k,NECK));
                ang16 = AngDeg3DVec(tmpTraj(k,LHND),tmpTraj(k,TORS),tmpTraj(k,NECK));
                ang17 = AngDeg3DVec(tmpTraj(k,RHND),tmpTraj(k,RSHO),tmpTraj(k,NECK));
                ang18 = AngDeg3DVec(tmpTraj(k,LHND),tmpTraj(k,LSHO),tmpTraj(k,NECK));
                ang19 = AngDeg3DVec(tmpTraj(k,RHND),tmpTraj(k,RSHO),tmpTraj(k,TORS));
                ang20 = AngDeg3DVec(tmpTraj(k,LHND),tmpTraj(k,LSHO),tmpTraj(k,TORS));
                ang21 = AngDeg3DVec(tmpTraj(k,RWST),tmpTraj(k,RSHO),tmpTraj(k,NECK));
                ang22 = AngDeg3DVec(tmpTraj(k,LWST),tmpTraj(k,LSHO),tmpTraj(k,NECK));
                ang23 = AngDeg3DVec(tmpTraj(k,RWST),tmpTraj(k,RSHO),tmpTraj(k,TORS));
                ang24 = AngDeg3DVec(tmpTraj(k,LWST),tmpTraj(k,LSHO),tmpTraj(k,TORS));
                
                tmpTraj2(k,:) = [ang1 ang2 ang3 ang4 ang5 ang6 ang7 ang8 ang9 ang10 ...
                                 ang11 ang12 ang13 ang14 ang15 ang16 ang17 ang18 ang19 ang20 ang21 ang22 ang23 ang24 ];

%                 ang1 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,RSHO),tmpTraj(k,RELB));
%                 ang2 = AngDeg3DVec(tmpTraj(k,RSHO),tmpTraj(k,RELB),tmpTraj(k,RWST));
%                 ang3 = AngDeg3DVec(tmpTraj(k,TORS),tmpTraj(k,NECK),tmpTraj(k,RELB));
%                 ang4 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,RELB),tmpTraj(k,TORS));
%                 ang5 = AngDeg3DVec(tmpTraj(k,RELB),tmpTraj(k,TORS),tmpTraj(k,NECK));
%                 ang6 = AngDeg3DVec(tmpTraj(k,TORS),tmpTraj(k,NECK),tmpTraj(k,RWST));
%                 ang7 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,RWST),tmpTraj(k,TORS));
%                 ang8 = AngDeg3DVec(tmpTraj(k,RWST),tmpTraj(k,TORS),tmpTraj(k,NECK));
%                 ang9 = AngDeg3DVec(tmpTraj(k,TORS),tmpTraj(k,NECK),tmpTraj(k,RHND));
%                 ang10 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,RHND),tmpTraj(k,TORS));
%                 ang11 = AngDeg3DVec(tmpTraj(k,RHND),tmpTraj(k,TORS),tmpTraj(k,NECK));
%                 ang12 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,RSHO),tmpTraj(k,RHND));
%                 ang13 = AngDeg3DVec(tmpTraj(k,RSHO),tmpTraj(k,RHND),tmpTraj(k,NECK));
%                 ang14 = AngDeg3DVec(tmpTraj(k,RHND),tmpTraj(k,NECK),tmpTraj(k,RSHO));
%                 ang15 = AngDeg3DVec(tmpTraj(k,TORS),tmpTraj(k,RSHO),tmpTraj(k,RHND));
%                 ang16 = AngDeg3DVec(tmpTraj(k,RSHO),tmpTraj(k,RHND),tmpTraj(k,TORS));
%                 ang17 = AngDeg3DVec(tmpTraj(k,RHND),tmpTraj(k,TORS),tmpTraj(k,RSHO));
%                 
%                 ang18 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,LSHO),tmpTraj(k,LELB));
%                 ang19 = AngDeg3DVec(tmpTraj(k,LSHO),tmpTraj(k,LELB),tmpTraj(k,LWST));
%                 ang20 = AngDeg3DVec(tmpTraj(k,TORS),tmpTraj(k,NECK),tmpTraj(k,LELB));
%                 ang21 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,LELB),tmpTraj(k,TORS));
%                 ang22 = AngDeg3DVec(tmpTraj(k,LELB),tmpTraj(k,TORS),tmpTraj(k,NECK));
%                 ang23 = AngDeg3DVec(tmpTraj(k,TORS),tmpTraj(k,NECK),tmpTraj(k,LWST));
%                 ang24 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,LWST),tmpTraj(k,TORS));
%                 ang25 = AngDeg3DVec(tmpTraj(k,LWST),tmpTraj(k,TORS),tmpTraj(k,NECK));
%                 ang26 = AngDeg3DVec(tmpTraj(k,TORS),tmpTraj(k,NECK),tmpTraj(k,LHND));
%                 ang27 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,LHND),tmpTraj(k,TORS));
%                 ang28 = AngDeg3DVec(tmpTraj(k,LHND),tmpTraj(k,TORS),tmpTraj(k,NECK));
%                 ang29 = AngDeg3DVec(tmpTraj(k,NECK),tmpTraj(k,LSHO),tmpTraj(k,LHND));
%                 ang30 = AngDeg3DVec(tmpTraj(k,LSHO),tmpTraj(k,LHND),tmpTraj(k,NECK));
%                 ang31 = AngDeg3DVec(tmpTraj(k,LHND),tmpTraj(k,NECK),tmpTraj(k,LSHO));
%                 ang32 = AngDeg3DVec(tmpTraj(k,TORS),tmpTraj(k,LSHO),tmpTraj(k,LHND));
%                 ang33 = AngDeg3DVec(tmpTraj(k,LSHO),tmpTraj(k,LHND),tmpTraj(k,TORS));
%                 ang34 = AngDeg3DVec(tmpTraj(k,LHND),tmpTraj(k,TORS),tmpTraj(k,LSHO));
% 
%                 tmpTraj2(k,:) = [ang1 ang2 ang3 ang4 ang5 ang6 ang7 ang8 ang9 ang10 ...
%                                  ang11 ang12 ang13 ang14 ang15 ang16 ang17 ang18 ang19 ang20 ...
%                                  ang21 ang22 ang23 ang24 ang25 ang26 ang27 ang28 ang29 ang30 ...
%                                  ang31 ang32 ang33 ang34];
             
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
