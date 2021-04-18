
function seq = MSASLNormalizeSeq(seq,seqNormalCurr)

    HEAD  = [1,2,3]; SHO = [4,5,6]; RSHO = [7,8,9]; RELB = [10,11,12];
    RHND = [13,14,15]; LSHO = [16,17,18]; LELB = [19,20,21]; LHND = [22,23,24];
    RHIP = [25,26,27]; RKNE = [28,29,30]; RFOT = [31,32,33]; LHIP = [34,35,36];
    LKNE = [37,38,39]; LFOT = [40,41,42]; RHED = [43,44,45]; LHED = [46,47,48];
    REAR = [49,50,51]; LEAR = [52,53,54]; 

    if seqNormalCurr(1,5) == 1
        % (5) for each frame, normalize the limb lengths, but keep the same
        % limb vector
        
        % normalized limb distances
        SHO_HEAD = 145.894;
        HEAD_RHED = 34.53;
        RHED_REAR = 41.846;
        HEAD_LHED = 35.219;
        LHED_LEAR = 44.445;
        SHO_RSHO = 121.13;
        RSHO_RELB = 189.155;
        RELB_RHND = 137.743;
        SHO_LSHO = 120.905;
        LSHO_LELB = 196.287;
        LELB_LHND = 117.775;

        for i=1:size(seq,1)
            % normalize HEAD
            vec = seq(i,HEAD) - seq(i,SHO); % original vector
            uvec = vec ./ CalcPointDist(seq(i,HEAD),seq(i,SHO)); % unit normal vector
            nvec = uvec .* SHO_HEAD; % new vector
            p = seq(i,SHO) + nvec; % new point
            seq(i,HEAD) = p; % save the new point

            % normalize RHED
            vec = seq(i,RHED) - seq(i,HEAD); % original vector
            uvec = vec ./ CalcPointDist(seq(i,RHED),seq(i,HEAD)); % unit normal vector
            nvec = uvec .* HEAD_RHED; % new vector
            p = seq(i,HEAD) + nvec; % new point
            seq(i,RHED) = p; % save the new point
            
            % normalize REAR
            vec = seq(i,REAR) - seq(i,RHED); % original vector
            uvec = vec ./ CalcPointDist(seq(i,REAR),seq(i,RHED)); % unit normal vector
            nvec = uvec .* RHED_REAR; % new vector
            p = seq(i,RHED) + nvec; % new point
            seq(i,REAR) = p; % save the new point
            
            % normalize LHED
            vec = seq(i,LHED) - seq(i,HEAD); % original vector
            uvec = vec ./ CalcPointDist(seq(i,LHED),seq(i,HEAD)); % unit normal vector
            nvec = uvec .* HEAD_LHED; % new vector
            p = seq(i,HEAD) + nvec; % new point
            seq(i,LHED) = p; % save the new point
            
            % normalize LEAR
            vec = seq(i,LEAR) - seq(i,LHED); % original vector
            uvec = vec ./ CalcPointDist(seq(i,LEAR),seq(i,LHED)); % unit normal vector
            nvec = uvec .* LHED_LEAR; % new vector
            p = seq(i,LHED) + nvec; % new point
            seq(i,LEAR) = p; % save the new point
            
            % normalize RSHO
            vec = seq(i,RSHO) - seq(i,SHO); % original vector
            uvec = vec ./ CalcPointDist(seq(i,RSHO),seq(i,SHO)); % unit normal vector
            nvec = uvec .* SHO_RSHO; % new vector
            p = seq(i,SHO) + nvec; % new point
            seq(i,RSHO) = p; % save the new point
            
            % normalize RELB
            vec = seq(i,RELB) - seq(i,RSHO); % original vector
            uvec = vec ./ CalcPointDist(seq(i,RELB),seq(i,RSHO)); % unit normal vector
            nvec = uvec .* RSHO_RELB; % new vector
            p = seq(i,RSHO) + nvec; % new point
            seq(i,RELB) = p; % save the new point
            
            % normalize RHND
            vec = seq(i,RHND) - seq(i,RELB); % original vector
            uvec = vec ./ CalcPointDist(seq(i,RHND),seq(i,RELB)); % unit normal vector
            nvec = uvec .* RELB_RHND; % new vector
            p = seq(i,RELB) + nvec; % new point
            seq(i,RHND) = p; % save the new point
            
            % normalize LSHO
            vec = seq(i,LSHO) - seq(i,SHO); % original vector
            uvec = vec ./ CalcPointDist(seq(i,LSHO),seq(i,SHO)); % unit normal vector
            nvec = uvec .* SHO_LSHO; % new vector
            p = seq(i,SHO) + nvec; % new point
            seq(i,LSHO) = p; % save the new point
            
            % normalize LELB
            vec = seq(i,LELB) - seq(i,LSHO); % original vector
            uvec = vec ./ CalcPointDist(seq(i,LELB),seq(i,LSHO)); % unit normal vector
            nvec = uvec .* LSHO_LELB; % new vector
            p = seq(i,LSHO) + nvec; % new point
            seq(i,LELB) = p; % save the new point
            
            % normalize LHND
            vec = seq(i,LHND) - seq(i,LELB); % original vector
            uvec = vec ./ CalcPointDist(seq(i,LHND),seq(i,LELB)); % unit normal vector
            nvec = uvec .* LELB_LHND; % new vector
            p = seq(i,LELB) + nvec; % new point
            seq(i,LHND) = p; % save the new point

        end
    end

    if seqNormalCurr(1,3) == 1 % rotate such that subject faces camera in first frame  
        % (3a) calc first frame rotation of HEAD & SHO to face camera (rotate about x-axis),
        % then apply rotation to all frames

        % get degrees to rotate
        p1 = [seq(1,SHO(2)) seq(1,SHO(3)) 0];
        p2 = [seq(1,HEAD(2)) seq(1,HEAD(3)) 0];
        p3 = [seq(1,SHO(2)) seq(1,HEAD(3)) 0];
        deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
        if seq(1,HEAD(2)) < seq(1,SHO(2)) % subject HEAD lower than SHO
            deg = 180 - deg;
        end

        % determine if HEAD or SHO is closer to camera, look at z axis
        if seq(1,HEAD(3)) < seq(1,SHO(3)) % HEAD is closer
            % rotate counter-clockwise about x axis (when viewing from camera-right side)
            rotMat = [1  0          0          ; ...
                      0  cosd(deg)  sind(deg) ; ...
                      0  -sind(deg)  cosd(deg)] ;
        else % SHO is closer
            % rotate clockwise about x axis (when viewing from camera-right side)
            rotMat = [1  0          0          ; ...
                      0  cosd(deg)  -sind(deg) ; ...
                      0  sind(deg)  cosd(deg)] ;
        end
        for i = 1:size(seq,2)/3 % for each traj in the seq
            seq(:,i*3-2:i*3) = seq(:,i*3-2:i*3) * rotMat; % matrix multiplication    
        end

