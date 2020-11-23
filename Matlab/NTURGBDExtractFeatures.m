function seq2 = NTURGBDExtractFeatures(seq,extractMethod)

    HIP  = [1,2,3]; SPIN = [4,5,6]; NECK = [7,8,9]; HEAD = [10,11,12];
    LSHO = [13,14,15]; LELB = [16,17,18]; LWST = [19,20,21]; LHND = [22,23,24];
    RSHO = [25,26,27]; RELB = [28,29,30]; RWST = [31,32,33]; RHND = [34,35,36];
    LHIP = [37,38,39]; LKNE = [40,41,42]; LANK = [43,44,45]; LFOT = [46,47,48];
    RHIP = [49,50,51]; RKNE = [52,53,54]; RANK = [55,56,57]; RFOT = [58,59,60];
    SHO  = [61,62,63]; LTIP = [64,65,66]; LTHM = [67,68,69]; RTIP = [70,71,72]; RTHM = [73,74,75];
    
    seq2 = [];
    a = 1;
    
    if extractMethod == 1 
        % just keep sequence as-is
        seq2 = seq;
    elseif extractMethod == 10
        seq2(:,a:a+2) = seq(:,RTHM); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,SHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
    elseif extractMethod == 11
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,SPIN); a=a+3;
        seq2(:,a:a+2) = seq(:,LTHM); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
    elseif extractMethod == 12
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
    elseif extractMethod == 13
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 14
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RANK); a=a+3;
    elseif extractMethod == 15
        seq2(:,a:a+2) = seq(:,SHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RTHM); a=a+3;
        seq2(:,a:a+2) = seq(:,HIP); a=a+3;
    elseif extractMethod == 16
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 17
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,HIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RTIP) - seq(:,HIP); a=a+3;
    elseif extractMethod == 18
        seq2(:,a:a+2) = seq(:,RTIP) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RTHM) - seq(:,RHND); a=a+3;
    elseif extractMethod == 19
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 20
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
    elseif extractMethod == 21
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 22
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,LTIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LANK); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
    elseif extractMethod == 23
        seq2(:,a:a+2) = seq(:,LTIP) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 24
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,SPIN); a=a+3;
        seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
    elseif extractMethod == 25
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,SPIN); a=a+3;
        seq2(:,a:a+2) = seq(:,SHO); a=a+3; 
        seq2(:,a:a+2) = seq(:,RTIP); a=a+3;
    elseif extractMethod == 26
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 27
        seq2(:,a:a+2) = seq(:,SPIN); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,LANK); a=a+3;
    elseif extractMethod == 28
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RANK); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE); a=a+3;   
    elseif extractMethod == 29
        seq2(:,a:a+2) = seq(:,LANK) - seq(:,LKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,LKNE); a=a+3;
    elseif extractMethod == 30
        seq2(:,a:a+2) = seq(:,RANK); a=a+3;
        seq2(:,a:a+2) = seq(:,SPIN); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
    elseif extractMethod == 31
        seq2(:,a:a+2) = seq(:,SHO); a=a+3; 
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,RTHM); a=a+3;
        seq2(:,a:a+2) = seq(:,RTIP); a=a+3;
    elseif extractMethod == 32
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 33
        seq2(:,a:a+2) = seq(:,RTIP) - seq(:,HIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,HIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LTIP) - seq(:,HIP); a=a+3;
    elseif extractMethod == 34
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 35
        seq2(:,a:a+2) = seq(:,LTHM) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
    elseif extractMethod == 36
        seq2(:,a:a+2) = seq(:,SHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,RTHM); a=a+3;
        seq2(:,a:a+2) = seq(:,RTIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,SPIN); a=a+3;
    elseif extractMethod == 37
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 38
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 39
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,LFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,LTIP) - seq(:,LFOT); a=a+3;
    elseif extractMethod == 40
        seq2(:,a:a+2) = seq(:,LTIP) - seq(:,LANK); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LANK); a=a+3;
        seq2(:,a:a+2) = seq(:,RANK) - seq(:,LANK); a=a+3;
    elseif extractMethod == 41
        seq2(:,a:a+2) = seq(:,SHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
    elseif extractMethod == 42
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
        seq2(:,a:a+2) = seq(:,SHO); a=a+3;
        seq2(:,a:a+2) = seq(:,HIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
    elseif extractMethod == 43
        seq2(:,a:a+2) = seq(:,RANK) - seq(:,LANK); a=a+3;
        seq2(:,a:a+2) = seq(:,LTIP) - seq(:,LANK); a=a+3;
    elseif extractMethod == 44
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,HIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,HIP); a=a+3;
    elseif extractMethod == 45
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RTHM); a=a+3;
        seq2(:,a:a+2) = seq(:,SPIN); a=a+3;
        seq2(:,a:a+2) = seq(:,SHO); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
    elseif extractMethod == 46
        seq2(:,a:a+2) = seq(:,LTIP) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 47
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,HIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,HIP); a=a+3;
    elseif extractMethod == 48
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RTIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,SHO); a=a+3;
        seq2(:,a:a+2) = seq(:,SPIN); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RTHM); a=a+3;
        seq2(:,a:a+2) = seq(:,HIP); a=a+3;
    elseif extractMethod == 49
        seq2(:,a:a+2) = seq(:,RTIP) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 50
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 51
        seq2(:,a:a+2) = seq(:,RTHM) - seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RTIP) - seq(:,RHND); a=a+3;
    elseif extractMethod == 52
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RTIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RTHM); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,SPIN); a=a+3;
        seq2(:,a:a+2) = seq(:,LHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,SHO); a=a+3;
        seq2(:,a:a+2) = seq(:,HIP); a=a+3;
    elseif extractMethod == 53
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,HIP); a=a+3;
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,HIP); a=a+3;
    elseif extractMethod == 54
        seq2(:,a:a+2) = seq(:,LTIP) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RTIP) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 55
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RTIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RTHM); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,SPIN); a=a+3;
        seq2(:,a:a+2) = seq(:,HIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
    elseif extractMethod == 56
        seq2(:,a:a+2) = seq(:,RTIP) - seq(:,HIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,HIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,HIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,HIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,HIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,HIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,HIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,HIP); a=a+3;
    elseif extractMethod == 57
        seq2(:,a:a+2) = seq(:,RTIP) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 58
        seq2(:,a:a+2) = seq(:,LTIP) - seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LTHM) - seq(:,LHND); a=a+3;
    elseif extractMethod == 59
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RELB); a=a+3;
    elseif extractMethod == 60
        seq2(:,a:a+2) = seq(:,RTIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
        seq2(:,a:a+2) = seq(:,RTHM); a=a+3;
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
        seq2(:,a:a+2) = seq(:,LTHM); a=a+3;
        seq2(:,a:a+2) = seq(:,LTIP); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,SPIN); a=a+3;
        seq2(:,a:a+2) = seq(:,LHIP); a=a+3;
        seq2(:,a:a+2) = seq(:,HIP); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;

    elseif extractMethod == 1001
        seq2(:,a:a+2) = seq(:,HIP); a=a+3;
    elseif extractMethod == 1002
        seq2(:,a:a+2) = seq(:,SPIN); a=a+3;
    elseif extractMethod == 1003
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
    elseif extractMethod == 1004
        seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
    elseif extractMethod == 1005
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
    elseif extractMethod == 1006
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
    elseif extractMethod == 1007
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
    elseif extractMethod == 1008
        seq2(:,a:a+2) = seq(:,LHND); a=a+3;
    elseif extractMethod == 1009
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
    elseif extractMethod == 1010
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
    elseif extractMethod == 1011
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
    elseif extractMethod == 1012
        seq2(:,a:a+2) = seq(:,RHND); a=a+3;
    elseif extractMethod == 1013
        seq2(:,a:a+2) = seq(:,LHIP); a=a+3;
    elseif extractMethod == 1014
        seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
    elseif extractMethod == 1015
        seq2(:,a:a+2) = seq(:,LANK); a=a+3;
    elseif extractMethod == 1016
        seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
    elseif extractMethod == 1017
        seq2(:,a:a+2) = seq(:,RHIP); a=a+3;
    elseif extractMethod == 1018
        seq2(:,a:a+2) = seq(:,RKNE); a=a+3;
    elseif extractMethod == 1019
        seq2(:,a:a+2) = seq(:,RANK); a=a+3;
    elseif extractMethod == 1020
        seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
    elseif extractMethod == 1021
        seq2(:,a:a+2) = seq(:,SHO); a=a+3;
    elseif extractMethod == 1022
        seq2(:,a:a+2) = seq(:,LTIP); a=a+3;
    elseif extractMethod == 1023
        seq2(:,a:a+2) = seq(:,LTHM); a=a+3;
    elseif extractMethod == 1024
        seq2(:,a:a+2) = seq(:,RTIP); a=a+3;
    elseif extractMethod == 1025
        seq2(:,a:a+2) = seq(:,RTHM); a=a+3;
    elseif extractMethod == 1026
        seq2(:,a:a+2) = seq(:,RTIP) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1027
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1028
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1029
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1030
        seq2(:,a:a+2) = seq(:,LTIP) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1031
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1032
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1033
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1034
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1035
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1036
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1037
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1038
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1039
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1040
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1041
        seq2(:,a:a+2) = seq(:,RTIP) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1042
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1043
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1044
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1045
        seq2(:,a:a+2) = seq(:,LTIP) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1046
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1047
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1048
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1049
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1050
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1051
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1052
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1053
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1054
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1055
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RANK); a=a+3;
    elseif extractMethod == 1056
        seq2(:,a:a+2) = seq(:,RANK) - seq(:,RKNE); a=a+3;
    elseif extractMethod == 1057
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3;
    elseif extractMethod == 1058
        seq2(:,a:a+2) = seq(:,RHIP) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1059
        seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LANK); a=a+3;
    elseif extractMethod == 1060
        seq2(:,a:a+2) = seq(:,LANK) - seq(:,LKNE); a=a+3;
    elseif extractMethod == 1061
        seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LHIP); a=a+3;
    elseif extractMethod == 1062
        seq2(:,a:a+2) = seq(:,LHIP) - seq(:,HIP); a=a+3;
    elseif extractMethod == 1063
        seq2(:,a:a+2) = seq(:,RTIP) - seq(:,RHND); a=a+3;
    elseif extractMethod == 1064
        seq2(:,a:a+2) = seq(:,RTHM) - seq(:,RHND); a=a+3;
    elseif extractMethod == 1065
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1066
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1067
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1068
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,SHO); a=a+3;
    elseif extractMethod == 1069
        seq2(:,a:a+2) = seq(:,LTIP) - seq(:,LHND); a=a+3;
    elseif extractMethod == 1070
        seq2(:,a:a+2) = seq(:,LTHM) - seq(:,LHND); a=a+3;
    elseif extractMethod == 1071
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1072
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1073
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1074
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,SHO); a=a+3;
    elseif extractMethod == 1075
        seq2(:,a:a+2) = seq(:,HIP) - seq(:,SPIN); a=a+3;
    elseif extractMethod == 1076
        seq2(:,a:a+2) = seq(:,SPIN) - seq(:,SHO); a=a+3;
    elseif extractMethod == 1077
        seq2(:,a:a+2) = seq(:,SHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1078
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1079
        seq2(:,a:a+2) = seq(:,RTIP) - seq(:,LTIP); a=a+3;
    elseif extractMethod == 1080
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
    elseif extractMethod == 1081
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1082
        seq2(:,a:a+2) = seq(:,RKNE) - seq(:,LKNE); a=a+3;
    elseif extractMethod == 1083
        seq2(:,a:a+2) = seq(:,RANK) - seq(:,LANK); a=a+3;
    elseif extractMethod == 1084
        seq2(:,a:a+2) = seq(:,RFOT) - seq(:,LFOT); a=a+3;
    elseif extractMethod == 1085
        seq2(:,a:a+2) = seq(:,RHND) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1086
        seq2(:,a:a+2) = seq(:,LHND) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1087
        seq2(:,a:a+2) = seq(:,RTIP) - seq(:,RANK); a=a+3;
    elseif extractMethod == 1088
        seq2(:,a:a+2) = seq(:,RTIP) - seq(:,RFOT); a=a+3;
    elseif extractMethod == 1089
        seq2(:,a:a+2) = seq(:,LTIP) - seq(:,LANK); a=a+3;
    elseif extractMethod == 1090
        seq2(:,a:a+2) = seq(:,LTIP) - seq(:,LFOT); a=a+3;
    end

    
end