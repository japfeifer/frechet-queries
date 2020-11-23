function seq2 = UCFExtractFeatures2(seq,def,idx)

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
    
    for i = 1:size(def,2)
        switch def(i)
            case 1 
                seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
            case 2
                seq2(:,a:a+2) = seq(:,NECK); a=a+3;
            case 3
                seq2(:,a:a+2) = seq(:,TORS); a=a+3;
            case 4
                seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
            case 5
                seq2(:,a:a+2) = seq(:,LELB); a=a+3;
            case 6
                seq2(:,a:a+2) = seq(:,LHND); a=a+3;
            case 7
                seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
            case 8
                seq2(:,a:a+2) = seq(:,RELB); a=a+3;
            case 9
                seq2(:,a:a+2) = seq(:,RHND); a=a+3;
            case 10
                seq2(:,a:a+2) = seq(:,LHIP); a=a+3;
            case 11
                seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
            case 12
                seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
            case 13
                seq2(:,a:a+2) = seq(:,RHIP); a=a+3;
            case 14
                seq2(:,a:a+2) = seq(:,RKNE); a=a+3;
            case 15
                seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
            case 16
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,HEAD); a=a+3;
            case 17
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LELB); a=a+3;
            case 18
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
            case 19
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
            case 20
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
            case 21
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
            case 22
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
            case 23
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,NECK); a=a+3;
            case 24
                seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LKNE); a=a+3;
            case 25
                seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LHIP); a=a+3;
            case 26
                seq2(:,a:a+2) = seq(:,LHIP) - seq(:,TORS); a=a+3;
            case 27
                seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RKNE); a=a+3;
            case 28
                seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3;
            case 29
                seq2(:,a:a+2) = seq(:,RHIP) - seq(:,TORS); a=a+3;
            case 30
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
            case 31
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
            case 32
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,RSHO); a=a+3;
            case 33
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,TORS); a=a+3;
            case 34
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,TORS); a=a+3;
                
            case 101
                seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB); a=a+3;
                seq2(:,a:a+2) = seq(:,LHND); a=a+3;
            case 102
                seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB); a=a+3;
                seq2(:,a:a+2) = seq(:,RHND); a=a+3;
            case 103
                seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
                seq2(:,a:a+2) = seq(:,NECK); a=a+3;
                seq2(:,a:a+2) = seq(:,TORS); a=a+3;
            case 104
                seq2(:,a:a+2) = seq(:,LHIP); a=a+3;
                seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
                seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
            case 105
                seq2(:,a:a+2) = seq(:,RHIP); a=a+3;
                seq2(:,a:a+2) = seq(:,RKNE); a=a+3;
                seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
            case 106
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
            case 107
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
            case 108
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LELB); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
            case 109
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
            case 110
                seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LKNE); a=a+3;
                seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LHIP); a=a+3;
                seq2(:,a:a+2) = seq(:,LHIP) - seq(:,TORS); a=a+3;
            case 111
                seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RKNE); a=a+3;
                seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3;
                seq2(:,a:a+2) = seq(:,RHIP) - seq(:,TORS); a=a+3;
            case 112
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,NECK); a=a+3;
                seq2(:,a:a+2) = seq(:,HEAD) - seq(:,NECK); a=a+3;
            case 113
                seq2(:,a:a+2) = seq(:,RHIP) - seq(:,TORS); a=a+3; % RHIP relative to TORS
                seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3; % RKNE relative to RHIP
                seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RKNE); a=a+3; % RFOT relative to RKNE
                seq2(:,a:a+2) = seq(:,LHIP) - seq(:,TORS); a=a+3; % LHIP relative to TORS
                seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LHIP); a=a+3; % LKNE relative to LHIP
                seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LKNE); a=a+3; % LFOT relative to LKNE
                seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
                seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
            case 114
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
end