%         % ensure rotate worked
%         if round(seq(1,HEAD(3)),7) ~= round(seq(1,SHO(3)),7)
%            error('Issue with rotate about x-axis'); 
%         end

        % (3b) calc first frame rotation of HEAD & SHO such that SHO is directly 
        % beneath HEAD (rotate about z-axis), then apply rotation to all frames

        % get degrees to rotate
        p1 = [seq(1,SHO(1)) seq(1,SHO(2)) 0];
        p2 = [seq(1,HEAD(1)) seq(1,HEAD(2)) 0];
        p3 = [seq(1,HEAD(1)) seq(1,SHO(2)) 0];
        deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
        if seq(1,HEAD(2)) < seq(1,SHO(2)) % subject HEAD lower than SHOo
            deg = 180 - deg;
        end

        % determine if HEAD is left or right from SHO, look at x axis
        if seq(1,HEAD(1)) < seq(1,SHO(1)) % HEAD is right from SHO
            % rotate counter-clockwise about z axis (when viewing from camera)
            rotMat = [cosd(deg)  -sind(deg)  0 ; ...
                      sind(deg)  cosd(deg)   0 ; ...
                      0          0           1 ] ;
        else % HEAD is left from SHO
            % rotate clockwise about z axis (when viewing from camera)  
            rotMat = [cosd(deg)  sind(deg)  0 ; ...
                      -sind(deg)  cosd(deg)   0 ; ...
                      0          0           1 ] ;
        end
        for i = 1:size(seq,2)/3 % for each traj in the seq
            seq(:,i*3-2:i*3) = seq(:,i*3-2:i*3) * rotMat; % matrix multiplication    
        end

