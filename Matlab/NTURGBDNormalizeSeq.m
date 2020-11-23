% outstanding tasks with the nut-rgb+d dataset:
% 3) normalization - rotation, limb lengths, at rest pose


function seq = NTURGBDNormalizeSeq(seq,seqNormalCurr)

    HIP  = [1,2,3]; SPIN = [4,5,6]; NECK = [7,8,9]; HEAD = [10,11,12];
    LSHO = [13,14,15]; LELB = [16,17,18]; LWST = [19,20,21]; LHND = [22,23,24];
    RSHO = [25,26,27]; RELB = [28,29,30]; RWST = [31,32,33]; RHND = [34,35,36];
    LHIP = [37,38,39]; LKNE = [40,41,42]; LANK = [43,44,45]; LFOT = [46,47,48];
    RHIP = [49,50,51]; RKNE = [52,53,54]; RANK = [55,56,57]; RFOT = [58,59,60];
    SHO  = [61,62,63]; LTIP = [64,65,66]; LTHM = [67,68,69]; RTIP = [70,71,72]; RTHM = [73,74,75];

    if seqNormalCurr(1,5) == 1
        % (5) for each frame, normalize the limb lengths, but keep the same
        % limb vector
        
        % normalized limb distances
        HIP_SPIN = 0.29;
        SPIN_SHO = 0.216;
        SHO_NECK = 0.072;
        NECK_HEAD = 0.131;
        SHO_BSHO = 0.162;
        BSHO_ELB = 0.236;
        ELB_WST = 0.227;
        WST_HND = 0.068;
        HND_THM = 0.044;
        HND_TIP = 0.064;
        HIP_BHIP = 0.076;
        BHIP_KNE = 0.336;
        KNE_ANK = 0.355;
        ANK_FOT = 0.118;

        for i=1:size(seq,1)
            % normalize SPIN
            vec = seq(i,SPIN) - seq(i,HIP); % original vector
            uvec = vec ./ CalcPointDist(seq(i,SPIN),seq(i,HIP)); % unit normal vector
            nvec = uvec .* HIP_SPIN; % new vector
            p = seq(i,HIP) + nvec; % new point
            seq(i,SPIN) = p; % save the new point

            % normalize SHO
            vec = seq(i,SHO) - seq(i,SPIN); % original vector
            uvec = vec ./ CalcPointDist(seq(i,SHO),seq(i,SPIN)); % unit normal vector
            nvec = uvec .* SPIN_SHO; % new vector
            p = seq(i,SPIN) + nvec; % new point
            seq(i,SHO) = p; % save the new point
            
            % normalize NECK
            vec = seq(i,NECK) - seq(i,SHO); % original vector
            uvec = vec ./ CalcPointDist(seq(i,NECK),seq(i,SHO)); % unit normal vector
            nvec = uvec .* SHO_NECK; % new vector
            p = seq(i,SHO) + nvec; % new point
            seq(i,NECK) = p; % save the new point
            
            % normalize HEAD
            vec = seq(i,HEAD) - seq(i,NECK); % original vector
            uvec = vec ./ CalcPointDist(seq(i,HEAD),seq(i,NECK)); % unit normal vector
            nvec = uvec .* NECK_HEAD; % new vector
            p = seq(i,NECK) + nvec; % new point
            seq(i,HEAD) = p; % save the new point

            % normalize RSHO
            vec = seq(i,RSHO) - seq(i,SHO); % original vector
            uvec = vec ./ CalcPointDist(seq(i,RSHO),seq(i,SHO)); % unit normal vector
            nvec = uvec .* SHO_BSHO; % new vector
            p = seq(i,SHO) + nvec; % new point
            seq(i,RSHO) = p; % save the new point
            
            % normalize RELB
            vec = seq(i,RELB) - seq(i,RSHO); % original vector
            uvec = vec ./ CalcPointDist(seq(i,RELB),seq(i,RSHO)); % unit normal vector
            nvec = uvec .* BSHO_ELB; % new vector
            p = seq(i,RSHO) + nvec; % new point
            seq(i,RELB) = p; % save the new point
            
            % normalize RWST
            vec = seq(i,RWST) - seq(i,RELB); % original vector
            uvec = vec ./ CalcPointDist(seq(i,RWST),seq(i,RELB)); % unit normal vector
            nvec = uvec .* ELB_WST; % new vector
            p = seq(i,RELB) + nvec; % new point
            seq(i,RWST) = p; % save the new point
            
            % normalize RHND
            vec = seq(i,RHND) - seq(i,RWST); % original vector
            uvec = vec ./ CalcPointDist(seq(i,RHND),seq(i,RWST)); % unit normal vector
            nvec = uvec .* WST_HND; % new vector
            p = seq(i,RWST) + nvec; % new point
            seq(i,RHND) = p; % save the new point
            
            % normalize RTHM
            vec = seq(i,RTHM) - seq(i,RHND); % original vector
            uvec = vec ./ CalcPointDist(seq(i,RTHM),seq(i,RHND)); % unit normal vector
            nvec = uvec .* HND_THM; % new vector
            p = seq(i,RHND) + nvec; % new point
            seq(i,RTHM) = p; % save the new point
            
            % normalize RTIP
            vec = seq(i,RTIP) - seq(i,RHND); % original vector
            uvec = vec ./ CalcPointDist(seq(i,RTIP),seq(i,RHND)); % unit normal vector
            nvec = uvec .* HND_TIP; % new vector
            p = seq(i,RHND) + nvec; % new point
            seq(i,RTIP) = p; % save the new point

            % normalize LSHO
            vec = seq(i,LSHO) - seq(i,SHO); % original vector
            uvec = vec ./ CalcPointDist(seq(i,LSHO),seq(i,SHO)); % unit normal vector
            nvec = uvec .* SHO_BSHO; % new vector
            p = seq(i,SHO) + nvec; % new point
            seq(i,LSHO) = p; % save the new point
            
            % normalize LELB
            vec = seq(i,LELB) - seq(i,LSHO); % original vector
            uvec = vec ./ CalcPointDist(seq(i,LELB),seq(i,LSHO)); % unit normal vector
            nvec = uvec .* BSHO_ELB; % new vector
            p = seq(i,LSHO) + nvec; % new point
            seq(i,LELB) = p; % save the new point
            
            % normalize LWST
            vec = seq(i,LWST) - seq(i,LELB); % original vector
            uvec = vec ./ CalcPointDist(seq(i,LWST),seq(i,LELB)); % unit normal vector
            nvec = uvec .* ELB_WST; % new vector
            p = seq(i,LELB) + nvec; % new point
            seq(i,LWST) = p; % save the new point
            
            % normalize LHND
            vec = seq(i,LHND) - seq(i,LWST); % original vector
            uvec = vec ./ CalcPointDist(seq(i,LHND),seq(i,LWST)); % unit normal vector
            nvec = uvec .* WST_HND; % new vector
            p = seq(i,LWST) + nvec; % new point
            seq(i,LHND) = p; % save the new point
            
            % normalize LTHM
            vec = seq(i,LTHM) - seq(i,LHND); % original vector
            uvec = vec ./ CalcPointDist(seq(i,LTHM),seq(i,LHND)); % unit normal vector
            nvec = uvec .* HND_THM; % new vector
            p = seq(i,LHND) + nvec; % new point
            seq(i,LTHM) = p; % save the new point
            
            % normalize LTIP
            vec = seq(i,LTIP) - seq(i,LHND); % original vector
            uvec = vec ./ CalcPointDist(seq(i,LTIP),seq(i,LHND)); % unit normal vector
            nvec = uvec .* HND_TIP; % new vector
            p = seq(i,LHND) + nvec; % new point
            seq(i,LTIP) = p; % save the new point

            % normalize RHIP
            vec = seq(i,RHIP) - seq(i,HIP); % original vector
            uvec = vec ./ CalcPointDist(seq(i,RHIP),seq(i,HIP)); % unit normal vector
            nvec = uvec .* HIP_BHIP; % new vector
            p = seq(i,HIP) + nvec; % new point
            seq(i,RHIP) = p; % save the new point
            
            % normalize RKNE
            vec = seq(i,RKNE) - seq(i,RHIP); % original vector
            uvec = vec ./ CalcPointDist(seq(i,RKNE),seq(i,RHIP)); % unit normal vector
            nvec = uvec .* BHIP_KNE; % new vector
            p = seq(i,RHIP) + nvec; % new point
            seq(i,RKNE) = p; % save the new point
            
            % normalize RANK
            vec = seq(i,RANK) - seq(i,RKNE); % original vector
            uvec = vec ./ CalcPointDist(seq(i,RANK),seq(i,RKNE)); % unit normal vector
            nvec = uvec .* KNE_ANK; % new vector
            p = seq(i,RKNE) + nvec; % new point
            seq(i,RANK) = p; % save the new point
            
            % normalize RFOT
            vec = seq(i,RFOT) - seq(i,RANK); % original vector
            uvec = vec ./ CalcPointDist(seq(i,RFOT),seq(i,RANK)); % unit normal vector
            nvec = uvec .* ANK_FOT; % new vector
            p = seq(i,RANK) + nvec; % new point
            seq(i,RFOT) = p; % save the new point

            % normalize LHIP
            vec = seq(i,LHIP) - seq(i,HIP); % original vector
            uvec = vec ./ CalcPointDist(seq(i,LHIP),seq(i,HIP)); % unit normal vector
            nvec = uvec .* HIP_BHIP; % new vector
            p = seq(i,HIP) + nvec; % new point
            seq(i,LHIP) = p; % save the new point
            
            % normalize LKNE
            vec = seq(i,LKNE) - seq(i,LHIP); % original vector
            uvec = vec ./ CalcPointDist(seq(i,LKNE),seq(i,LHIP)); % unit normal vector
            nvec = uvec .* BHIP_KNE; % new vector
            p = seq(i,LHIP) + nvec; % new point
            seq(i,LKNE) = p; % save the new point
            
            % normalize LANK
            vec = seq(i,LANK) - seq(i,LKNE); % original vector
            uvec = vec ./ CalcPointDist(seq(i,LANK),seq(i,LKNE)); % unit normal vector
            nvec = uvec .* KNE_ANK; % new vector
            p = seq(i,LKNE) + nvec; % new point
            seq(i,LANK) = p; % save the new point
            
            % normalize LFOT
            vec = seq(i,LFOT) - seq(i,LANK); % original vector
            uvec = vec ./ CalcPointDist(seq(i,LFOT),seq(i,LANK)); % unit normal vector
            nvec = uvec .* ANK_FOT; % new vector
            p = seq(i,LANK) + nvec; % new point
            seq(i,LFOT) = p; % save the new point

        end
    end

    if seqNormalCurr(1,3) == 1 % rotate such that subject faces camera in first frame  
        % (3a) calc first frame rotation of NECK & HIP to face camera (rotate about x-axis),
        % then apply rotation to all frames

        % get degrees to rotate
        p1 = [seq(1,HIP(2)) seq(1,HIP(3)) 0];
        p2 = [seq(1,NECK(2)) seq(1,NECK(3)) 0];
        p3 = [seq(1,HIP(2)) seq(1,NECK(3)) 0];
        deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
        if seq(1,NECK(2)) < seq(1,HIP(2)) % subject neck lower than HIPo
            deg = 180 - deg;
        end

        % determine if NECK or HIP is closer to camera, look at z axis
        if seq(1,NECK(3)) < seq(1,HIP(3)) % NECK is closer
            % rotate counter-clockwise about x axis (when viewing from camera-right side)
            rotMat = [1  0          0          ; ...
                      0  cosd(deg)  sind(deg) ; ...
                      0  -sind(deg)  cosd(deg)] ;
        else % HIP is closer
            % rotate clockwise about x axis (when viewing from camera-right side)
            rotMat = [1  0          0          ; ...
                      0  cosd(deg)  -sind(deg) ; ...
                      0  sind(deg)  cosd(deg)] ;
        end
        for i = 1:size(seq,2)/3 % for each traj in the seq
            seq(:,i*3-2:i*3) = seq(:,i*3-2:i*3) * rotMat; % matrix multiplication    
        end

