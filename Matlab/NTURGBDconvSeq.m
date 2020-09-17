
HIP  = [1,2,3]; SPIN = [4,5,6]; NECK = [7,8,9]; HEAD = [10,11,12];
LSHO = [13,14,15]; LELB = [16,17,18]; LWST = [19,20,21]; LHND = [22,23,24];
RSHO = [25,26,27]; RELB = [28,29,30]; RWST = [31,32,33]; RHND = [34,35,36];
LHIP = [37,38,39]; LKNE = [40,41,42]; LANK = [43,44,45]; LFOT = [46,47,48];
RHIP = [49,50,51]; RKNE = [52,53,54]; RANK = [55,56,57]; RFOT = [58,59,60];
SHO  = [61,62,63]; LTIP = [64,65,66]; LTHM = [67,68,69]; RTIP = [70,71,72]; RTHM = [73,74,75];

CompMoveData2 = {[]};
twoActions = ["punching-slapping other person",...
           "kicking other person","pushing other person","pat on back of other person","point finger at the other person","hugging other person",...
           "giving something to other person","touch other person's pocket","handshaking","walking towards each other","walking apart from each other"];
maxCols = 0;
twoFlg = 0;
szData = size(CompMoveData,1);
tic;
h = waitbar(0, 'Convert NTU-RBG+D Seq');

