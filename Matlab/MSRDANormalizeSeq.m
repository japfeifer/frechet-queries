
function seq = MSRDANormalizeSeq(seq,seqNormalCurr)
    
    TORS = [1,2,3]; BACK = [4,5,6]; NECK = [7,8,9]; HEAD = [10,11,12];
    LSHO = [13,14,15]; LELB = [16,17,18]; LWST = [19,20,21]; LHND = [22,23,24];
    RSHO = [25,26,27]; RELB = [28,29,30]; RWST = [31,32,33]; RHND = [34,35,36];
    LHIP = [37,38,39]; LKNE = [40,41,42]; LANK = [43,44,45]; LFOT = [46,47,48];
    RHIP = [49,50,51]; RKNE = [52,53,54]; RANK = [55,56,57]; RFOT = [58,59,60];

    % normalized limb distances
    HEAD_NECK = 74;
    NECK_TORS = 510;
    NECK_SHO =  148;
    SHO_ELB =   143;  
    ELB_HND =   400;
    TORS_HIP =  68;
    HIP_KNE =   402;
    KNE_FOT =   409;
    
    if seqNormalCurr(1,1) == 1
        % (1) for each frame, translate all joints so that NECK is always at
        % coordinate (0,0,0)
        transPoint = [seq(:,NECK(1))*-1 seq(:,NECK(2))*-1 seq(:,NECK(3))*-1];
        seq = [seq(:,TORS)+transPoint seq(:,BACK)+transPoint ...
               seq(:,NECK)+transPoint seq(:,HEAD)+transPoint ...
               seq(:,LSHO)+transPoint seq(:,LELB)+transPoint ...
               seq(:,LWST)+transPoint seq(:,LHND)+transPoint ...
               seq(:,RSHO)+transPoint seq(:,RELB)+transPoint ...
               seq(:,RWST)+transPoint seq(:,RHND)+transPoint ...
               seq(:,LHIP)+transPoint seq(:,LKNE)+transPoint ...
               seq(:,LANK)+transPoint seq(:,LFOT)+transPoint ...
               seq(:,RHIP)+transPoint seq(:,RKNE)+transPoint ...
               seq(:,RANK)+transPoint seq(:,RFOT)+transPoint];
    end

