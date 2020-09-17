
function seq = LMNormalizeSeq(seq,seqNormalCurr)

    sz = size(seqNormalCurr,2);

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

    if sz >= 2
        if seqNormalCurr(1,2) == 1
            % (2) for each frame, normalize the limb lengths, but keep the same limb
            % vectors. Start at the wrist and radiate out from there.
            for i=1:size(seq,1)
                % left hand
                seq(i,LHND) = LMNormLimb(LWST,LHND,0.032,seq(i,:)); % LWST to LHND thumb base
                seq(i,LTPR) = LMNormLimb(LHND,LTPR,0.044,seq(i,:)); % LHND to LTPR
                seq(i,LTDI) = LMNormLimb(LTPR,LTDI,0.044,seq(i,:)); % LTPR to LTDI
                seq(i,LTEF) = LMNormLimb(LTDI,LTEF,0.020,seq(i,:)); % LTDI to LTEF thumb tip
                seq(i,LPAL) = LMNormLimb(LWST,LPAL,0.067,seq(i,:)); % LWST to LPAL palm (4 fingers connect to here)
                seq(i,LIPR) = LMNormLimb(LPAL,LIPR,0.031,seq(i,:)); % LPAL to LIPR index finger base
                seq(i,LIME) = LMNormLimb(LIPR,LIME,0.036,seq(i,:)); % LIPR to LIME
                seq(i,LIDI) = LMNormLimb(LIME,LIDI,0.020,seq(i,:)); % LIME to LIDI
                seq(i,LIEF) = LMNormLimb(LIDI,LIEF,0.014,seq(i,:)); % LIDI to LIEF index finger tip
                seq(i,LMPR) = LMNormLimb(LPAL,LMPR,0.023,seq(i,:)); % LPAL to LMPR middle finger base
                seq(i,LMME) = LMNormLimb(LMPR,LMME,0.041,seq(i,:)); % LMPR to LMME
                seq(i,LMDI) = LMNormLimb(LMME,LMDI,0.024,seq(i,:)); % LMME to LMDI
                seq(i,LMEF) = LMNormLimb(LMDI,LMEF,0.016,seq(i,:)); % LMDI to LMEF middle finger tip
                seq(i,LRPR) = LMNormLimb(LPAL,LRPR,0.024,seq(i,:)); % LPAL to LRPR ring finger base
                seq(i,LRME) = LMNormLimb(LRPR,LRME,0.038,seq(i,:)); % LRPR to LRME
                seq(i,LRDI) = LMNormLimb(LRME,LRDI,0.023,seq(i,:)); % LRME to LRDI
                seq(i,LREF) = LMNormLimb(LRDI,LREF,0.016,seq(i,:)); % LRDI to LREF
                seq(i,LPPR) = LMNormLimb(LPAL,LPPR,0.035,seq(i,:)); % LPAL to LPPR pinky finger base
                seq(i,LPME) = LMNormLimb(LPPR,LPME,0.030,seq(i,:)); % LPPR to LPME
                seq(i,LPDI) = LMNormLimb(LPME,LPDI,0.017,seq(i,:)); % LPME to LPDI
                seq(i,LPEF) = LMNormLimb(LPDI,LPEF,0.015,seq(i,:)); % LPDI to LPEF
                seq(i,LELB) = LMNormLimb(LWST,LELB,0.239,seq(i,:)); % LWST to LELB elbow
                seq(i,LAFR) = LMNormLimb(LWST,LAFR,0.023,seq(i,:)); % LWST to LAFR close to wrist
                seq(i,LAFU) = LMNormLimb(LWST,LAFU,0.023,seq(i,:)); % LWST to LAFU close to wrist
                seq(i,LABL) = LMNormLimb(LAFR,LABL,0.227,seq(i,:)); % LAFR to LABL close to elbow
                seq(i,LABM) = LMNormLimb(LAFU,LABM,0.227,seq(i,:)); % LAFU to LABM close to elbow

                % right hand
                seq(i,RHND) = LMNormLimb(RWST,RHND,0.032,seq(i,:)); % RWST to RHND thumb base
                seq(i,RTPR) = LMNormLimb(RHND,RTPR,0.044,seq(i,:)); % RHND to RTPR
                seq(i,RTDI) = LMNormLimb(RTPR,RTDI,0.044,seq(i,:)); % RTPR to RTDI
                seq(i,RTEF) = LMNormLimb(RTDI,RTEF,0.020,seq(i,:)); % RTDI to RTEF thumb tip
                seq(i,RPAL) = LMNormLimb(RWST,RPAL,0.067,seq(i,:)); % RWST to RPAL palm (4 fingers connect to here)
                seq(i,RIPR) = LMNormLimb(RPAL,RIPR,0.031,seq(i,:)); % RPAL to RIPR index finger base
                seq(i,RIME) = LMNormLimb(RIPR,RIME,0.036,seq(i,:)); % RIPR to RIME
                seq(i,RIDI) = LMNormLimb(RIME,RIDI,0.020,seq(i,:)); % RIME to RIDI
                seq(i,RIEF) = LMNormLimb(RIDI,RIEF,0.014,seq(i,:)); % RIDI to RIEF index finger tip
                seq(i,RMPR) = LMNormLimb(RPAL,RMPR,0.023,seq(i,:)); % RPAL to RMPR middle finger base
                seq(i,RMME) = LMNormLimb(RMPR,RMME,0.041,seq(i,:)); % RMPR to RMME
                seq(i,RMDI) = LMNormLimb(RMME,RMDI,0.024,seq(i,:)); % RMME to RMDI
                seq(i,RMEF) = LMNormLimb(RMDI,RMEF,0.016,seq(i,:)); % RMDI to RMEF middle finger tip
                seq(i,RRPR) = LMNormLimb(RPAL,RRPR,0.024,seq(i,:)); % RPAL to RRPR ring finger base
                seq(i,RRME) = LMNormLimb(RRPR,RRME,0.038,seq(i,:)); % RRPR to RRME
                seq(i,RRDI) = LMNormLimb(RRME,RRDI,0.023,seq(i,:)); % RRME to RRDI
                seq(i,RREF) = LMNormLimb(RRDI,RREF,0.016,seq(i,:)); % RRDI to RREF
                seq(i,RPPR) = LMNormLimb(RPAL,RPPR,0.035,seq(i,:)); % RPAL to RPPR pinky finger base
                seq(i,RPME) = LMNormLimb(RPPR,RPME,0.030,seq(i,:)); % RPPR to RPME
                seq(i,RPDI) = LMNormLimb(RPME,RPDI,0.017,seq(i,:)); % RPME to RPDI
                seq(i,RPEF) = LMNormLimb(RPDI,RPEF,0.015,seq(i,:)); % RPDI to RPEF
                seq(i,RELB) = LMNormLimb(RWST,RELB,0.239,seq(i,:)); % RWST to RELB elbow
                seq(i,RAFR) = LMNormLimb(RWST,RAFR,0.023,seq(i,:)); % RWST to RAFR close to wrist
                seq(i,RAFU) = LMNormLimb(RWST,RAFU,0.023,seq(i,:)); % RWST to RAFU close to wrist
                seq(i,RABL) = LMNormLimb(RAFR,RABL,0.227,seq(i,:)); % RAFR to RABL close to elbow
                seq(i,RABM) = LMNormLimb(RAFU,RABM,0.227,seq(i,:)); % RAFU to RABM close to elbow
            end
        end
    end
    
    if sz >=3
        if seqNormalCurr(1,3) == 1
            % (2a) calc first frame rotation of RWST & RELB to face camera (rotate about x-axis),
            % then apply rotation to all frames

            % left-hand
            % get degrees to rotate
            p1 = [seq(1,LELB(2)) seq(1,LELB(3)) 0];
            p2 = [seq(1,LWST(2)) seq(1,LWST(3)) 0];
            p3 = [seq(1,LELB(2)) seq(1,LWST(3)) 0];
            deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
            if seq(1,LWST(2)) < seq(1,LELB(2)) % subject neck lower than torso
                deg = 180 - deg;
            end

            % determine if LWST or LELB is closer to camera, look at z axis
            if seq(1,LWST(3)) < seq(1,LELB(3)) % LWST is closer
                % rotate counter-clockwise about x axis (when viewing from camera-right side)
                rotMat = [1  0          0          ; ...
                          0  cosd(deg)  sind(deg) ; ...
                          0  -sind(deg)  cosd(deg)] ;
            else % LELB is closer
                % rotate clockwise about x axis (when viewing from camera-right side)
                rotMat = [1  0          0          ; ...
                          0  cosd(deg)  -sind(deg) ; ...
                          0  sind(deg)  cosd(deg)] ;
            end
            for i = 1:27 % for each left-hand traj in the seq
                seq(:,i*3-2:i*3) = seq(:,i*3-2:i*3) * rotMat; % matrix multiplication    
            end

            % ensure rotate worked
            if round(seq(1,LWST(3)),3) ~= round(seq(1,LELB(3)),3)
               error('Issue with left-hand rotate about x-axis'); 
            end

            % right-hand
            % get degrees to rotate
            p1 = [seq(1,RELB(2)) seq(1,RELB(3)) 0];
            p2 = [seq(1,RWST(2)) seq(1,RWST(3)) 0];
            p3 = [seq(1,RELB(2)) seq(1,RWST(3)) 0];
            deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
            if seq(1,RWST(2)) < seq(1,RELB(2)) % subject neck lower than torso
                deg = 180 - deg;
            end

            % determine if RWST or RELB is closer to camera, look at z axis
            if seq(1,RWST(3)) < seq(1,RELB(3)) % RWST is closer
                % rotate counter-clockwise about x axis (when viewing from camera-right side)
                rotMat = [1  0          0          ; ...
                          0  cosd(deg)  sind(deg) ; ...
                          0  -sind(deg)  cosd(deg)] ;
            else % RELB is closer
                % rotate clockwise about x axis (when viewing from camera-right side)
                rotMat = [1  0          0          ; ...
                          0  cosd(deg)  -sind(deg) ; ...
                          0  sind(deg)  cosd(deg)] ;
            end
            for i = 28:54 % for each right-hand traj in the seq
                seq(:,i*3-2:i*3) = seq(:,i*3-2:i*3) * rotMat; % matrix multiplication    
            end

            % ensure rotate worked
            if round(seq(1,RWST(3)),3) ~= round(seq(1,RELB(3)),3)
               error('Issue with right-hand rotate about x-axis'); 
            end

            % (2b) calc first frame rotation of RWST & RELB such that RELB is directly 
            % beneath RWST (rotate about z-axis), then apply rotation to all frames

            % left-hand
            % get degrees to rotate
            p1 = [seq(1,LELB(1)) seq(1,LELB(2)) 0];
            p2 = [seq(1,LWST(1)) seq(1,LWST(2)) 0];
            p3 = [seq(1,LWST(1)) seq(1,LELB(2)) 0];
            deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
            if seq(1,LWST(2)) < seq(1,LELB(2)) % subject neck lower than torso
                deg = 180 - deg;
            end

            % determine if LWST is left or right from LELB, look at x axis
            if seq(1,LWST(1)) < seq(1,LELB(1)) % LWST is right from LELB
                % rotate counter-clockwise about z axis (when viewing from camera)
                rotMat = [cosd(deg)  -sind(deg)  0 ; ...
                          sind(deg)  cosd(deg)   0 ; ...
                          0          0           1 ] ;
            else % LWST is left from LELB
                % rotate clockwise about z axis (when viewing from camera)  
                rotMat = [cosd(deg)  sind(deg)  0 ; ...
                          -sind(deg)  cosd(deg)   0 ; ...
                          0          0           1 ] ;
            end
            for i = 1:27 % for each left-hand traj in the seq
                seq(:,i*3-2:i*3) = seq(:,i*3-2:i*3) * rotMat; % matrix multiplication    
            end

            % ensure rotate worked
            if round(seq(1,LWST(1)),3) ~= round(seq(1,LELB(1)),3)
               error('Issue with left-hand rotate about z-axis'); 
            end

            % right-hand
            % get degrees to rotate
            p1 = [seq(1,RELB(1)) seq(1,RELB(2)) 0];
            p2 = [seq(1,RWST(1)) seq(1,RWST(2)) 0];
            p3 = [seq(1,RWST(1)) seq(1,RELB(2)) 0];
            deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
            if seq(1,RWST(2)) < seq(1,RELB(2)) % subject neck lower than torso
                deg = 180 - deg;
            end

            % determine if RWST is left or right from RELB, look at x axis
            if seq(1,RWST(1)) < seq(1,RELB(1)) % RWST is right from RELB
                % rotate counter-clockwise about z axis (when viewing from camera)
                rotMat = [cosd(deg)  -sind(deg)  0 ; ...
                          sind(deg)  cosd(deg)   0 ; ...
                          0          0           1 ] ;
            else % RWST is left from RELB
                % rotate clockwise about z axis (when viewing from camera)  
                rotMat = [cosd(deg)  sind(deg)  0 ; ...
                          -sind(deg)  cosd(deg)   0 ; ...
                          0          0           1 ] ;
            end
            for i = 28:54 % for each right-hand traj in the seq
                seq(:,i*3-2:i*3) = seq(:,i*3-2:i*3) * rotMat; % matrix multiplication    
            end

            % ensure rotate worked
            if round(seq(1,RWST(1)),3) ~= round(seq(1,RELB(1)),3)
               error('Issue with right-hand rotate about z-axis'); 
            end

        end
    end
    
    if sz >=4
        if seqNormalCurr(1,4) == 1
            % (3) calc first frame rotation of RAFU & RAFR to face camera (rotate about y-axis),
            % then apply rotation to all frames.
            % (for this data, smaller z axis values are closer to camera)

            % left-hand
            % first get degrees to rotate - remove y-axis dim
            p1 = [seq(1,LAFR(1)) seq(1,LAFR(3))]; % LAFR point
            p2 = [seq(1,LAFU(1)) seq(1,LAFU(3))]; % LAFU point
            p3 = [seq(1,LWST(1)) seq(1,LWST(3))]; % LWST point
            p5 = Cplsp([seq(1,LAFR(1)) seq(1,LAFR(3))],[seq(1,LAFU(1)) seq(1,LAFU(3))],[seq(1,LWST(1)) seq(1,LWST(3))]); % closest point on line segment LAFR-LAFU to origin (RWST)
            if p5(2) < p3(2) % subject facing camera
                p4 = [seq(1,LWST(1)) min(seq(1,LAFR(3)),seq(1,LAFU(3)))]; % furthest point on z-axis perpendicular to LWST
            else % back of subject facing camera
                p4 = [seq(1,LWST(1)) max(seq(1,LAFR(3)),seq(1,LAFU(3)))]; % furthest point on z-axis perpendicular to LWST
            end
            p6 = LineIntersect2D(p1,p2,p3,p4); % find where line p1-p2 intersects line p3-p4
            deg = AngDeg3DVec([p5 0] , [p3 0] , [p6 0]); % get degree angle from p5 to p3 to p6
            if seq(1,LAFR(1)) < seq(1,LAFU(1)) % back of subject facing camera
                deg = 180 - deg;
            end

            % determine if LAFR or LAFU is closer to camera, look at z axis
            if seq(1,LAFU(3)) < seq(1,LAFR(3)) % left shoulder is closer
                % rotate counter-clockwise about y axis (when viewing top-down from camera)
                rotMat = [cosd(deg)  0  -sind(deg); ...
                          0          1  0         ; ...
                          sind(deg)  0  cosd(deg)];
            else % right shouder is closer
                % rotate clockwise about y axis (when viewing top-down from camera)
                rotMat = [cosd(deg)  0  sind(deg) ; ...
                         0           1  0         ; ...
                         -sind(deg)  0  cosd(deg)];
            end
            for i = 1:27 % for each traj in the seq
                seq(:,i*3-2:i*3) = seq(:,i*3-2:i*3) * rotMat; % matrix multiplication    
            end

    %         % ensure rotate worked
    %         if round(seq(1,LAFR(3)),3) ~= round(seq(1,LAFU(3)),3)
    %            error('Issue with left-hand rotate about y-axis'); 
    %         end

            % right-hand
            % first get degrees to rotate - remove y-axis dim
            p1 = [seq(1,RAFU(1)) seq(1,RAFU(3))]; % RAFU point
            p2 = [seq(1,RAFR(1)) seq(1,RAFR(3))]; % RAFR point
            p3 = [seq(1,RWST(1)) seq(1,RWST(3))]; % RWST point
            p5 = Cplsp([seq(1,RAFU(1)) seq(1,RAFU(3))],[seq(1,RAFR(1)) seq(1,RAFR(3))],[seq(1,RWST(1)) seq(1,RWST(3))]); % closest point on line segment RAFU-RAFR to origin (RWST)
            if p5(2) < p3(2) % subject facing camera
                p4 = [seq(1,RWST(1)) min(seq(1,RAFU(3)),seq(1,RAFR(3)))]; % furthest point on z-axis perpendicular to RWST
            else % back of subject facing camera
                p4 = [seq(1,RWST(1)) max(seq(1,RAFU(3)),seq(1,RAFR(3)))]; % furthest point on z-axis perpendicular to RWST
            end
            p6 = LineIntersect2D(p1,p2,p3,p4); % find where line p1-p2 intersects line p3-p4
            deg = AngDeg3DVec([p5 0] , [p3 0] , [p6 0]); % get degree angle from p5 to p3 to p6
            if seq(1,RAFU(1)) < seq(1,RAFR(1)) % back of subject facing camera
                deg = 180 - deg;
            end

            % determine if RAFU or RAFR is closer to camera, look at z axis
            if seq(1,RAFR(3)) < seq(1,RAFU(3)) % left shoulder is closer
                % rotate counter-clockwise about y axis (when viewing top-down from camera)
                rotMat = [cosd(deg)  0  -sind(deg); ...
                          0          1  0         ; ...
                          sind(deg)  0  cosd(deg)];
            else % right shouder is closer
                % rotate clockwise about y axis (when viewing top-down from camera)
                rotMat = [cosd(deg)  0  sind(deg) ; ...
                         0           1  0         ; ...
                         -sind(deg)  0  cosd(deg)];
            end
            for i = 28:54 % for each right-hand traj in the seq
                seq(:,i*3-2:i*3) = seq(:,i*3-2:i*3) * rotMat; % matrix multiplication    
            end

    %         % ensure rotate worked
    %         if round(seq(1,RAFU(3)),3) ~= round(seq(1,RAFR(3)),3)
    %            disp(['Num1: ',num2str(round(seq(1,RAFU(3)),3)),'  Num2: ',num2str(round(seq(1,RAFR(3)),3))]);
    %            error('Issue with right-hand rotate about y-axis'); 
    %         end
        end
    end
        
    if sz >= 1
        if seqNormalCurr(1,1) == 1
            % (1) for each frame, translate all joints so that right 
            % WST first frame is at origin - coordinate (0,0,0), and left WST
            % first frame is at coordinate (-0.25,0,0)
            a = [(seq(1,LWST(1))*-1) - 0.25 seq(1,LWST(2))*-1 seq(1,LWST(3))*-1];
            b = [seq(1,RWST(1))*-1 seq(1,RWST(2))*-1 seq(1,RWST(3))*-1];
            a = [a a a a a a a a a a a a a a a a a a a a a a a a a a a];
            b = [b b b b b b b b b b b b b b b b b b b b b b b b b b b];
            seq(:,1:81) = seq(:,1:81) + a;
            seq(:,82:162) = seq(:,82:162) + b;
        end 
    end
    
    if sz >= 5
        if seqNormalCurr(1,5) == 1
            % (5) put the "at rest" frame at the beginning and end of the seq
            seq = LMAtRest(seq);
        end
    end
 
    if sz >= 6
        if seqNormalCurr(1,6) == 1
            % (2a) calc first frame rotation of RWST & RELB to face camera (rotate about x-axis),
            % then apply rotation to all frames

            % left-hand
            % get degrees to rotate
            for i = 1:size(seq,1)
                p1 = [seq(i,LELB(2)) seq(i,LELB(3)) 0];
                p2 = [seq(i,LMPR(2)) seq(i,LMPR(3)) 0];
                p3 = [seq(i,LELB(2)) seq(i,LMPR(3)) 0];
                deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
                if seq(i,LMPR(2)) < seq(i,LELB(2)) % subject neck lower than torso
                    deg = 180 - deg;
                end

                % determine if LMPR or LELB is closer to camera, look at z axis
                if seq(i,LMPR(3)) < seq(i,LELB(3)) % LMPR is closer
                    % rotate counter-clockwise about x axis (when viewing from camera-right side)
                    rotMat = [1  0          0          ; ...
                              0  cosd(deg)  sind(deg) ; ...
                              0  -sind(deg)  cosd(deg)] ;
                else % LELB is closer
                    % rotate clockwise about x axis (when viewing from camera-right side)
                    rotMat = [1  0          0          ; ...
                              0  cosd(deg)  -sind(deg) ; ...
                              0  sind(deg)  cosd(deg)] ;
                end
                for j = 1:27 % for each left-hand traj in the seq
                    seq(i,j*3-2:j*3) = seq(i,j*3-2:j*3) * rotMat; % matrix multiplication    
                end

                % ensure rotate worked
                if round(seq(i,LMPR(3)),3) ~= round(seq(i,LELB(3)),3)
                   error('Issue with left-hand rotate about x-axis'); 
                end

                % right-hand
                % get degrees to rotate
                p1 = [seq(i,RELB(2)) seq(i,RELB(3)) 0];
                p2 = [seq(i,RMPR(2)) seq(i,RMPR(3)) 0];
                p3 = [seq(i,RELB(2)) seq(i,RMPR(3)) 0];
                deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
                if seq(i,RMPR(2)) < seq(i,RELB(2)) % subject neck lower than torso
                    deg = 180 - deg;
                end

                % determine if RMPR or RELB is closer to camera, look at z axis
                if seq(i,RMPR(3)) < seq(i,RELB(3)) % RMPR is closer
                    % rotate counter-clockwise about x axis (when viewing from camera-right side)
                    rotMat = [1  0          0          ; ...
                              0  cosd(deg)  sind(deg) ; ...
                              0  -sind(deg)  cosd(deg)] ;
                else % RELB is closer
                    % rotate clockwise about x axis (when viewing from camera-right side)
                    rotMat = [1  0          0          ; ...
                              0  cosd(deg)  -sind(deg) ; ...
                              0  sind(deg)  cosd(deg)] ;
                end
                for j = 28:54 % for each right-hand traj in the seq
                    seq(i,j*3-2:j*3) = seq(i,j*3-2:j*3) * rotMat; % matrix multiplication    
                end

                % ensure rotate worked
                if round(seq(i,RMPR(3)),3) ~= round(seq(i,RELB(3)),3)
                   error('Issue with right-hand rotate about x-axis'); 
                end

                % (2b) calc first frame rotation of RMPR & RELB such that RELB is directly 
                % beneath RMPR (rotate about z-axis), then apply rotation to all frames

                % left-hand
                % get degrees to rotate
                p1 = [seq(i,LELB(1)) seq(i,LELB(2)) 0];
                p2 = [seq(i,LMPR(1)) seq(i,LMPR(2)) 0];
                p3 = [seq(i,LMPR(1)) seq(i,LELB(2)) 0];
                deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
                if seq(i,LMPR(2)) < seq(i,LELB(2)) % subject neck lower than torso
                    deg = 180 - deg;
                end

                % determine if LMPR is left or right from LELB, look at x axis
                if seq(i,LMPR(1)) < seq(i,LELB(1)) % LMPR is right from LELB
                    % rotate counter-clockwise about z axis (when viewing from camera)
                    rotMat = [cosd(deg)  -sind(deg)  0 ; ...
                              sind(deg)  cosd(deg)   0 ; ...
                              0          0           1 ] ;
                else % LMPR is left from LELB
                    % rotate clockwise about z axis (when viewing from camera)  
                    rotMat = [cosd(deg)  sind(deg)  0 ; ...
                              -sind(deg)  cosd(deg)   0 ; ...
                              0          0           1 ] ;
                end
                for j = 1:27 % for each left-hand traj in the seq
                    seq(i,j*3-2:j*3) = seq(i,j*3-2:j*3) * rotMat; % matrix multiplication    
                end

                % ensure rotate worked
                if round(seq(i,LMPR(1)),3) ~= round(seq(i,LELB(1)),3)
                   error('Issue with left-hand rotate about z-axis'); 
                end

                % right-hand
                % get degrees to rotate
                p1 = [seq(i,RELB(1)) seq(i,RELB(2)) 0];
                p2 = [seq(i,RMPR(1)) seq(i,RMPR(2)) 0];
                p3 = [seq(i,RMPR(1)) seq(i,RELB(2)) 0];
                deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
                if seq(i,RMPR(2)) < seq(i,RELB(2)) % subject neck lower than torso
                    deg = 180 - deg;
                end

                % determine if RMPR is left or right from RELB, look at x axis
                if seq(i,RMPR(1)) < seq(i,RELB(1)) % RMPR is right from RELB
                    % rotate counter-clockwise about z axis (when viewing from camera)
                    rotMat = [cosd(deg)  -sind(deg)  0 ; ...
                              sind(deg)  cosd(deg)   0 ; ...
                              0          0           1 ] ;
                else % RMPR is left from RELB
                    % rotate clockwise about z axis (when viewing from camera)  
                    rotMat = [cosd(deg)  sind(deg)  0 ; ...
                              -sind(deg)  cosd(deg)   0 ; ...
                              0          0           1 ] ;
                end
                for j = 28:54 % for each right-hand traj in the seq
                    seq(i,j*3-2:j*3) = seq(i,j*3-2:j*3) * rotMat; % matrix multiplication    
                end

                % ensure rotate worked
                if round(seq(i,RMPR(1)),3) ~= round(seq(i,RELB(1)),3)
                   error('Issue with right-hand rotate about z-axis'); 
                end

                % (3) calc first frame rotation of RAFU & RAFR to face camera (rotate about y-axis),
                % then apply rotation to all frames.
                % (for this data, smaller z axis values are closer to camera)

                % left-hand
                % first get degrees to rotate - remove y-axis dim
                p1 = [seq(i,LIPR(1)) seq(i,LIPR(3))]; % LIPR point
                p2 = [seq(i,LRPR(1)) seq(i,LRPR(3))]; % LRPR point
                p3 = [seq(i,LMPR(1)) seq(i,LMPR(3))]; % LMPR point
                p5 = Cplsp([seq(i,LIPR(1)) seq(i,LIPR(3))],[seq(i,LRPR(1)) seq(i,LRPR(3))],[seq(i,LMPR(1)) seq(i,LMPR(3))]); % closest point on line segment LIPR-LRPR to origin (RMPR)
                if p5(2) < p3(2) % subject facing camera
                    p4 = [seq(i,LMPR(1)) min(seq(i,LIPR(3)),seq(i,LRPR(3)))]; % furthest point on z-axis perpendicular to LMPR
                else % back of subject facing camera
                    p4 = [seq(i,LMPR(1)) max(seq(i,LIPR(3)),seq(i,LRPR(3)))]; % furthest point on z-axis perpendicular to LMPR
                end
                p6 = LineIntersect2D(p1,p2,p3,p4); % find where line p1-p2 intersects line p3-p4
                deg = AngDeg3DVec([p5 0] , [p3 0] , [p6 0]); % get degree angle from p5 to p3 to p6
                if seq(i,LIPR(1)) < seq(i,LRPR(1)) % back of subject facing camera
                    deg = 180 - deg;
                end

                % determine if LIPR or LRPR is closer to camera, look at z axis
                if seq(i,LRPR(3)) < seq(i,LIPR(3)) % left shoulder is closer
                    % rotate counter-clockwise about y axis (when viewing top-down from camera)
                    rotMat = [cosd(deg)  0  -sind(deg); ...
                              0          1  0         ; ...
                              sind(deg)  0  cosd(deg)];
                else % right shouder is closer
                    % rotate clockwise about y axis (when viewing top-down from camera)
                    rotMat = [cosd(deg)  0  sind(deg) ; ...
                             0           1  0         ; ...
                             -sind(deg)  0  cosd(deg)];
                end
                for j = 1:27 % for each traj in the seq
                    seq(i,j*3-2:j*3) = seq(i,j*3-2:j*3) * rotMat; % matrix multiplication    
                end

                % right-hand
                % first get degrees to rotate - remove y-axis dim
                p1 = [seq(i,RRPR(1)) seq(i,RRPR(3))]; % RRPR point
                p2 = [seq(i,RIPR(1)) seq(i,RIPR(3))]; % RIPR point
                p3 = [seq(i,RMPR(1)) seq(i,RMPR(3))]; % RMPR point
                p5 = Cplsp([seq(i,RRPR(1)) seq(i,RRPR(3))],[seq(i,RIPR(1)) seq(i,RIPR(3))],[seq(i,RMPR(1)) seq(i,RMPR(3))]); % closest point on line segment RRPR-RIPR to origin (RMPR)
                if p5(2) < p3(2) % subject facing camera
                    p4 = [seq(i,RMPR(1)) min(seq(i,RRPR(3)),seq(i,RIPR(3)))]; % furthest point on z-axis perpendicular to RMPR
                else % back of subject facing camera
                    p4 = [seq(i,RMPR(1)) max(seq(i,RRPR(3)),seq(i,RIPR(3)))]; % furthest point on z-axis perpendicular to RMPR
                end
                p6 = LineIntersect2D(p1,p2,p3,p4); % find where line p1-p2 intersects line p3-p4
                deg = AngDeg3DVec([p5 0] , [p3 0] , [p6 0]); % get degree angle from p5 to p3 to p6
                if seq(i,RRPR(1)) < seq(i,RIPR(1)) % back of subject facing camera
                    deg = 180 - deg;
                end

                % determine if RRPR or RIPR is closer to camera, look at z axis
                if seq(i,RIPR(3)) < seq(i,RRPR(3)) % left shoulder is closer
                    % rotate counter-clockwise about y axis (when viewing top-down from camera)
                    rotMat = [cosd(deg)  0  -sind(deg); ...
                              0          1  0         ; ...
                              sind(deg)  0  cosd(deg)];
                else % right shouder is closer
                    % rotate clockwise about y axis (when viewing top-down from camera)
                    rotMat = [cosd(deg)  0  sind(deg) ; ...
                             0           1  0         ; ...
                             -sind(deg)  0  cosd(deg)];
                end
                for j = 28:54 % for each right-hand traj in the seq
                    seq(i,j*3-2:j*3) = seq(i,j*3-2:j*3) * rotMat; % matrix multiplication    
                end

            end
            
            % (1) for each frame, translate all joints so that right 
            % knuckle frame is at origin - coordinate (0,0,0), and left knuckle
            % frame is at coordinate (-0.25,0,0)
            a = [(seq(:,LMPR(1))*-1) - 0.25 seq(:,LMPR(2))*-1 seq(:,LMPR(3))*-1];
            b = [seq(:,RMPR(1))*-1 seq(:,RMPR(2))*-1 seq(:,RMPR(3))*-1];
            a = [a a a a a a a a a a a a a a a a a a a a a a a a a a a];
            b = [b b b b b b b b b b b b b b b b b b b b b b b b b b b];
            seq(:,1:81) = seq(:,1:81) + a;
            seq(:,82:162) = seq(:,82:162) + b;
            
        end
    end
    
end