for i = 1:szData % for each raw seq (may contain > 1 subject)
    X = ['Convert NTU-RBG+D Seq: ',num2str(i),'/',num2str(szData)];
    waitbar(i/szData, h, X);
    seq = cell2mat(CompMoveData(i,4));
    cols = size(seq,2);
    numSeqRows = size(seq,1);
    if ismember(CompMoveData(i,1),twoActions) == true
        twoFlg = 1; % this is a two-person seq
    else
        twoFlg = 0; % this is a one person seq
    end
    seqList = {[]};
    numSub = cols / 75; % number of subjects in this seq

    for j = 1:numSub % gather stats on each of the subjects in the seq
        idx1 = j*75 - 74;  idx2 = idx1 + 74;
        currSeq = seq(:,idx1:idx2);
        seqList(j,1) = mat2cell(currSeq,size(currSeq,1),size(currSeq,2));
        SHO_RSHO = [];
        RSHO_RELB = [];
        RELB_RWST = [];
        SHO_LSHO = [];
        LSHO_LELB = [];
        LELB_LWST = [];
        HIP_RHIP = [];
        RHIP_RKNE = [];
        RKNE_RANK = [];
        HIP_LHIP = [];
        LHIP_LKNE = [];
        LKNE_LANK = [];
        RANK_MOVE = [];
        LANK_MOVE = [];
        RHND_MOVE = [];
        LHND_MOVE = [];
        BBXY = [];
        ang1 = [];
        ang2 = [];
        ang3 = [];
        ang4 = [];
        RELB_LSHO = [];
        LELB_RSHO = [];
        
        for k = 1:size(currSeq,1) % for each seq frame do
            RSHO_RELB(k) = CalcPointDist(currSeq(k,RSHO),currSeq(k,RELB));
            RELB_RWST(k) = CalcPointDist(currSeq(k,RELB),currSeq(k,RWST));
            LSHO_LELB(k) = CalcPointDist(currSeq(k,LSHO),currSeq(k,LELB));
            LELB_LWST(k) = CalcPointDist(currSeq(k,LELB),currSeq(k,LWST));
            RHIP_RKNE(k) = CalcPointDist(currSeq(k,RHIP),currSeq(k,RKNE));
            RKNE_RANK(k) = CalcPointDist(currSeq(k,RKNE),currSeq(k,RANK));
            LHIP_LKNE(k) = CalcPointDist(currSeq(k,LHIP),currSeq(k,LKNE));
            LKNE_LANK(k) = CalcPointDist(currSeq(k,LKNE),currSeq(k,LANK));
            RELB_LSHO(k) = CalcPointDist(currSeq(k,RELB),currSeq(k,LSHO));
            LELB_RSHO(k) = CalcPointDist(currSeq(k,LELB),currSeq(k,RSHO));
            maxX = max([currSeq(k,HIP(1)) currSeq(k,SPIN(1)) currSeq(k,NECK(1)) ...
                        currSeq(k,HEAD(1)) currSeq(k,LSHO(1)) currSeq(k,LELB(1)) ...
                        currSeq(k,LWST(1)) currSeq(k,LHND(1)) currSeq(k,RSHO(1)) ...
                        currSeq(k,RELB(1)) currSeq(k,RWST(1)) currSeq(k,RHND(1)) ...
                        currSeq(k,LHIP(1)) currSeq(k,LKNE(1)) currSeq(k,LANK(1)) ...
                        currSeq(k,LFOT(1)) currSeq(k,RHIP(1)) currSeq(k,RKNE(1)) ...
                        currSeq(k,RANK(1)) currSeq(k,RFOT(1)) currSeq(k,SHO(1)) ...
                        currSeq(k,LTIP(1)) currSeq(k,LTHM(1)) currSeq(k,RTIP(1)) ...
                        currSeq(k,RTHM(1))]);
            minX = min([currSeq(k,HIP(1)) currSeq(k,SPIN(1)) currSeq(k,NECK(1)) ...
                        currSeq(k,HEAD(1)) currSeq(k,LSHO(1)) currSeq(k,LELB(1)) ...
                        currSeq(k,LWST(1)) currSeq(k,LHND(1)) currSeq(k,RSHO(1)) ...
                        currSeq(k,RELB(1)) currSeq(k,RWST(1)) currSeq(k,RHND(1)) ...
                        currSeq(k,LHIP(1)) currSeq(k,LKNE(1)) currSeq(k,LANK(1)) ...
                        currSeq(k,LFOT(1)) currSeq(k,RHIP(1)) currSeq(k,RKNE(1)) ...
                        currSeq(k,RANK(1)) currSeq(k,RFOT(1)) currSeq(k,SHO(1)) ...
                        currSeq(k,LTIP(1)) currSeq(k,LTHM(1)) currSeq(k,RTIP(1)) ...
                        currSeq(k,RTHM(1))]);
            maxY = max([currSeq(k,HIP(2)) currSeq(k,SPIN(2)) currSeq(k,NECK(2)) ...
                        currSeq(k,HEAD(2)) currSeq(k,LSHO(2)) currSeq(k,LELB(2)) ...
                        currSeq(k,LWST(2)) currSeq(k,LHND(2)) currSeq(k,RSHO(2)) ...
                        currSeq(k,RELB(2)) currSeq(k,RWST(2)) currSeq(k,RHND(2)) ...
                        currSeq(k,LHIP(2)) currSeq(k,LKNE(2)) currSeq(k,LANK(2)) ...
                        currSeq(k,LFOT(2)) currSeq(k,RHIP(2)) currSeq(k,RKNE(2)) ...
                        currSeq(k,RANK(2)) currSeq(k,RFOT(2)) currSeq(k,SHO(2)) ...
                        currSeq(k,LTIP(2)) currSeq(k,LTHM(2)) currSeq(k,RTIP(2)) ...
                        currSeq(k,RTHM(2))]);
            minY = min([currSeq(k,HIP(2)) currSeq(k,SPIN(2)) currSeq(k,NECK(2)) ...
                        currSeq(k,HEAD(2)) currSeq(k,LSHO(2)) currSeq(k,LELB(2)) ...
                        currSeq(k,LWST(2)) currSeq(k,LHND(2)) currSeq(k,RSHO(2)) ...
                        currSeq(k,RELB(2)) currSeq(k,RWST(2)) currSeq(k,RHND(2)) ...
                        currSeq(k,LHIP(2)) currSeq(k,LKNE(2)) currSeq(k,LANK(2)) ...
                        currSeq(k,LFOT(2)) currSeq(k,RHIP(2)) currSeq(k,RKNE(2)) ...
                        currSeq(k,RANK(2)) currSeq(k,RFOT(2)) currSeq(k,SHO(2)) ...
                        currSeq(k,LTIP(2)) currSeq(k,LTHM(2)) currSeq(k,RTIP(2)) ...
                        currSeq(k,RTHM(2))]);
            BBXY(k) = (maxX - minX) / (maxY - minY);
            ang1(k) = AngDeg3DVec(currSeq(k,HEAD),currSeq(k,NECK),currSeq(k,SHO));
            ang2(k) = AngDeg3DVec(currSeq(k,SPIN),currSeq(k,HIP),currSeq(k,RHIP));
            ang3(k) = AngDeg3DVec(currSeq(k,SPIN),currSeq(k,HIP),currSeq(k,LHIP));
            ang4(k) = AngDeg3DVec(currSeq(k,LSHO),currSeq(k,SHO),currSeq(k,RSHO));
        
            if k ~= size(currSeq,1)
                RANK_MOVE(k) = CalcPointDist(currSeq(k,RFOT),currSeq(k+1,RFOT));
                LANK_MOVE(k) = CalcPointDist(currSeq(k,LFOT),currSeq(k+1,LFOT));
                RHND_MOVE(k) = CalcPointDist(currSeq(k,RTIP),currSeq(k+1,RTIP));
                LHND_MOVE(k) = CalcPointDist(currSeq(k,LTIP),currSeq(k+1,LTIP));
            end
        end

        seqList(j,2) = num2cell(1); % keep or not flag
        seqList(j,3) = num2cell(sum(RANK_MOVE) + sum(LANK_MOVE) + sum(RHND_MOVE) + sum(LHND_MOVE));
        seqList(j,4) = num2cell(abs(1 - median(RSHO_RELB) / median(LSHO_LELB)));
        seqList(j,5) = num2cell(abs(1 - median(RELB_RWST) / median(LELB_LWST)));
        seqList(j,6) = num2cell(abs(1 - median(RHIP_RKNE) / median(LHIP_LKNE)));
        seqList(j,7) = num2cell(abs(1 - median(RKNE_RANK) / median(LKNE_LANK)));

        seqList(j,8) = num2cell(min(BBXY));
        seqList(j,9) = num2cell(max(BBXY));
        seqList(j,10) = num2cell(median(BBXY));
        seqList(j,11) = num2cell(median(ang1));
        seqList(j,12) = num2cell(median(ang2));
        seqList(j,13) = num2cell(median(ang3));
        seqList(j,14) = num2cell(median(ang4));
        
        seqList(j,15) = num2cell(median(RELB_LSHO));
        seqList(j,16) = num2cell(median(LELB_RSHO));
  
    end

    for j = 1:size(seqList,1) % determine if we should discard any seq
         if cell2mat(seqList(j,8)) > 0.65 && cell2mat(seqList(j,9)) > 0.80
             seqList(j,2) = num2cell(0);