%         % ensure rotate worked
%         if round(seq(1,NECK(3)),7) ~= round(seq(1,HIP(3)),7)
%            error('Issue with rotate about x-axis'); 
%         end

        % (3b) calc first frame rotation of NECK & HIP such that HIP is directly 
        % beneath NECK (rotate about z-axis), then apply rotation to all frames

        % get degrees to rotate
        p1 = [seq(1,HIP(1)) seq(1,HIP(2)) 0];
        p2 = [seq(1,NECK(1)) seq(1,NECK(2)) 0];
        p3 = [seq(1,NECK(1)) seq(1,HIP(2)) 0];
        deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
        if seq(1,NECK(2)) < seq(1,HIP(2)) % subject neck lower than HIPo
            deg = 180 - deg;
        end

        % determine if NECK is left or right from HIP, look at x axis
        if seq(1,NECK(1)) < seq(1,HIP(1)) % NECK is right from HIP
            % rotate counter-clockwise about z axis (when viewing from camera)
            rotMat = [cosd(deg)  -sind(deg)  0 ; ...
                      sind(deg)  cosd(deg)   0 ; ...
                      0          0           1 ] ;
        else % NECK is left from HIP
            % rotate clockwise about z axis (when viewing from camera)  
            rotMat = [cosd(deg)  sind(deg)  0 ; ...
                      -sind(deg)  cosd(deg)   0 ; ...
                      0          0           1 ] ;
        end
        for i = 1:size(seq,2)/3 % for each traj in the seq
            seq(:,i*3-2:i*3) = seq(:,i*3-2:i*3) * rotMat; % matrix multiplication    
        end

