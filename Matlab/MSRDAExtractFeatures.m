function seq2 = MSRDAExtractFeatures(seq,extractMethod)

    TORS = [1,2,3]; BACK = [4,5,6]; NECK = [7,8,9]; HEAD = [10,11,12];
    LSHO = [13,14,15]; LELB = [16,17,18]; LWST = [19,20,21]; LHND = [22,23,24];
    RSHO = [25,26,27]; RELB = [28,29,30]; RWST = [31,32,33]; RHND = [34,35,36];
    LHIP = [37,38,39]; LKNE = [40,41,42]; LANK = [43,44,45]; LFOT = [46,47,48];
    RHIP = [49,50,51]; RKNE = [52,53,54]; RANK = [55,56,57]; RFOT = [58,59,60];
    
    seq2 = [];
    a = 1;
    
    if extractMethod == 1
        % move right and left shoulders to origin
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO);  a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RSHO);  a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO);  a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LSHO);  a=a+3;
        % hands relative to ELB
        seq2(:,a:a+2) = (seq(:,RHND) - seq(:,RELB));  a=a+3;
        seq2(:,a:a+2) = (seq(:,LHND) - seq(:,LELB));  a=a+3;
        % move right and left hips to origin
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP);  a=a+3;
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RHIP);  a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LHIP);  a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LHIP);  a=a+3;
        % feet relative to knee
        seq2(:,a:a+2) = (seq(:,RFOT) - seq(:,RKNE));  a=a+3;
        seq2(:,a:a+2) = (seq(:,LFOT) - seq(:,LKNE));  a=a+3;
    elseif extractMethod == 2
        % just the absolute traj
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,LHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
    elseif extractMethod == 3
        % ELB/WST/HND relative to (above) adjacent joint
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3; % RSHO relative to NECK
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3; % RELB relative to RSHO
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3; % RHND relative to RELB
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3; % LSHO relative to NECK
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3; % LELB relative to LSHO
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LELB); a=a+3; % LHND relative to LELB
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,NECK); a=a+3; % HEAD relative to NECK
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,NECK); a=a+3; % TORS relative to NECK
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,TORS); a=a+3; % RHIP relative to TORS
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3; % RKNE relative to RHIP
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RKNE); a=a+3; % RFOT relative to RKNE
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,TORS); a=a+3; % LHIP relative to TORS
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LHIP); a=a+3; % LKNE relative to LHIP
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LKNE); a=a+3; % LFOT relative to LKNE
    elseif extractMethod == 4
        % right side absolute traj
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
    elseif extractMethod == 5
        % left side absolute traj
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
    elseif extractMethod == 6
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LKNE); a=a+3;
    elseif extractMethod == 7
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,TORS); a=a+3; % RHIP relative to TORS
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3; % RKNE relative to RHIP
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RKNE); a=a+3; % RFOT relative to RKNE
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,TORS); a=a+3; % LHIP relative to TORS
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LHIP); a=a+3; % LKNE relative to LHIP
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LKNE); a=a+3; % LFOT relative to LKNE
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
    elseif extractMethod == 8
        % ELB/WST/HND relative to (above) adjacent joint
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3; % RSHO relative to NECK
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3; % RELB relative to RSHO
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3; % RHND relative to RELB
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3; % LSHO relative to NECK
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3; % LELB relative to LSHO
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LELB); a=a+3; % LHND relative to LELB
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,NECK); a=a+3; % HEAD relative to NECK
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,NECK); a=a+3; % TORS relative to NECK
    end

end