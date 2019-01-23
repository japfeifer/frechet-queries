function dist = BoundBoxDist(P,Q,deg,cType,id1,id2)

    global trajData queryTraj

    if ~exist('cType','var')
        cType = 0;
        id1 = 0;
        id2 = 0;
    end
    
    sPDim = size(P,2);

    % get BB for P & Q
    if cType == 0 % compute P & Q bounding boxes
        PBB = ComputeBB(P,deg);
        QBB = ComputeBB(P,deg);
    elseif cType == 1 || cType == 2 % the bounding box was pre-computed
        if deg == 0
            PBB = cell2mat(trajData(id1,3));
            if cType == 1
                QBB = cell2mat(queryTraj(id2,20));
            else
                QBB = cell2mat(trajData(id2,3));
            end
        elseif deg == 22.5
            PBB = cell2mat(trajData(id1,4));
            if cType == 1
                QBB = cell2mat(queryTraj(id2,21));
            else
                QBB = cell2mat(trajData(id2,4));
            end
        elseif deg == 45
            PBB = cell2mat(trajData(id1,5));
            if cType == 1
                QBB = cell2mat(queryTraj(id2,22));
            else
                QBB = cell2mat(trajData(id2,5));
            end
        end
    end
    
    dist = max(max(abs(PBB - QBB)));
    
    % now check if BB dist from corresponding edge to edge is greater than
    % dist we have already calculated. 
    if sPDim <= 3
        for i = 1:size(P,2) % loop on each dimension
            for j = 1:size(P,2) % loop on each dimension
                if i ~= j % only check where dimensions are different
                    tmpDist1 = 0;
                    tmpDist2 = 0;
                    % calc Pbox, Qbox if cType == 0
                    if cType == 0
                        PBB = [min(P);max(P)];
                        Qbox = [min(Q);max(Q)];
                    end

                    % get coordinates for P and Q
                    PMin = PBB(1,i);
                    PMax = PBB(2,i);
                    QMin = QBB(1,i);
                    QMax = QBB(2,i);
                    PMin2 = PBB(1,j);
                    PMax2 = PBB(2,j);
                    QMin2 = QBB(1,j);
                    QMax2 = QBB(2,j);

                    % if edges do not overlap, calc new distances
                    if PMin2 > QMax2
                        tmpDist1 = CalcPointDist([PMin PMin2],[QMin QMax2]);
                        tmpDist2 = CalcPointDist([PMax PMin2],[QMax QMax2]);
                    elseif PMax2 < QMin2
                        tmpDist1 = CalcPointDist([PMin PMax2],[QMin QMin2]);
                        tmpDist2 = CalcPointDist([PMax PMax2],[QMax QMin2]);
                    end
                    if tmpDist1 > dist
                        dist = tmpDist1;
                    end
                    if tmpDist2 > dist
                        dist = tmpDist2;
                    end

                end
            end
        end
    end
    
    dist = round(dist,10)+0.00000000009;
    dist = fix(dist * 10^10)/10^10;
end