%         % ensure rotate worked
%         if round(seq(1,NECK(1)),7) ~= round(seq(1,HIP(1)),7)
%            error('Issue with rotate about z-axis'); 
%         end

        % (3c) calc first frame rotation of RSHO & LSHO to face camera (rotate about y-axis),
        % then apply rotation to all frames.
        % (for this data, smaller z axis values are closer to camera)

        % first get degrees to rotate - remove y-axis dim
        p1 = [seq(1,RSHO(1)) seq(1,RSHO(3))]; % RSHO point
        p2 = [seq(1,LSHO(1)) seq(1,LSHO(3))]; % LSHO point
        p3 = [seq(1,NECK(1)) seq(1,NECK(3))]; % NECK point
        p5 = Cplsp([seq(1,RSHO(1)) seq(1,RSHO(3))],[seq(1,LSHO(1)) seq(1,LSHO(3))],[seq(1,NECK(1)) seq(1,NECK(3))]); % closest point on line segment RSHO-LSHO to origin (NECK)
        if p5(2) < p3(2) % subject facing camera
            p4 = [seq(1,NECK(1)) min(seq(1,RSHO(3)),seq(1,LSHO(3)))]; % furthest point on z-axis perpendicular to NECK
        else % back of subject facing camera
            p4 = [seq(1,NECK(1)) max(seq(1,RSHO(3)),seq(1,LSHO(3)))]; % furthest point on z-axis perpendicular to NECK
        end
        p6 = LineIntersect2D(p1,p2,p3,p4); % find where line p1-p2 intersects line p3-p4
        deg = AngDeg3DVec([p5 0] , [p3 0] , [p6 0]); % get degree angle from p5 to p3 to p6
        if seq(1,RSHO(1)) < seq(1,LSHO(1)) % back of subject facing camera
            deg = 180 - deg;
        end

        % determine if RSHO or LSHO is closer to camera, look at z axis
        if seq(1,LSHO(3)) < seq(1,RSHO(3)) % left shoulder is closer
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
        for i = 1:size(seq,2)/3 % for each traj in the seq
            seq(:,i*3-2:i*3) = seq(:,i*3-2:i*3) * rotMat; % matrix multiplication    
        end

