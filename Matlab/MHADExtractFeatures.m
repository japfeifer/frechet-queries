function seq2 = MHADExtractFeatures(seq,extractMethod)

    TORS = [1,2,3];
    NECK = [4,5,6];
    HEAD = [7,8,9];
    RSHO = [10,11,12];
    RELB = [13,14,15];
    RHND = [16,17,18];
    LSHO = [19,20,21];
    LELB = [22,23,24];
    LHND = [25,26,27];
    RHIP = [28,29,30];
    RKNE = [31,32,33];
    RFOT = [34,35,36];
    LHIP = [37,38,39];
    LKNE = [40,41,42];
    LFOT = [43,44,45];
    
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
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
    elseif extractMethod == 8
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LHIP); a=a+3;
    elseif extractMethod == 9
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3;
    elseif extractMethod == 10
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 11
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
    elseif extractMethod == 12
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
        
    elseif extractMethod == 101
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
    elseif extractMethod == 102
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
    elseif extractMethod == 103
        seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
    elseif extractMethod == 104
        seq2(:,a:a+2) = seq(:,LHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
    elseif extractMethod == 105
        seq2(:,a:a+2) = seq(:,RHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
    elseif extractMethod == 106
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 107
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 108
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 109
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 110
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,TORS); a=a+3;
    elseif extractMethod == 111
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,TORS); a=a+3;
    elseif extractMethod == 112
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,NECK); a=a+3;
    elseif extractMethod == 113
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,TORS); a=a+3; % RHIP relative to TORS
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3; % RKNE relative to RHIP
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RKNE); a=a+3; % RFOT relative to RKNE
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,TORS); a=a+3; % LHIP relative to TORS
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LHIP); a=a+3; % LKNE relative to LHIP
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LKNE); a=a+3; % LFOT relative to LKNE
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
    elseif extractMethod == 114
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