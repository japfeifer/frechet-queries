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
    end

end