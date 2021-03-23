function seq2 = KinTransExtractFeatures(seq,extractMethod)

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
    
    seq2 = [];
    a = 1;
    
    if extractMethod == 1 
        % just keep sequence as-is
        seq2 = seq;
    elseif extractMethod == 2
        % move right and left shoulders to origin
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO);  a=a+3;
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RSHO);  a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RSHO);  a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO);  a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LSHO);  a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LSHO);  a=a+3;
        % wrists relative to ELB
        seq2(:,a:a+2) = (seq(:,RWST) - seq(:,RELB));  a=a+3;
        seq2(:,a:a+2) = (seq(:,LWST) - seq(:,LELB));  a=a+3;
    elseif extractMethod == 3
        % move right and left elbows to origin
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RELB);  a=a+3; 
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB);  a=a+3;  
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LELB);  a=a+3; 
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LELB);  a=a+3;
    elseif extractMethod == 4
        % ELB/WST/HND relative to (above) adjacent joint
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3; % RELB relative to RSHO
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RELB); a=a+3; % RWST relative to RELB
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RWST); a=a+3; % RHND relative to RWST
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3; % LELB relative to LSHO
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LELB); a=a+3; % LWST relative to LELB
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LWST); a=a+3; % LHND relative to LWST  
    elseif extractMethod == 5
        % right ELB/WST/HND absolute traj
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
    elseif extractMethod == 6
        % left ELB/WST/HND absolute traj
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
    elseif extractMethod == 20
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
    elseif extractMethod == 21
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
    elseif extractMethod == 22
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
    elseif extractMethod == 23
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
    elseif extractMethod == 24
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
    elseif extractMethod == 25
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 26
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 27
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 28
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
    elseif extractMethod == 29
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
    elseif extractMethod == 30
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
    elseif extractMethod == 31
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
    elseif extractMethod == 32
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
    elseif extractMethod == 33
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
    elseif extractMethod == 34
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 35
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
    elseif extractMethod == 36
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
    elseif extractMethod == 37
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
    elseif extractMethod == 38
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
    elseif extractMethod == 39
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 40
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
    elseif extractMethod == 41
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
    elseif extractMethod == 42
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LHND); a=a+3;
    elseif extractMethod == 43
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
    elseif extractMethod == 44
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
    elseif extractMethod == 45
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 46
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,TORS); a=a+3;
    elseif extractMethod == 47
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 48
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
    elseif extractMethod == 49
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,TORS); a=a+3;
    elseif extractMethod == 50
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
    elseif extractMethod == 51
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
    elseif extractMethod == 52
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 53
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
    elseif extractMethod == 54
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
    elseif extractMethod == 55
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
    elseif extractMethod == 56
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
    elseif extractMethod == 57
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,TORS); a=a+3;
    elseif extractMethod == 58
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
    elseif extractMethod == 59
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 60
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
    elseif extractMethod == 61
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
    elseif extractMethod == 62
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHND); a=a+3;
    elseif extractMethod == 63
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
    elseif extractMethod == 64
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RWST); a=a+3;
    elseif extractMethod == 65
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LELB); a=a+3;
    elseif extractMethod == 66
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
    elseif extractMethod == 67
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 68
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,LHND); a=a+3;
    elseif extractMethod == 69
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 70
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,NECK); a=a+3;
    elseif extractMethod == 71
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LELB); a=a+3;
    elseif extractMethod == 72
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,LHND); a=a+3;
    elseif extractMethod == 73
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RELB); a=a+3;
    elseif extractMethod == 74
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
    elseif extractMethod == 75
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
    elseif extractMethod == 76
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,LWST); a=a+3;
    elseif extractMethod == 77
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
    elseif extractMethod == 78
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
    elseif extractMethod == 79
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
    elseif extractMethod == 80
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
    elseif extractMethod == 81
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;

    elseif extractMethod == 101
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
    elseif extractMethod == 102
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
    elseif extractMethod == 103
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
    elseif extractMethod == 104
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 105
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 106
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 107
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 108    
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,NECK); a=a+3;
    elseif extractMethod == 109
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
    elseif extractMethod == 110
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        
    elseif extractMethod == 200
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
    elseif extractMethod == 201
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LWST); a=a+3;
    elseif extractMethod == 202
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
    elseif extractMethod == 203
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,TORS); a=a+3; 
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,TORS); a=a+3;
    elseif extractMethod == 204
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
    elseif extractMethod == 205
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,TORS); a=a+3;  
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,TORS); a=a+3;  
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,TORS); a=a+3;  
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,TORS); a=a+3;  
    elseif extractMethod == 206
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
    elseif extractMethod == 207
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RELB); a=a+3;
    elseif extractMethod == 208
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
    elseif extractMethod == 209
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
     elseif extractMethod == 210
         seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
     elseif extractMethod == 211
         seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
     elseif extractMethod == 212
         seq2(:,a:a+2) = seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS); a=a+3;
         seq2(:,a:a+2) = seq(:,NECK); a=a+3;
         seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
         seq2(:,a:a+2) = seq(:,LELB); a=a+3;
     elseif extractMethod == 213
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,LSHO); a=a+3;
         seq2(:,a:a+2) = seq(:,RHND) - seq(:,TORS); a=a+3; 
     elseif extractMethod == 214
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
     elseif extractMethod == 215
         seq2(:,a:a+2) = seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST); a=a+3;
         seq2(:,a:a+2) = seq(:,LELB); a=a+3;
         seq2(:,a:a+2) = seq(:,NECK); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS); a=a+3;
         seq2(:,a:a+2) = seq(:,RELB); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
         seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
         seq2(:,a:a+2) = seq(:,RWST); a=a+3;
     elseif extractMethod == 216
         seq2(:,a:a+2) = seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST); a=a+3;
         seq2(:,a:a+2) = seq(:,LELB); a=a+3;
         seq2(:,a:a+2) = seq(:,NECK); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS); a=a+3;
     elseif extractMethod == 217
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
     elseif extractMethod == 218
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RELB); a=a+3;
     elseif extractMethod == 219
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
     elseif extractMethod == 220
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RWST); a=a+3;
         seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST); a=a+3;
     elseif extractMethod == 221
         seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
     elseif extractMethod == 222
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
     elseif extractMethod == 223
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
     elseif extractMethod == 224
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
     elseif extractMethod == 225
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
         seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RHND); a=a+3;
     elseif extractMethod == 226
         seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
     elseif extractMethod == 227
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
     elseif extractMethod == 228
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,LWST); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
     elseif extractMethod == 229
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
     elseif extractMethod == 230
         seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
         seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
     elseif extractMethod == 231
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
     elseif extractMethod == 232
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,LWST); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
     elseif extractMethod == 233
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,LWST); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
     elseif extractMethod == 234
         seq2(:,a:a+2) = seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST); a=a+3;
         seq2(:,a:a+2) = seq(:,LELB); a=a+3;
         seq2(:,a:a+2) = seq(:,NECK); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS); a=a+3;
     elseif extractMethod == 235
         seq2(:,a:a+2) = seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST); a=a+3;
         seq2(:,a:a+2) = seq(:,LELB); a=a+3;
         seq2(:,a:a+2) = seq(:,NECK); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS); a=a+3;
     elseif extractMethod == 236
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,LSHO); a=a+3;
         seq2(:,a:a+2) = seq(:,RHND) - seq(:,TORS); a=a+3;
     elseif extractMethod == 237
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,LSHO); a=a+3;
         seq2(:,a:a+2) = seq(:,RHND) - seq(:,TORS); a=a+3;  
     elseif extractMethod == 238
         seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LELB); a=a+3;
     elseif extractMethod == 239
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
     elseif extractMethod == 240
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
     elseif extractMethod == 241
         seq2(:,a:a+2) = seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,LHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
     elseif extractMethod == 242
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RWST); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,LHND); a=a+3;
     elseif extractMethod == 243
         seq2(:,a:a+2) = seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST); a=a+3;
         seq2(:,a:a+2) = seq(:,LELB); a=a+3;
         seq2(:,a:a+2) = seq(:,NECK); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS); a=a+3;
     elseif extractMethod == 244
         seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RELB); a=a+3;
         seq2(:,a:a+2) = seq(:,LELB) - seq(:,RSHO); a=a+3;
         seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LELB); a=a+3;
     elseif extractMethod == 245
         seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
     elseif extractMethod == 246
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
     elseif extractMethod == 247
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
     elseif extractMethod == 248
         seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
     elseif extractMethod == 249
         seq2(:,a:a+2) = seq(:,TORS); a=a+3;
         seq2(:,a:a+2) = seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST); a=a+3;
         seq2(:,a:a+2) = seq(:,RELB); a=a+3;
     elseif extractMethod == 250
         seq2(:,a:a+2) = seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST); a=a+3;
         seq2(:,a:a+2) = seq(:,NECK); a=a+3;
         seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
     elseif extractMethod == 251
         seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
     elseif extractMethod == 252
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
     elseif extractMethod == 253
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
     elseif extractMethod == 254
         seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
     elseif extractMethod == 255
         seq2(:,a:a+2) = seq(:,TORS); a=a+3;
         seq2(:,a:a+2) = seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST); a=a+3;
         seq2(:,a:a+2) = seq(:,RELB); a=a+3;
     elseif extractMethod == 256
         seq2(:,a:a+2) = seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST); a=a+3;
         seq2(:,a:a+2) = seq(:,NECK); a=a+3;
         seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
     elseif extractMethod == 257
         seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
     elseif extractMethod == 258
         seq2(:,a:a+2) = seq(:,LELB); a=a+3;
         seq2(:,a:a+2) = seq(:,RELB); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST); a=a+3;
     elseif extractMethod == 259
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LWST); a=a+3;
     elseif extractMethod == 260
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LWST); a=a+3;
     elseif extractMethod == 261
         seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,LWST); a=a+3;
     elseif extractMethod == 262
         seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
         seq2(:,a:a+2) = seq(:,LWST); a=a+3;
         seq2(:,a:a+2) = seq(:,TORS) - seq(:,RELB); a=a+3;
         seq2(:,a:a+2) = seq(:,RELB); a=a+3;
         seq2(:,a:a+2) = seq(:,NECK) - seq(:,RELB); a=a+3;
         seq2(:,a:a+2) = seq(:,LELB) - seq(:,LWST); a=a+3;
    elseif extractMethod == 263
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 264
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 265
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LHND); a=a+3;
    elseif extractMethod == 266
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,TORS); a=a+3;
    elseif extractMethod == 267
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 268
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
    elseif extractMethod == 269
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
    elseif extractMethod == 270
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
    elseif extractMethod == 270
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
    elseif extractMethod == 271
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
    elseif extractMethod == 272
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LELB); a=a+3;
    elseif extractMethod == 273
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
    elseif extractMethod == 274
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LHND); a=a+3;
    elseif extractMethod == 275
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RWST); a=a+3;
    elseif extractMethod == 276
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
    elseif extractMethod == 277
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 278
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
    elseif extractMethod == 279
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 280
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHND); a=a+3;
    elseif extractMethod == 281
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
    elseif extractMethod == 282
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RWST); a=a+3;
    elseif extractMethod == 283
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LHND); a=a+3;
    elseif extractMethod == 284
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 285
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
    elseif extractMethod == 286
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 287
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;

    elseif extractMethod == 1001
        seq2(:,a:a+2) = seq(:,TORS); a=a+3;
    elseif extractMethod == 1002
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
    elseif extractMethod == 1003
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
    elseif extractMethod == 1004
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
    elseif extractMethod == 1005
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
    elseif extractMethod == 1006
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
    elseif extractMethod == 1007
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
    elseif extractMethod == 1008
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
    elseif extractMethod == 1009
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
    elseif extractMethod == 1010
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
    elseif extractMethod == 1011
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,TORS); a=a+3;  
    elseif extractMethod == 1012
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1013
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1014
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1015
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1016
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,LHND); a=a+3;
    elseif extractMethod == 1017
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1018
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1019
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1020
        seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
    elseif extractMethod == 1021
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,TORS); a=a+3;  
    elseif extractMethod == 1022
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1023
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1024
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1025
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1026
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LHND); a=a+3;
    elseif extractMethod == 1027
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1028
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1029
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1030
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
    elseif extractMethod == 1031
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,TORS); a=a+3;  
    elseif extractMethod == 1032
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1033
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1034
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1035
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1036
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LHND); a=a+3;
    elseif extractMethod == 1037
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1038
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1039
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1040
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
    elseif extractMethod == 1041
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,TORS); a=a+3;  
    elseif extractMethod == 1042
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1043
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1044
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1045
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1046
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LHND); a=a+3;
    elseif extractMethod == 1047
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1048
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1049
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1050
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHND); a=a+3;
    elseif extractMethod == 1051
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,TORS); a=a+3;  
    elseif extractMethod == 1052
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1053
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1054
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1055
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1056
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LHND); a=a+3;
    elseif extractMethod == 1057
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1058
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1059
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1060
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
    elseif extractMethod == 1061
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,TORS); a=a+3;  
    elseif extractMethod == 1062
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1063
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1064
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1065
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1066
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LHND); a=a+3;
    elseif extractMethod == 1067
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1068
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1069
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1070
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
    elseif extractMethod == 1071
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,TORS); a=a+3;  
    elseif extractMethod == 1072
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1073
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1074
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1075
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1076
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LHND); a=a+3;
    elseif extractMethod == 1077
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1078
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1079
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1080
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
    elseif extractMethod == 1081
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,TORS); a=a+3;  
    elseif extractMethod == 1082
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1083
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1084
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1085
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1086
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LHND); a=a+3;
    elseif extractMethod == 1087
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1088
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1089
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1090
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
    elseif extractMethod == 1091
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,TORS); a=a+3;  
    elseif extractMethod == 1092
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1093
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1094
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1095
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1096
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,LHND); a=a+3;
    elseif extractMethod == 1097
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1098
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1099
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1100
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
    elseif extractMethod == 1101
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,TORS); a=a+3;  
    elseif extractMethod == 1102
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1103
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1104
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1105
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1106
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
    elseif extractMethod == 1107
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1108
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1109
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1110
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RHND); a=a+3;    
        
    end

end

   