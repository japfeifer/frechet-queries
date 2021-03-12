function seq2 = UCFExtractFeatures(seq,extractMethod,idx)

    HEAD = [1,2,3];
    NECK = [4,5,6];
    TORS = [7,8,9];
    LSHO = [10,11,12];
    LELB = [13,14,15];
    LHND = [16,17,18];
    RSHO = [19,20,21];
    RELB = [22,23,24];
    RHND = [25,26,27];
    LHIP = [28,29,30];
    LKNE = [31,32,33];
    LFOT = [34,35,36];
    RHIP = [37,38,39];
    RKNE = [40,41,42];
    RFOT = [43,44,45];
    
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
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
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
    elseif extractMethod == 9
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
    elseif extractMethod == 10
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3;
        
    elseif extractMethod == 20
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 21
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 22
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RKNE); a=a+3;
    elseif extractMethod == 23
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,TORS); a=a+3;
    elseif extractMethod == 24
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,LHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LKNE); a=a+3;
    elseif extractMethod == 25
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LKNE); a=a+3;
    elseif extractMethod == 26
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
    elseif extractMethod == 27
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LKNE); a=a+3;
    elseif extractMethod == 28
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LHIP); a=a+3;
    elseif extractMethod == 29
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,TORS); a=a+3;
        
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
    elseif extractMethod == 115
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
    elseif extractMethod == 116
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 117
        seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
    elseif extractMethod == 118
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3;
    elseif extractMethod == 119
        seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
    elseif extractMethod == 120
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
    elseif extractMethod == 121
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
        
    elseif extractMethod == 200
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
    elseif extractMethod == 201
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
    elseif extractMethod == 202
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,HEAD); a=a+3;

    elseif extractMethod == 1001 
        seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
    elseif extractMethod ==  1002
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
    elseif extractMethod ==  1003
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
    elseif extractMethod ==  1004
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
    elseif extractMethod ==  1005
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
    elseif extractMethod ==  1006
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
    elseif extractMethod ==  1007
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
    elseif extractMethod ==  1008
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
    elseif extractMethod ==  1009
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
    elseif extractMethod ==  1010
        seq2(:,a:a+2) = seq(:,LHIP); a=a+3;
    elseif extractMethod ==  1011
        seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
    elseif extractMethod ==  1012
        seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
    elseif extractMethod ==  1013
        seq2(:,a:a+2) = seq(:,RHIP); a=a+3;
    elseif extractMethod ==  1014
        seq2(:,a:a+2) = seq(:,RKNE); a=a+3;
    elseif extractMethod ==  1015
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;

    elseif extractMethod ==  1021
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,HEAD); a=a+3;
    elseif extractMethod ==  1022
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,NECK); a=a+3;
    elseif extractMethod ==  1023
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,TORS); a=a+3;
    elseif extractMethod ==  1024
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,LSHO); a=a+3;
    elseif extractMethod ==  1025
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,LELB); a=a+3;
    elseif extractMethod ==  1026
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,LHND); a=a+3;
    elseif extractMethod ==  1027
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RSHO); a=a+3;
    elseif extractMethod ==  1028
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RELB); a=a+3;
    elseif extractMethod ==  1029
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RHND); a=a+3;
    elseif extractMethod ==  1030
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,LHIP); a=a+3;
    elseif extractMethod ==  1031
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,LKNE); a=a+3;
    elseif extractMethod ==  1032
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,LFOT); a=a+3;
    elseif extractMethod ==  1033
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RHIP); a=a+3;
    elseif extractMethod ==  1034
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RKNE); a=a+3;
    elseif extractMethod ==  1035
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RFOT); a=a+3;

    elseif extractMethod ==  1041
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,HEAD); a=a+3;
    elseif extractMethod ==  1042
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,NECK); a=a+3;
    elseif extractMethod ==  1043
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,TORS); a=a+3;
    elseif extractMethod ==  1044
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LSHO); a=a+3;
    elseif extractMethod ==  1045
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LELB); a=a+3;
    elseif extractMethod ==  1046
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LHND); a=a+3;
    elseif extractMethod ==  1047
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RSHO); a=a+3;
    elseif extractMethod ==  1048
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RELB); a=a+3;
    elseif extractMethod ==  1049
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
    elseif extractMethod ==  1050
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LHIP); a=a+3;
    elseif extractMethod ==  1051
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LKNE); a=a+3;
    elseif extractMethod ==  1052
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LFOT); a=a+3;
    elseif extractMethod ==  1053
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHIP); a=a+3;
    elseif extractMethod ==  1054
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RKNE); a=a+3;
    elseif extractMethod ==  1055
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RFOT); a=a+3;

    elseif extractMethod ==  1061
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,HEAD); a=a+3;
    elseif extractMethod ==  1062
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,NECK); a=a+3;
    elseif extractMethod ==  1063
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,TORS); a=a+3;
    elseif extractMethod ==  1064
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LSHO); a=a+3;
    elseif extractMethod ==  1065
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LELB); a=a+3;
    elseif extractMethod ==  1066
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LHND); a=a+3;
    elseif extractMethod ==  1067
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RSHO); a=a+3;
    elseif extractMethod ==  1068
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RELB); a=a+3;
    elseif extractMethod ==  1069
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
    elseif extractMethod ==  1070
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LHIP); a=a+3;
    elseif extractMethod ==  1071
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LKNE); a=a+3;
    elseif extractMethod ==  1072
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LFOT); a=a+3;
    elseif extractMethod ==  1073
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHIP); a=a+3;
    elseif extractMethod ==  1074
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RKNE); a=a+3;
    elseif extractMethod ==  1075
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RFOT); a=a+3;

    elseif extractMethod ==  1081
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,HEAD); a=a+3;
    elseif extractMethod ==  1082
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod ==  1083
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,TORS); a=a+3;
    elseif extractMethod ==  1084
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LSHO); a=a+3;
    elseif extractMethod ==  1085
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LELB); a=a+3;
    elseif extractMethod ==  1086
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LHND); a=a+3;
    elseif extractMethod ==  1087
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RSHO); a=a+3;
    elseif extractMethod ==  1088
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RELB); a=a+3;
    elseif extractMethod ==  1089
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
    elseif extractMethod ==  1090
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LHIP); a=a+3;
    elseif extractMethod ==  1091
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LKNE); a=a+3;
    elseif extractMethod ==  1092
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LFOT); a=a+3;
    elseif extractMethod ==  1093
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHIP); a=a+3;
    elseif extractMethod ==  1094
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RKNE); a=a+3;
    elseif extractMethod ==  1095
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RFOT); a=a+3;

    elseif extractMethod ==  1101
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,HEAD); a=a+3;
    elseif extractMethod ==  1102
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,NECK); a=a+3;
    elseif extractMethod ==  1103
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,TORS); a=a+3;
    elseif extractMethod ==  1104
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
    elseif extractMethod ==  1105
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LELB); a=a+3;
    elseif extractMethod ==  1106
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LHND); a=a+3;
    elseif extractMethod ==  1107
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RSHO); a=a+3;
    elseif extractMethod ==  1108
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RELB); a=a+3;
    elseif extractMethod ==  1109
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHND); a=a+3;
    elseif extractMethod ==  1110
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LHIP); a=a+3;
    elseif extractMethod ==  1111
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LKNE); a=a+3;
    elseif extractMethod ==  1112
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LFOT); a=a+3;
    elseif extractMethod ==  1113
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHIP); a=a+3;
    elseif extractMethod ==  1114
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RKNE); a=a+3;
    elseif extractMethod ==  1115
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RFOT); a=a+3;

    elseif extractMethod ==  1121
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,HEAD); a=a+3;
    elseif extractMethod ==  1122
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,NECK); a=a+3;
    elseif extractMethod ==  1123
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,TORS); a=a+3;
    elseif extractMethod ==  1124
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LSHO); a=a+3;
    elseif extractMethod ==  1125
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LELB); a=a+3;
    elseif extractMethod ==  1126
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LHND); a=a+3;
    elseif extractMethod ==  1127
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RSHO); a=a+3;
    elseif extractMethod ==  1128
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RELB); a=a+3;
    elseif extractMethod ==  1129
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
    elseif extractMethod ==  1130
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LHIP); a=a+3;
    elseif extractMethod ==  1131
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LKNE); a=a+3;
    elseif extractMethod ==  1132
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LFOT); a=a+3;
    elseif extractMethod ==  1133
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHIP); a=a+3;
    elseif extractMethod ==  1134
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RKNE); a=a+3;
    elseif extractMethod ==  1135
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RFOT); a=a+3;

    elseif extractMethod ==  1141
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,HEAD); a=a+3;
    elseif extractMethod ==  1142
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod ==  1143
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,TORS); a=a+3;
    elseif extractMethod ==  1144
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LSHO); a=a+3;
    elseif extractMethod ==  1145
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LELB); a=a+3;
    elseif extractMethod ==  1146
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LHND); a=a+3;
    elseif extractMethod ==  1147
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RSHO); a=a+3;
    elseif extractMethod ==  1148
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RELB); a=a+3;
    elseif extractMethod ==  1149
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
    elseif extractMethod ==  1150
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LHIP); a=a+3;
    elseif extractMethod ==  1151
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LKNE); a=a+3;
    elseif extractMethod ==  1152
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LFOT); a=a+3;
    elseif extractMethod ==  1153
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHIP); a=a+3;
    elseif extractMethod ==  1154
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RKNE); a=a+3;
    elseif extractMethod ==  1155
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RFOT); a=a+3;

    elseif extractMethod ==  1161
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,HEAD); a=a+3;
    elseif extractMethod ==  1162
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,NECK); a=a+3;
    elseif extractMethod ==  1163
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,TORS); a=a+3;
    elseif extractMethod ==  1164
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LSHO); a=a+3;
    elseif extractMethod ==  1165
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LELB); a=a+3;
    elseif extractMethod ==  1166
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LHND); a=a+3;
    elseif extractMethod ==  1167
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
    elseif extractMethod ==  1168
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RELB); a=a+3;
    elseif extractMethod ==  1169
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
    elseif extractMethod ==  1170
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LHIP); a=a+3;
    elseif extractMethod ==  1171
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LKNE); a=a+3;
    elseif extractMethod ==  1172
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LFOT); a=a+3;
    elseif extractMethod ==  1173
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHIP); a=a+3;
    elseif extractMethod ==  1174
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RKNE); a=a+3;
    elseif extractMethod ==  1175
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RFOT); a=a+3;

    elseif extractMethod ==  1181
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,HEAD); a=a+3;
    elseif extractMethod ==  1182
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,NECK); a=a+3;
    elseif extractMethod ==  1183
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,TORS); a=a+3;
    elseif extractMethod ==  1184
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
    elseif extractMethod ==  1185
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LELB); a=a+3;
    elseif extractMethod ==  1186
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
    elseif extractMethod ==  1187
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RSHO); a=a+3;
    elseif extractMethod ==  1188
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
    elseif extractMethod ==  1189
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RHND); a=a+3;
    elseif extractMethod ==  1190
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHIP); a=a+3;
    elseif extractMethod ==  1191
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LKNE); a=a+3;
    elseif extractMethod ==  1192
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LFOT); a=a+3;
    elseif extractMethod ==  1193
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RHIP); a=a+3;
    elseif extractMethod ==  1194
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RKNE); a=a+3;
    elseif extractMethod ==  1195
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RFOT); a=a+3;

    elseif extractMethod ==  1201
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,HEAD); a=a+3;
    elseif extractMethod ==  1202
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,NECK); a=a+3;
    elseif extractMethod ==  1203
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,TORS); a=a+3;
    elseif extractMethod ==  1204
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,LSHO); a=a+3;
    elseif extractMethod ==  1205
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,LELB); a=a+3;
    elseif extractMethod ==  1206
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,LHND); a=a+3;
    elseif extractMethod ==  1207
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,RSHO); a=a+3;
    elseif extractMethod ==  1208
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,RELB); a=a+3;
    elseif extractMethod ==  1209
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,RHND); a=a+3;
    elseif extractMethod ==  1210
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,LHIP); a=a+3;
    elseif extractMethod ==  1211
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,LKNE); a=a+3;
    elseif extractMethod ==  1212
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,LFOT); a=a+3;
    elseif extractMethod ==  1213
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,RHIP); a=a+3;
    elseif extractMethod ==  1214
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,RKNE); a=a+3;
    elseif extractMethod ==  1215
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,RFOT); a=a+3;

    elseif extractMethod ==  1221
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,HEAD); a=a+3;
    elseif extractMethod ==  1222
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,NECK); a=a+3;
    elseif extractMethod ==  1223
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,TORS); a=a+3;
    elseif extractMethod ==  1224
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LSHO); a=a+3;
    elseif extractMethod ==  1225
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LELB); a=a+3;
    elseif extractMethod ==  1226
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LHND); a=a+3;
    elseif extractMethod ==  1227
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,RSHO); a=a+3;
    elseif extractMethod ==  1228
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,RELB); a=a+3;
    elseif extractMethod ==  1229
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,RHND); a=a+3;
    elseif extractMethod ==  1230
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LHIP); a=a+3;
    elseif extractMethod ==  1231
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LKNE); a=a+3;
    elseif extractMethod ==  1232
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LFOT); a=a+3;
    elseif extractMethod ==  1233
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,RHIP); a=a+3;
    elseif extractMethod ==  1234
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,RKNE); a=a+3;
    elseif extractMethod ==  1235
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,RFOT); a=a+3;

    elseif extractMethod ==  1241
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,HEAD); a=a+3;
    elseif extractMethod ==  1242
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,NECK); a=a+3;
    elseif extractMethod ==  1243
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,TORS); a=a+3;
    elseif extractMethod ==  1244
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LSHO); a=a+3;
    elseif extractMethod ==  1245
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LELB); a=a+3;
    elseif extractMethod ==  1246
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LHND); a=a+3;
    elseif extractMethod ==  1247
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,RSHO); a=a+3;
    elseif extractMethod ==  1248
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,RELB); a=a+3;
    elseif extractMethod ==  1249
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,RHND); a=a+3;
    elseif extractMethod ==  1250
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LHIP); a=a+3;
    elseif extractMethod ==  1251
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LKNE); a=a+3;
    elseif extractMethod ==  1252
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LFOT); a=a+3;
    elseif extractMethod ==  1253
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,RHIP); a=a+3;
    elseif extractMethod ==  1254
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,RKNE); a=a+3;
    elseif extractMethod ==  1255
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,RFOT); a=a+3;

    elseif extractMethod ==  1261
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,HEAD); a=a+3;
    elseif extractMethod ==  1262
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,NECK); a=a+3;
    elseif extractMethod ==  1263
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,TORS); a=a+3;
    elseif extractMethod ==  1264
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,LSHO); a=a+3;
    elseif extractMethod ==  1265
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,LELB); a=a+3;
    elseif extractMethod ==  1266
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,LHND); a=a+3;
    elseif extractMethod ==  1267
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,RSHO); a=a+3;
    elseif extractMethod ==  1268
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,RELB); a=a+3;
    elseif extractMethod ==  1269
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,RHND); a=a+3;
    elseif extractMethod ==  1270
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,LHIP); a=a+3;
    elseif extractMethod ==  1271
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,LKNE); a=a+3;
    elseif extractMethod ==  1272
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,LFOT); a=a+3;
    elseif extractMethod ==  1273
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,RHIP); a=a+3;
    elseif extractMethod ==  1274
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,RKNE); a=a+3;
    elseif extractMethod ==  1275
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,RFOT); a=a+3;

    elseif extractMethod ==  1281
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,HEAD); a=a+3;
    elseif extractMethod ==  1282
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,NECK); a=a+3;
    elseif extractMethod ==  1283
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,TORS); a=a+3;
    elseif extractMethod ==  1284
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,LSHO); a=a+3;
    elseif extractMethod ==  1285
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,LELB); a=a+3;
    elseif extractMethod ==  1286
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,LHND); a=a+3;
    elseif extractMethod ==  1287
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RSHO); a=a+3;
    elseif extractMethod ==  1288
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RELB); a=a+3;
    elseif extractMethod ==  1289
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHND); a=a+3;
    elseif extractMethod ==  1290
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,LHIP); a=a+3;
    elseif extractMethod ==  1291
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,LKNE); a=a+3;
    elseif extractMethod ==  1292
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,LFOT); a=a+3;
    elseif extractMethod ==  1293
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3;
    elseif extractMethod ==  1294
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RKNE); a=a+3;
    elseif extractMethod ==  1295
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RFOT); a=a+3;

    elseif extractMethod ==  1301
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,HEAD); a=a+3;
    elseif extractMethod ==  1302
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,NECK); a=a+3;
    elseif extractMethod ==  1303
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,TORS); a=a+3;
    elseif extractMethod ==  1304
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,LSHO); a=a+3;
    elseif extractMethod ==  1305
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,LELB); a=a+3;
    elseif extractMethod ==  1306
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,LHND); a=a+3;
    elseif extractMethod ==  1307
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RSHO); a=a+3;
    elseif extractMethod ==  1308
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RELB); a=a+3;
    elseif extractMethod ==  1309
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RHND); a=a+3;
    elseif extractMethod ==  1310
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,LHIP); a=a+3;
    elseif extractMethod ==  1311
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,LKNE); a=a+3;
    elseif extractMethod ==  1312
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,LFOT); a=a+3;
    elseif extractMethod ==  1313
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RHIP); a=a+3;
    elseif extractMethod ==  1314
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RKNE); a=a+3;
    elseif extractMethod ==  1315
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RFOT); a=a+3;
        
    end

end