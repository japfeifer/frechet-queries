function seq2 = LMExtractFeatures(seq,extractMethod,idx)

    global CompMoveData

    % seq joints
    LTPR = [1,2,3];       LTDI = [4,5,6];       LTEF = [7,8,9];
    LIPR = [10,11,12];    LIME = [13,14,15];    LIDI = [16,17,18];    LIEF = [19,20,21];
    LMPR = [22,23,24];    LMME = [25,26,27];    LMDI = [28,29,30];    LMEF = [31,32,33];
    LRPR = [34,35,36];    LRME = [37,38,39];    LRDI = [40,41,42];    LREF = [43,44,45];
    LPPR = [46,47,48];    LPME = [49,50,51];    LPDI = [52,53,54];    LPEF = [55,56,57];
    LPAL = [58,59,60];    LWST = [61,62,63];    LHND = [64,65,66];    LELB = [67,68,69];
    LAFR = [70,71,72];    LAFU = [73,74,75];    LABL = [76,77,78];    LABM = [79,80,81];
    RTPR = [82,83,84];    RTDI = [85,86,87];    RTEF = [88,89,90];
    RIPR = [91,92,93];    RIME = [94,95,96];    RIDI = [97,98,99];    RIEF = [100,101,102];
    RMPR = [103,104,105]; RMME = [106,107,108]; RMDI = [109,110,111]; RMEF = [112,113,114];
    RRPR = [115,116,117]; RRME = [118,119,120]; RRDI = [121,122,123]; RREF = [124,125,126];
    RPPR = [127,128,129]; RPME = [130,131,132]; RPDI = [133,134,135]; RPEF = [136,137,138];
    RPAL = [139,140,141]; RWST = [142,143,144]; RHND = [145,146,147]; RELB = [148,149,150];
    RAFR = [151,152,153]; RAFU = [154,155,156]; RABL = [157,158,159]; RABM = [160,161,162];
    
    seq2 = [];
    a = 1;
    
    if extractMethod == 1 
        % extract only finger/thumb tips and wrist for both hands
        % allow wrists to move, with original coordinates
        seq2(:,a:a+2) = seq(:,LTEF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,LREF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,RREF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF)  ; a=a+3;
    elseif extractMethod == 2
        % extract only finger/thumb tips and wrist for both hands
        % keep boths wrists at origin
        seq2(:,a:a+2) = seq(:,LTEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RWST);  a=a+3;
    elseif extractMethod == 3 
        % extract fingers relative to thumb for both hands
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RTEF);  a=a+3;
    elseif extractMethod == 4 
        % extract only finger/thumb tips and wrist for both hands
        % keep boths wrists at origin
        seq2(:,a:a+2) = seq(:,LTEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RWST);  a=a+3;
        % extract fingers relative to thumb for both hands
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RTEF);  a=a+3;
    elseif extractMethod == 5 
        % extract only finger/thumb tips and wrist for both hands
        % keep boths wrists at origin
        seq2(:,a:a+2) = seq(:,LTEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RWST);  a=a+3;
        % extract fingers relative to thumb for both hands
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RTEF);  a=a+3;
        % extract left & right wrist absolute movement
        seq2(:,a:a+2) = seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RWST);  a=a+3;
    elseif extractMethod == 6
        % extract only finger/thumb tips and wrist for both hands
        % keep boths wrists at origin
        seq2(:,a:a+2) = seq(:,LTEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RWST);  a=a+3;
        % extract fingers relative to thumb for both hands
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RTEF);  a=a+3;
        % extract left & right wrist absolute movement
        seq2(:,a:a+2) = seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RWST);  a=a+3;
        % extract right wrist relative to left wrist
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,LWST);  a=a+3;
    elseif extractMethod == 7
        seq = cell2mat(CompMoveData(idx,4)); % retrieve raw seq
        seq = LMNormalizeSeq(seq,[0 0 0 0 0 1]); % normalize seq
        seq2(:,a:a+2) = seq(:,LTEF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,LREF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,RREF)  ; a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF)  ; a=a+3;
    elseif extractMethod == 8
        % extract finger/thumb tips relative to their respective knuckles
        seq2(:,a:a+2) = seq(:,LTEF) - seq(:,LHND);  a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LMPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LRPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LPPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RHND);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RMPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RRPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RPPR);  a=a+3;
        % extract fingers relative to thumb for both hands
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RTEF);  a=a+3;
        % extract left & right wrist/knuckles absolute movement
        seq2(:,a:a+2) = seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPPR);  a=a+3;
        % extract right index finger wrist relative to left middle finger
        % knuckle
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LMPR);  a=a+3;
    elseif extractMethod == 9
        % extract only finger/thumb tips and wrist for both hands
        % keep boths wrists at origin
        seq2(:,a:a+2) = seq(:,LTEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RWST);  a=a+3;
        % extract fingers relative to thumb for both hands
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RTEF);  a=a+3;
        % extract left & right wrist/knuckles absolute movement
        seq2(:,a:a+2) = seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPPR);  a=a+3;
        % extract right wrist relative to left wrist
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,LWST);  a=a+3;
    elseif extractMethod == 10
        seq = cell2mat(CompMoveData(idx,4)); % retrieve raw seq
        seq = LMNormalizeSeq(seq,[1 1 1 1 1]); % normalize seq
        % extract finger/thumb tips relative to their respective knuckles
        seq2(:,a:a+2) = seq(:,LTEF) - seq(:,LHND);  a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LMPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LRPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LPPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RHND);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RMPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RRPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RPPR);  a=a+3;
        % extract fingers relative to thumb for both hands
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RTEF);  a=a+3;
        % extract left & right wrist/knuckles absolute movement
        seq2(:,a:a+2) = seq(:,LWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,LIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RWST);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPPR);  a=a+3;
        % extract right index finger wrist relative to left middle finger
        % knuckle
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LMPR);  a=a+3;
    elseif extractMethod == 11
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF); a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RPPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RHND);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RMPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LTEF);  a=a+3;
    elseif extractMethod == 12
        seq2(:,a:a+2) = seq(:,RREF); a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RPPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LIPR);  a=a+3;
        
    elseif extractMethod == 20    
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF); a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RPPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RHND);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RMPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LTEF);  a=a+3;
        
    elseif extractMethod == 21
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RPPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RMPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RAFU); a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LMPR);  a=a+3;
    elseif extractMethod == 22
        seq2(:,a:a+2) = seq(:,RREF); a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RPPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LIPR);  a=a+3;
    elseif extractMethod == 23
        seq2(:,a:a+2) = seq(:,LRPR); a=a+3;
        seq2(:,a:a+2) = seq(:,LRME); a=a+3;
        seq2(:,a:a+2) = seq(:,LRDI); a=a+3;
        seq2(:,a:a+2) = seq(:,LREF); a=a+3;
        seq2(:,a:a+2) = seq(:,RIPR); a=a+3;
        seq2(:,a:a+2) = seq(:,RIME); a=a+3;
        seq2(:,a:a+2) = seq(:,RIDI); a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF); a=a+3;
    elseif extractMethod == 24
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RHND);  a=a+3;
    elseif extractMethod == 25
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RIPR);  a=a+3;
    elseif extractMethod == 26
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RMPR);  a=a+3;
    elseif extractMethod == 27
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RRPR);  a=a+3;
    elseif extractMethod == 28
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RPPR);  a=a+3;
        
        
    elseif extractMethod == 101
        seq2(:,a:a+2) = seq(:,LTPR); a=a+3;
        seq2(:,a:a+2) = seq(:,LTDI); a=a+3;
        seq2(:,a:a+2) = seq(:,LTEF); a=a+3;
    elseif extractMethod == 102
        seq2(:,a:a+2) = seq(:,LIPR); a=a+3;
        seq2(:,a:a+2) = seq(:,LIME); a=a+3;
        seq2(:,a:a+2) = seq(:,LIDI); a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF); a=a+3;
    elseif extractMethod == 103
        seq2(:,a:a+2) = seq(:,LMPR); a=a+3;
        seq2(:,a:a+2) = seq(:,LMME); a=a+3;
        seq2(:,a:a+2) = seq(:,LMDI); a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF); a=a+3;
    elseif extractMethod == 104
        seq2(:,a:a+2) = seq(:,LRPR); a=a+3;
        seq2(:,a:a+2) = seq(:,LRME); a=a+3;
        seq2(:,a:a+2) = seq(:,LRDI); a=a+3;
        seq2(:,a:a+2) = seq(:,LREF); a=a+3;
    elseif extractMethod == 105
        seq2(:,a:a+2) = seq(:,LPPR); a=a+3;
        seq2(:,a:a+2) = seq(:,LPME); a=a+3;
        seq2(:,a:a+2) = seq(:,LPDI); a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF); a=a+3;
    elseif extractMethod == 106
        seq2(:,a:a+2) = seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LAFR); a=a+3;
        seq2(:,a:a+2) = seq(:,LAFU); a=a+3;
        seq2(:,a:a+2) = seq(:,LABL); a=a+3;
        seq2(:,a:a+2) = seq(:,LABM); a=a+3;
    elseif extractMethod == 107
        seq2(:,a:a+2) = seq(:,RTPR); a=a+3;
        seq2(:,a:a+2) = seq(:,RTDI); a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF); a=a+3;
    elseif extractMethod == 108
        seq2(:,a:a+2) = seq(:,RIPR); a=a+3;
        seq2(:,a:a+2) = seq(:,RIME); a=a+3;
        seq2(:,a:a+2) = seq(:,RIDI); a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF); a=a+3;
    elseif extractMethod == 109
        seq2(:,a:a+2) = seq(:,RMPR); a=a+3;
        seq2(:,a:a+2) = seq(:,RMME); a=a+3;
        seq2(:,a:a+2) = seq(:,RMDI); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF); a=a+3;
    elseif extractMethod == 110
        seq2(:,a:a+2) = seq(:,RRPR); a=a+3;
        seq2(:,a:a+2) = seq(:,RRME); a=a+3;
        seq2(:,a:a+2) = seq(:,RRDI); a=a+3;
        seq2(:,a:a+2) = seq(:,RREF); a=a+3;
    elseif extractMethod == 111
        seq2(:,a:a+2) = seq(:,RPPR); a=a+3;
        seq2(:,a:a+2) = seq(:,RPME); a=a+3;
        seq2(:,a:a+2) = seq(:,RPDI); a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF); a=a+3;
    elseif extractMethod == 112
        seq2(:,a:a+2) = seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RAFR); a=a+3;
        seq2(:,a:a+2) = seq(:,RAFU); a=a+3;
        seq2(:,a:a+2) = seq(:,RABL); a=a+3;
        seq2(:,a:a+2) = seq(:,RABM); a=a+3;
    elseif extractMethod == 113
        seq2(:,a:a+2) = seq(:,LTEF) - seq(:,LHND);  a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LMPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LRPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LPPR);  a=a+3;
    elseif extractMethod == 114
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RHND);  a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RIPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RMPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RRPR);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RPPR);  a=a+3;
    elseif extractMethod == 115
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LTEF);  a=a+3;
    elseif extractMethod == 116
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RTEF);  a=a+3;
    elseif extractMethod == 200
        seq2(:,a:a+2) = seq(:,RREF); a=a+3;
        seq2(:,a:a+2) = seq(:,LIDI); a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RAFU); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF); a=a+3;
    elseif extractMethod == 201
        seq2(:,a:a+2) = seq(:,RMEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RREF); a=a+3;
    elseif extractMethod == 202
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,LMPR);  a=a+3;
    elseif extractMethod == 203
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LRPR);  a=a+3;
    elseif extractMethod == 204
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RIPR);  a=a+3;
    elseif extractMethod == 205
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RMPR);  a=a+3;
    elseif extractMethod == 206
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RTEF);  a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RTEF);  a=a+3;
    elseif extractMethod == 207
        seq2(:,a:a+2) = seq(:,RREF); a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RIPR); a=a+3;
        seq2(:,a:a+2) = seq(:,RAFU); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;

    end

end