%         % ensure rotate worked
%         if round(seq(1,HEAD(1)),7) ~= round(seq(1,SHO(1)),7)
%            error('Issue with rotate about z-axis'); 
%         end

        % (3c) calc first frame rotation of RSHO & LSHO to face camera (rotate about y-axis),
        % then apply rotation to all frames.
        % (for this data, smaller z axis values are closer to camera)

        % first get degrees to rotate - remove y-axis dim
        p1 = [seq(1,RSHO(1)) seq(1,RSHO(3))]; % RSHO point
        p2 = [seq(1,LSHO(1)) seq(1,LSHO(3))]; % LSHO point
        p3 = [seq(1,HEAD(1)) seq(1,HEAD(3))]; % HEAD point
        p5 = Cplsp([seq(1,RSHO(1)) seq(1,RSHO(3))],[seq(1,LSHO(1)) seq(1,LSHO(3))],[seq(1,HEAD(1)) seq(1,HEAD(3))]); % closest point on line segment RSHO-LSHO to origin (HEAD)
        if p5(2) < p3(2) % subject facing camera
            p4 = [seq(1,HEAD(1)) min(seq(1,RSHO(3)),seq(1,LSHO(3)))]; % furthest point on z-axis perpendicular to HEAD
        else % back of subject facing camera
            p4 = [seq(1,HEAD(1)) max(seq(1,RSHO(3)),seq(1,LSHO(3)))]; % furthest point on z-axis perpendicular to HEAD
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
            % (4a) calc first frame rotation of HEAD & SHO to face camera (rotate about x-axis),
            % then apply rotation to all frames

            % get degrees to rotate
            p1 = [seq(i,SHO(2)) seq(i,SHO(3)) 0];
            p2 = [seq(i,HEAD(2)) seq(i,HEAD(3)) 0];
            p3 = [seq(i,SHO(2)) seq(i,HEAD(3)) 0];
            deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
            if seq(i,HEAD(2)) < seq(i,SHO(2)) % subject HEAD lower than SHOo
                deg = 180 - deg;
            end

            % determine if HEAD or SHO is closer to camera, look at z axis
            if seq(i,HEAD(3)) < seq(i,SHO(3)) % HEAD is closer
                % rotate counter-clockwise about x axis (when viewing from camera-right side)
                rotMat = [1  0          0          ; ...
                          0  cosd(deg)  sind(deg) ; ...
                          0  -sind(deg)  cosd(deg)] ;
            else % SHO is closer
                % rotate clockwise about x axis (when viewing from camera-right side)
                rotMat = [1  0          0          ; ...
                          0  cosd(deg)  -sind(deg) ; ...
                          0  sind(deg)  cosd(deg)] ;
            end
            for j = 1:size(seq,2)/3 % for each joint in the seq
                seq(i,j*3-2:j*3) = seq(i,j*3-2:j*3) * rotMat; % matrix multiplication    
            end

%             % ensure rotate worked
%             if round(seq(i,HEAD(3)),7) ~= round(seq(i,SHO(3)),7)
%                error('Issue with rotate about x-axis'); 
%             end

            % (4b) calc first frame rotation of HEAD & SHO such that SHO is directly 
            % beneath HEAD (rotate about z-axis), then apply rotation to all frames

            % get degrees to rotate
            p1 = [seq(i,SHO(1)) seq(i,SHO(2)) 0];
            p2 = [seq(i,HEAD(1)) seq(i,HEAD(2)) 0];
            p3 = [seq(i,HEAD(1)) seq(i,SHO(2)) 0];
            deg = AngDeg3DVec(p1,p2,p3); % get degree angle from p1 to p2 to p3
            if seq(i,HEAD(2)) < seq(i,SHO(2)) % subject HEAD lower than SHOo
                deg = 180 - deg;
            end

            % determine if HEAD is left or right from SHO, look at x axis
            if seq(i,HEAD(1)) < seq(i,SHO(1)) % HEAD is right from SHO
                % rotate counter-clockwise about z axis (when viewing from camera)
                rotMat = [cosd(deg)  -sind(deg)  0 ; ...
                          sind(deg)  cosd(deg)   0 ; ...
                          0          0           1 ] ;
            else % HEAD is left from SHO
                % rotate clockwise about z axis (when viewing from camera)  
                rotMat = [cosd(deg)  sind(deg)  0 ; ...
                          -sind(deg)  cosd(deg)   0 ; ...
                          0          0           1 ] ;
            end
            for j = 1:size(seq,2)/3 % for each joint in the seq
                seq(i,j*3-2:j*3) = seq(i,j*3-2:j*3) * rotMat; % matrix multiplication    
            end