%         % ensure rotate worked
%         if round(seq(1,RSHO(3)),7) ~= round(seq(1,LSHO(3)),7)
%            error('Issue with rotate about y-axis'); 
%         end
    end
    
    if seqNormalCurr(1,4) == 1 % rotate such that subject faces camera in first frame  
        
        for i = 1:size(seq,1)
            % (4a) calc first frame rotation of NECK & HIP to face camera (rotate about x-axis),
            % then apply rotation to all frames

            % get degrees to rotate
            p1 = [seq(i,HIP(2)) seq(i,HIP(3)) 0];
            p2 = [seq(i,NECK(2)) seq(i,NECK(3)) 0];
            p3 = [seq(i,HIP(2)) seq(i,NECK(3)) 0];
            deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
            if seq(i,NECK(2)) < seq(i,HIP(2)) % subject neck lower than HIPo
                deg = 180 - deg;
            end

            % determine if NECK or HIP is closer to camera, look at z axis
            if seq(i,NECK(3)) < seq(i,HIP(3)) % NECK is closer
                % rotate counter-clockwise about x axis (when viewing from camera-right side)
                rotMat = [1  0          0          ; ...
                          0  cosd(deg)  sind(deg) ; ...
                          0  -sind(deg)  cosd(deg)] ;
            else % HIP is closer
                % rotate clockwise about x axis (when viewing from camera-right side)
                rotMat = [1  0          0          ; ...
                          0  cosd(deg)  -sind(deg) ; ...
                          0  sind(deg)  cosd(deg)] ;
            end
            for j = 1:size(seq,2)/3 % for each joint in the seq
                seq(i,j*3-2:j*3) = seq(i,j*3-2:j*3) * rotMat; % matrix multiplication    
            end