%     if seqNormalCurr(1,2) == 1
%         % (2a) calc first frame rotation of NECK & TORS to face camera (rotate about x-axis),
%         % then apply rotation to all frames
% 
%         % get degrees to rotate
%         p1 = [seq(1,TORS(2)) seq(1,TORS(3)) 0];
%         p2 = [seq(1,NECK(2)) seq(1,NECK(3)) 0];
%         p3 = [seq(1,TORS(2)) seq(1,NECK(3)) 0];
%         deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
%         if seq(1,NECK(2)) < seq(1,TORS(2)) % subject neck lower than torso
%             deg = 180 - deg;
%         end
% 
%         % determine if NECK or TORS is closer to camera, look at z axis
%         if seq(1,NECK(3)) < seq(1,TORS(3)) % NECK is closer
%             % rotate counter-clockwise about x axis (when viewing from camera-right side)
%             rotMat = [1  0          0          ; ...
%                       0  cosd(deg)  sind(deg) ; ...
%                       0  -sind(deg)  cosd(deg)] ;
%         else % TORS is closer
%             % rotate clockwise about x axis (when viewing from camera-right side)
%             rotMat = [1  0          0          ; ...
%                       0  cosd(deg)  -sind(deg) ; ...
%                       0  sind(deg)  cosd(deg)] ;
%         end
%         for i = 1:size(seq,2)/3 % for each traj in the seq
%             seq(:,i*3-2:i*3) = seq(:,i*3-2:i*3) * rotMat; % matrix multiplication    
%         end
% 
%         % ensure rotate worked
%         if round(seq(1,NECK(3)),7) ~= round(seq(1,TORS(3)),7)
%            error('Issue with rotate about x-axis'); 
%         end
% 
%         % (2b) calc first frame rotation of NECK & TORS such that TORS is directly 
%         % beneath NECK (rotate about z-axis), then apply rotation to all frames
% 
%         % get degrees to rotate
%         p1 = [seq(1,TORS(1)) seq(1,TORS(2)) 0];
%         p2 = [seq(1,NECK(1)) seq(1,NECK(2)) 0];
%         p3 = [seq(1,NECK(1)) seq(1,TORS(2)) 0];
%         deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
%         if seq(1,NECK(2)) < seq(1,TORS(2)) % subject neck lower than torso
%             deg = 180 - deg;
%         end
% 
%         % determine if NECK is left or right from TORS, look at x axis
%         if seq(1,NECK(1)) < seq(1,TORS(1)) % NECK is right from TORS
%             % rotate counter-clockwise about z axis (when viewing from camera)
%             rotMat = [cosd(deg)  -sind(deg)  0 ; ...
%                       sind(deg)  cosd(deg)   0 ; ...
%                       0          0           1 ] ;
%         else % NECK is left from TORS
%             % rotate clockwise about z axis (when viewing from camera)  
%             rotMat = [cosd(deg)  sind(deg)  0 ; ...
%                       -sind(deg)  cosd(deg)   0 ; ...
%                       0          0           1 ] ;
%         end
%         for i = 1:size(seq,2)/3 % for each traj in the seq
%             seq(:,i*3-2:i*3) = seq(:,i*3-2:i*3) * rotMat; % matrix multiplication    
%         end
% 
%         % ensure rotate worked
%         if round(seq(1,NECK(1)),7) ~= round(seq(1,TORS(1)),7)
%            error('Issue with rotate about z-axis'); 
%         end
%     end
%     
%     if seqNormalCurr(1,3) == 1
%         % (3) calc first frame rotation of RSHO & LSHO to face camera (rotate about y-axis),
%         % then apply rotation to all frames.
%         % (for this data, smaller z axis values are closer to camera)
% 
%         % first get degrees to rotate - remove y-axis dim
%         p1 = [seq(1,RSHO(1)) seq(1,RSHO(3))]; % RSHO point
%         p2 = [seq(1,LSHO(1)) seq(1,LSHO(3))]; % LSHO point
%         p3 = [seq(1,NECK(1)) seq(1,NECK(3))]; % NECK point
%         p5 = Cplsp([seq(1,RSHO(1)) seq(1,RSHO(3))],[seq(1,LSHO(1)) seq(1,LSHO(3))],[seq(1,NECK(1)) seq(1,NECK(3))]); % closest point on line segment RSHO-LSHO to origin (NECK)
%         if p5(2) < p3(2) % subject facing camera
%             p4 = [seq(1,NECK(1)) min(seq(1,RSHO(3)),seq(1,LSHO(3)))]; % furthest point on z-axis perpendicular to NECK
%         else % back of subject facing camera
%             p4 = [seq(1,NECK(1)) max(seq(1,RSHO(3)),seq(1,LSHO(3)))]; % furthest point on z-axis perpendicular to NECK
%         end
%         p6 = LineIntersect2D(p1,p2,p3,p4); % find where line p1-p2 intersects line p3-p4
%         deg = AngDeg3DVec([p5 0] , [p3 0] , [p6 0]); % get degree angle from p5 to p3 to p6
%         if seq(1,RSHO(1)) < seq(1,LSHO(1)) % back of subject facing camera
%             deg = 180 - deg;
%         end
% 
%         % determine if RSHO or LSHO is closer to camera, look at z axis
%         if seq(1,LSHO(3)) < seq(1,RSHO(3)) % left shoulder is closer
%             % rotate counter-clockwise about y axis (when viewing top-down from camera)
%             rotMat = [cosd(deg)  0  -sind(deg); ...
%                       0          1  0         ; ...
%                       sind(deg)  0  cosd(deg)];
%         else % right shouder is closer
%             % rotate clockwise about y axis (when viewing top-down from camera)
%             rotMat = [cosd(deg)  0  sind(deg) ; ...
%                      0           1  0         ; ...
%                      -sind(deg)  0  cosd(deg)];
%         end
%         for i = 1:size(seq,2)/3 % for each traj in the seq
%             seq(:,i*3-2:i*3) = seq(:,i*3-2:i*3) * rotMat; % matrix multiplication    
%         end
% 
%         % ensure rotate worked
%         if round(seq(1,RSHO(3)),7) ~= round(seq(1,LSHO(3)),7)
%            error('Issue with rotate about y-axis'); 
%         end
%     end
% 
%     if seqNormalCurr(1,4) == 1
%         % (4) for each frame, normalize the limb lengths, but keep the same limb
%         % vectors
%         for i=1:size(seq,1)
%             % normalize HEAD
%             vec = seq(i,HEAD) - seq(i,NECK); % original vector
%             uvec = vec ./ CalcPointDist(seq(i,HEAD),seq(i,NECK)); % unit normal vector
%             nvec = uvec .* HEAD_NECK; % new vector
%             p = seq(i,NECK) + nvec; % new point
%             seq(i,HEAD) = p; % save the new point
% 
%             % normalize TORS
%             vec = seq(i,TORS) - seq(i,NECK); % original vector
%             uvec = vec ./ CalcPointDist(seq(i,TORS),seq(i,NECK)); % unit normal vector
%             nvec = uvec .* NECK_TORS; % new vector
%             p = seq(i,NECK) + nvec; % new point
%             seq(i,TORS) = p; % save the new point
% 
%             % normalize RSHO
%             vec = seq(i,RSHO) - seq(i,NECK); % original vector
%             uvec = vec ./ CalcPointDist(seq(i,RSHO),seq(i,NECK)); % unit normal vector
%             nvec = uvec .* NECK_SHO; % new vector
%             p = seq(i,NECK) + nvec; % new point
%             seq(i,RSHO) = p; % save the new point
% 
%             % normalize RELB
%             vec = seq(i,RELB) - seq(i,RSHO); % original vector
%             uvec = vec ./ CalcPointDist(seq(i,RELB),seq(i,RSHO)); % unit normal vector
%             nvec = uvec .* SHO_ELB; % new vector
%             p = seq(i,RSHO) + nvec; % new point
%             seq(i,RELB) = p; % save the new point
% 
%             % normalize RHND
%             vec = seq(i,RHND) - seq(i,RELB); % original vector
%             uvec = vec ./ CalcPointDist(seq(i,RHND),seq(i,RELB)); % unit normal vector
%             nvec = uvec .* ELB_HND; % new vector
%             p = seq(i,RELB) + nvec; % new point
%             seq(i,RHND) = p; % save the new point
% 
%             % normalize LSHO
%             vec = seq(i,LSHO) - seq(i,NECK); % original vector
%             uvec = vec ./ CalcPointDist(seq(i,LSHO),seq(i,NECK)); % unit normal vector
%             nvec = uvec .* NECK_SHO; % new vector
%             p = seq(i,NECK) + nvec; % new point
%             seq(i,LSHO) = p; % save the new point
% 
%             % normalize LELB
%             vec = seq(i,LELB) - seq(i,LSHO); % original vector
%             uvec = vec ./ CalcPointDist(seq(i,LELB),seq(i,LSHO)); % unit normal vector
%             nvec = uvec .* SHO_ELB; % new vector
%             p = seq(i,LSHO) + nvec; % new point
%             seq(i,LELB) = p; % save the new point
% 
%             % normalize LHND
%             vec = seq(i,LHND) - seq(i,LELB); % original vector
%             uvec = vec ./ CalcPointDist(seq(i,LHND),seq(i,LELB)); % unit normal vector
%             nvec = uvec .* ELB_HND; % new vector
%             p = seq(i,LELB) + nvec; % new point
%             seq(i,LHND) = p; % save the new point
% 
%             % normalize RHIP
%             vec = seq(i,RHIP) - seq(i,TORS); % original vector
%             uvec = vec ./ CalcPointDist(seq(i,RHIP),seq(i,TORS)); % unit normal vector
%             nvec = uvec .* TORS_HIP; % new vector
%             p = seq(i,TORS) + nvec; % new point
%             seq(i,RHIP) = p; % save the new point
% 
%             % normalize RKNE
%             vec = seq(i,RKNE) - seq(i,RHIP); % original vector
%             uvec = vec ./ CalcPointDist(seq(i,RKNE),seq(i,RHIP)); % unit normal vector
%             nvec = uvec .* HIP_KNE; % new vector
%             p = seq(i,RHIP) + nvec; % new point
%             seq(i,RKNE) = p; % save the new point
% 
%             % normalize RFOT
%             vec = seq(i,RFOT) - seq(i,RKNE); % original vector
%             uvec = vec ./ CalcPointDist(seq(i,RFOT),seq(i,RKNE)); % unit normal vector
%             nvec = uvec .* KNE_FOT; % new vector
%             p = seq(i,RKNE) + nvec; % new point
%             seq(i,RFOT) = p; % save the new point
% 
%             % normalize LHIP
%             vec = seq(i,LHIP) - seq(i,TORS); % original vector
%             uvec = vec ./ CalcPointDist(seq(i,LHIP),seq(i,TORS)); % unit normal vector
%             nvec = uvec .* TORS_HIP; % new vector
%             p = seq(i,TORS) + nvec; % new point
%             seq(i,LHIP) = p; % save the new point
% 
%             % normalize LKNE
%             vec = seq(i,LKNE) - seq(i,LHIP); % original vector
%             uvec = vec ./ CalcPointDist(seq(i,LKNE),seq(i,LHIP)); % unit normal vector
%             nvec = uvec .* HIP_KNE; % new vector
%             p = seq(i,LHIP) + nvec; % new point
%             seq(i,LKNE) = p; % save the new point
% 
%             % normalize RFOT
%             vec = seq(i,LFOT) - seq(i,LKNE); % original vector
%             uvec = vec ./ CalcPointDist(seq(i,LFOT),seq(i,LKNE)); % unit normal vector
%             nvec = uvec .* KNE_FOT; % new vector
%             p = seq(i,LKNE) + nvec; % new point
%             seq(i,LFOT) = p; % save the new point
%         end
%     end
    
    if seqNormalCurr(1,5) == 1
        % (5) put the "at rest" frame at the beginning and end of the seq
        seq = MSRDAAtRest(seq);
    end
    
end