%             % ensure rotate worked
%             if round(seq(i,HEAD(1)),7) ~= round(seq(i,SHO(1)),7)
%                error('Issue with rotate about z-axis'); 
%             end

            % (4c) calc first frame rotation of RSHO & LSHO to face camera (rotate about y-axis),
            % then apply rotation to all frames.
            % (for this data, smaller z axis values are closer to camera)

            % first get degrees to rotate - remove y-axis dim
            p1 = [seq(i,RSHO(1)) seq(i,RSHO(3))]; % RSHO point
            p2 = [seq(i,LSHO(1)) seq(i,LSHO(3))]; % LSHO point
            p3 = [seq(i,HEAD(1)) seq(i,HEAD(3))]; % HEAD point
            p5 = Cplsp([seq(i,RSHO(1)) seq(i,RSHO(3))],[seq(i,LSHO(1)) seq(i,LSHO(3))],[seq(i,HEAD(1)) seq(i,HEAD(3))]); % closest point on line segment RSHO-LSHO to origin (HEAD)
            if p5(2) < p3(2) % subject facing camera
                p4 = [seq(i,HEAD(1)) min(seq(i,RSHO(3)),seq(i,LSHO(3)))]; % furthest point on z-axis perpendicular to HEAD
            else % back of subject facing camera
                p4 = [seq(i,HEAD(1)) max(seq(i,RSHO(3)),seq(i,LSHO(3)))]; % furthest point on z-axis perpendicular to HEAD
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
        % (1) for each frame, translate all joints so that SHO first frame
        % is at coordinate (0,0,0)
        transPoint = [seq(1,SHO(1))*-1 seq(1,SHO(2))*-1 seq(1,SHO(3))*-1];
        seq = [seq(:,HEAD)+transPoint seq(:,SHO)+transPoint seq(:,RSHO)+transPoint seq(:,RELB)+transPoint ...
                   seq(:,RHND)+transPoint seq(:,LSHO)+transPoint seq(:,LELB)+transPoint seq(:,LHND)+transPoint ...
                   seq(:,RHIP)+transPoint seq(:,RKNE)+transPoint seq(:,RFOT)+transPoint seq(:,LHIP)+transPoint ...
                   seq(:,LKNE)+transPoint seq(:,LFOT)+transPoint seq(:,RHED)+transPoint seq(:,LHED)+transPoint ...
                   seq(:,REAR)+transPoint seq(:,LEAR)+transPoint];
    end

    if seqNormalCurr(1,2) == 1
        % (2) for each frame, translate all joints so that SHO is always
        % fixed to coordinate (0,0,0)
        transPoint = [seq(:,SHO(1))*-1 seq(:,SHO(2))*-1 seq(:,SHO(3))*-1];
        seq = [seq(:,HEAD)+transPoint seq(:,SHO)+transPoint seq(:,RSHO)+transPoint seq(:,RELB)+transPoint ...
                   seq(:,RHND)+transPoint seq(:,LSHO)+transPoint seq(:,LELB)+transPoint seq(:,LHND)+transPoint ...
                   seq(:,RHIP)+transPoint seq(:,RKNE)+transPoint seq(:,RFOT)+transPoint seq(:,LHIP)+transPoint ...
                   seq(:,LKNE)+transPoint seq(:,LFOT)+transPoint seq(:,RHED)+transPoint seq(:,LHED)+transPoint ...
                   seq(:,REAR)+transPoint seq(:,LEAR)+transPoint];
    end

    if seqNormalCurr(1,6) == 1
        % (6) put the "at rest" frame at the beginning and end of the seq
        seq = MSASLAtRest(seq);
    end
    
%     if seqNormalCurr(1,7) == 1 % simplify
%         reach = TrajReach(seq); % get traj reach 
%         seq = TrajSimp(seq,reach * 0.05);
%     end

end