%             % ensure rotate worked
%             if round(seq(i,NECK(3)),7) ~= round(seq(i,HIP(3)),7)
%                error('Issue with rotate about x-axis'); 
%             end

            % (4b) calc first frame rotation of NECK & HIP such that HIP is directly 
            % beneath NECK (rotate about z-axis), then apply rotation to all frames

            % get degrees to rotate
            p1 = [seq(i,HIP(1)) seq(i,HIP(2)) 0];
            p2 = [seq(i,NECK(1)) seq(i,NECK(2)) 0];
            p3 = [seq(i,NECK(1)) seq(i,HIP(2)) 0];
            deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
            if seq(i,NECK(2)) < seq(i,HIP(2)) % subject neck lower than HIPo
                deg = 180 - deg;
            end

            % determine if NECK is left or right from HIP, look at x axis
            if seq(i,NECK(1)) < seq(i,HIP(1)) % NECK is right from HIP
                % rotate counter-clockwise about z axis (when viewing from camera)
                rotMat = [cosd(deg)  -sind(deg)  0 ; ...
                          sind(deg)  cosd(deg)   0 ; ...
                          0          0           1 ] ;
            else % NECK is left from HIP
                % rotate clockwise about z axis (when viewing from camera)  
                rotMat = [cosd(deg)  sind(deg)  0 ; ...
                          -sind(deg)  cosd(deg)   0 ; ...
                          0          0           1 ] ;
            end
            for j = 1:size(seq,2)/3 % for each joint in the seq
                seq(i,j*3-2:j*3) = seq(i,j*3-2:j*3) * rotMat; % matrix multiplication    
            end

%             % ensure rotate worked
%             if round(seq(i,NECK(1)),7) ~= round(seq(i,HIP(1)),7)
%                error('Issue with rotate about z-axis'); 
%             end

            % (4c) calc first frame rotation of RSHO & LSHO to face camera (rotate about y-axis),
            % then apply rotation to all frames.
            % (for this data, smaller z axis values are closer to camera)

            % first get degrees to rotate - remove y-axis dim
            p1 = [seq(i,RSHO(1)) seq(i,RSHO(3))]; % RSHO point
            p2 = [seq(i,LSHO(1)) seq(i,LSHO(3))]; % LSHO point
            p3 = [seq(i,NECK(1)) seq(i,NECK(3))]; % NECK point
            p5 = Cplsp([seq(i,RSHO(1)) seq(i,RSHO(3))],[seq(i,LSHO(1)) seq(i,LSHO(3))],[seq(i,NECK(1)) seq(i,NECK(3))]); % closest point on line segment RSHO-LSHO to origin (NECK)
            if p5(2) < p3(2) % subject facing camera
                p4 = [seq(i,NECK(1)) min(seq(i,RSHO(3)),seq(i,LSHO(3)))]; % furthest point on z-axis perpendicular to NECK
            else % back of subject facing camera
                p4 = [seq(i,NECK(1)) max(seq(i,RSHO(3)),seq(i,LSHO(3)))]; % furthest point on z-axis perpendicular to NECK
            end
            p6 = LineIntersect2D(p1,p2,p3,p4); % find where line p1-p2 intersects line p3-p4
            deg = AngDeg3DVec([p5 0] , [p3 0] , [p6 0]); % get degree angle from p5 to p3 to p6
            if seq(i,RSHO(1)) < seq(i,LSHO(1)) % back of subject facing camera
                deg = 180 - deg;
            end

            % determine if RSHO or LSHO is closer to camera, look at z axis
            if seq(i,LSHO(3)) < seq(i,RSHO(3)) % left shoulder is closer
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
            for j = 1:size(seq,2)/3 % for each traj in the seq
                seq(i,j*3-2:j*3) = seq(i,j*3-2:j*3) * rotMat; % matrix multiplication    
            end

