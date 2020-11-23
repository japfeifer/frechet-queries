function seq2 = NTURGBDExtractFeaturesOld(seq,extractMethod)

    global numCoordCurr

    HIP  = [1,2,3]; SPIN = [4,5,6]; NECK = [7,8,9]; HEAD = [10,11,12];
    LSHO = [13,14,15]; LELB = [16,17,18]; LWST = [19,20,21]; LHND = [22,23,24];
    RSHO = [25,26,27]; RELB = [28,29,30]; RWST = [31,32,33]; RHND = [34,35,36];
    LHIP = [37,38,39]; LKNE = [40,41,42]; LANK = [43,44,45]; LFOT = [46,47,48];
    RHIP = [49,50,51]; RKNE = [52,53,54]; RANK = [55,56,57]; RFOT = [58,59,60];
    SHO  = [61,62,63]; LTIP = [64,65,66]; LTHM = [67,68,69]; RTIP = [70,71,72]; RTHM = [73,74,75];
    
    seq2 = [];
    numSub = size(seq,2) / 75;
    
    for i = 1:numSub
        idx1 = i*75 - (75 - 1);  idx2 = idx1 + (75 - 1);
        subSeq = seq(:,idx1:idx2);
        newSeq = [];
        a = 1;

        if extractMethod == 1 
            % just keep sequence as-is
            newSeq = subSeq;
        elseif extractMethod == 2
            newSeq(:,a:a+2) = subSeq(:,HIP); a=a+3;
            newSeq(:,a:a+2) = subSeq(:,HEAD); a=a+3;
            newSeq(:,a:a+2) = subSeq(:,LSHO); a=a+3;
            newSeq(:,a:a+2) = subSeq(:,LELB); a=a+3;
            newSeq(:,a:a+2) = subSeq(:,LWST); a=a+3;
            newSeq(:,a:a+2) = subSeq(:,LHND); a=a+3;
            newSeq(:,a:a+2) = subSeq(:,RSHO); a=a+3;
            newSeq(:,a:a+2) = subSeq(:,RELB); a=a+3;
            newSeq(:,a:a+2) = subSeq(:,RWST); a=a+3;
            newSeq(:,a:a+2) = subSeq(:,RHND); a=a+3;
            newSeq(:,a:a+2) = subSeq(:,LKNE); a=a+3;
            newSeq(:,a:a+2) = subSeq(:,LFOT); a=a+3;
            newSeq(:,a:a+2) = subSeq(:,RKNE); a=a+3;
            newSeq(:,a:a+2) = subSeq(:,RFOT); a=a+3;
        elseif extractMethod == 3
            newSeq(:,a:a+2) = subSeq(:,LHND) - subSeq(:,LWST); a=a+3; % relative
            newSeq(:,a:a+2) = subSeq(:,LWST) - subSeq(:,LELB); a=a+3; % relative
            newSeq(:,a:a+2) = subSeq(:,LELB) - subSeq(:,LSHO); a=a+3; % relative
            newSeq(:,a:a+2) = subSeq(:,LFOT) - subSeq(:,LANK); a=a+3; % relative
            newSeq(:,a:a+2) = subSeq(:,LANK) - subSeq(:,LKNE); a=a+3; % relative
            newSeq(:,a:a+2) = subSeq(:,LKNE) - subSeq(:,LHIP); a=a+3; % relative
            newSeq(:,a:a+2) = subSeq(:,RHND) - subSeq(:,RWST); a=a+3; % relative
            newSeq(:,a:a+2) = subSeq(:,RWST) - subSeq(:,RELB); a=a+3; % relative
            newSeq(:,a:a+2) = subSeq(:,RELB) - subSeq(:,RSHO); a=a+3; % relative
            newSeq(:,a:a+2) = subSeq(:,RFOT) - subSeq(:,RANK); a=a+3; % relative
            newSeq(:,a:a+2) = subSeq(:,RANK) - subSeq(:,RKNE); a=a+3; % relative
            newSeq(:,a:a+2) = subSeq(:,RKNE) - subSeq(:,RHIP); a=a+3; % relative
            newSeq(:,a:a+2) = subSeq(:,HEAD) - subSeq(:,HIP); a=a+3; % relative
            newSeq(:,a:a+2) = subSeq(:,RHND) - subSeq(:,LHND); a=a+3; % relative
        end
        
        numCoordCurr = a -1;
        seq2 = [seq2 newSeq];
    
    end

end