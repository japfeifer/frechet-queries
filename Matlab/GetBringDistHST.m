
function dist = GetBringDistHST(startIdxP,endIdxP,Q,lenQ,level,distFlg)

    global inpLen inP inpTrajVert
    
    % distFlg: 0 = LB, 1 = UB
    
    lb = size(inpTrajVert,2);
    if level < lb
        endIdxP = endIdxP - 1; % *** the enIdx - 1 is for the Driemel simplification search logic
    end
    
    startIdxQ = 1;
    endIdxQ = size(lenQ,1);
    midIdxQ = floor((startIdxQ + endIdxQ)/2);
    midIdxP = floor((endIdxP + startIdxP)/2);
    
    valQ = max(lenQ(midIdxQ,1) - lenQ(startIdxQ,1) , lenQ(endIdxQ,1) - lenQ(midIdxQ,1));
    valP = max(inpLen(midIdxP,level) - inpLen(startIdxP,level) , inpLen(endIdxP,level) - inpLen(midIdxP,level));
    midDistPQ = CalcPointDist(inP(inpTrajVert(midIdxP,level),:), Q(midIdxQ,:));
    
    if distFlg == 0 % compute LB
        dist = max(midDistPQ - valP - valQ, 0);
    else % compute UB
        dist = midDistPQ + valP + valQ;
    end

end