%             % ensure rotate worked
%             if round(seq(i,RSHO(3)),7) ~= round(seq(i,LSHO(3)),7)
%                error('Issue with rotate about y-axis'); 
%             end
        end
    end
    
    if seqNormalCurr(1,1) == 1
        % (1) for each frame, translate all joints so that SPIN first frame
        % is at coordinate (0,0,0)
        transPoint = [seq(1,SPIN(1))*-1 seq(1,SPIN(2))*-1 seq(1,SPIN(3))*-1];
        seq = [seq(:,HIP)+transPoint seq(:,SPIN)+transPoint seq(:,NECK)+transPoint seq(:,HEAD)+transPoint ...
                   seq(:,LSHO)+transPoint seq(:,LELB)+transPoint seq(:,LWST)+transPoint seq(:,LHND)+transPoint ...
                   seq(:,RSHO)+transPoint seq(:,RELB)+transPoint seq(:,RWST)+transPoint seq(:,RHND)+transPoint ...
                   seq(:,LHIP)+transPoint seq(:,LKNE)+transPoint seq(:,LANK)+transPoint seq(:,LFOT)+transPoint ...
                   seq(:,RHIP)+transPoint seq(:,RKNE)+transPoint seq(:,RANK)+transPoint seq(:,RFOT)+transPoint ...
                   seq(:,SHO)+transPoint seq(:,LTIP)+transPoint seq(:,LTHM)+transPoint seq(:,RTIP)+transPoint ...
                   seq(:,RTHM)+transPoint];
    end

    if seqNormalCurr(1,2) == 1
        % (2) for each frame, translate all joints so that SPIN is always
        % fixed to coordinate (0,0,0)
        transPoint = [seq(:,SPIN(1))*-1 seq(:,SPIN(2))*-1 seq(:,SPIN(3))*-1];
        seq = [seq(:,HIP)+transPoint seq(:,SPIN)+transPoint seq(:,NECK)+transPoint seq(:,HEAD)+transPoint ...
                   seq(:,LSHO)+transPoint seq(:,LELB)+transPoint seq(:,LWST)+transPoint seq(:,LHND)+transPoint ...
                   seq(:,RSHO)+transPoint seq(:,RELB)+transPoint seq(:,RWST)+transPoint seq(:,RHND)+transPoint ...
                   seq(:,LHIP)+transPoint seq(:,LKNE)+transPoint seq(:,LANK)+transPoint seq(:,LFOT)+transPoint ...
                   seq(:,RHIP)+transPoint seq(:,RKNE)+transPoint seq(:,RANK)+transPoint seq(:,RFOT)+transPoint ...
                   seq(:,SHO)+transPoint seq(:,LTIP)+transPoint seq(:,LTHM)+transPoint seq(:,RTIP)+transPoint ...
                   seq(:,RTHM)+transPoint];
    end

    if seqNormalCurr(1,6) == 1
        % (6) put the "at rest" frame at the beginning and end of the seq
        seq = NTURGBDAtRest(seq);
    end
    
%     if seqNormalCurr(1,7) == 1 % simplify
%         reach = TrajReach(seq); % get traj reach 
%         seq = TrajSimp(seq,reach * 0.05);
%     end

end