%          elseif cell2mat(seqList(j,11)) < 125 
%              seqList(j,2) = num2cell(0);
%          elseif cell2mat(seqList(j,12)) < 60 || cell2mat(seqList(j,12)) > 120
%              seqList(j,2) = num2cell(0);
%          elseif cell2mat(seqList(j,13)) < 60 || cell2mat(seqList(j,13)) > 120
%              seqList(j,2) = num2cell(0);
%          elseif cell2mat(seqList(j,15)) < 0.15 || cell2mat(seqList(j,16)) < 0.15
%              seqList(j,2) = num2cell(0);
         elseif cell2mat(seqList(j,14)) < 140
             seqList(j,2) = num2cell(0);
         end
        
    end

    seqList = sortrows(seqList,[2,3],'descend'); % sort by keep or not, and movement distance, descending order
    numSubIncl = 0;
    newSeq = [];
    for j = 1:size(seqList,1)
        if cell2mat(seqList(j,2)) == 1
            tmpSeq = cell2mat(seqList(j,1));
            idx1 = j*75 - 74;  idx2 = idx1 + 74;
            newSeq(:,idx1:idx2) = tmpSeq;
            numSubIncl = numSubIncl + 1;
        end
        if numSubIncl == 2
            break
        end
    end
    
    if isempty(newSeq) == true
        disp(['index: ',num2str(i),' **** no people in seq ****']);
    end
    
    if numSubIncl == 2 && twoFlg == 0
        disp(['index: ',num2str(i),' **** two people in a one person seq ****']);
    end
    
    if numSubIncl == 1 && twoFlg == 1
        disp(['index: ',num2str(i),' **** one person in a two people seq ****']);
    end
    
    % put in "dummy subject" if required
    if size(newSeq,2) == 0
        newSeq(1:numSeqRows,1:150) = 0;
    elseif size(newSeq,2) == 75
        newSeq(1:numSeqRows,76:150) = 0;
    end
    
    reach = TrajReach(newSeq); % get traj reach 
    newSeq = TrajSimp(newSeq,reach * 0.02); % simplify sequence to speed up experiment processing

    CompMoveData2(i,1) = CompMoveData(i,1);
    CompMoveData2(i,2) = CompMoveData(i,2);
    CompMoveData2(i,3) = CompMoveData(i,3);
    CompMoveData2(i,4) = mat2cell(newSeq,size(newSeq,1),size(newSeq,2));
    
end
close(h);
timeElapsed = toc;