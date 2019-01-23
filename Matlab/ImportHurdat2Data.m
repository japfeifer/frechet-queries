% import HURDAT2 hurricane data - ATLANTIC hurricane data
% only import trajectories with >=5 vertices

tic;
h = waitbar(0, 'Running HURDAT2 Data Import');
filename = 'hurdat2-1851-2016-041117.txt';
fileID = fopen(filename);
H2Data = textscan(fileID,'%s','Delimiter','\n');
fclose(fileID);

H2Data = H2Data{1,1};

% massage data to new format
trajData = {[]};
currTraj = [];
trajCount = 1;
dataSize = size(H2Data,1);

for i = 2:dataSize    
    currRec = split(H2Data(i),",");
    if (i>1) && (size(currRec,1) <= 4)  % output traj

        if size(currTraj,1) >= 5 % only save traj with 5 or more vertices
            trajData(trajCount,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
            trajCount = trajCount + 1;
        end
        currTraj = [];
        
    else   % just add next vertex to traj

        % get longitude number
        currX = strtrim(cell2mat(currRec(6)));
        currXEW = currX(end:end); % text for E or W
        currX = str2num(currX(1:end-1));
        if strcmp(currXEW,'W') == true  % convert longitude to neg number
            currX = currX * -1;
        end
        
        % get latitude number
        currY = strtrim(cell2mat(currRec(5)));
        currYNS = currY(end:end); % text for N or S
        currY = str2num(currY(1:end-1));
        if strcmp(currYNS,'S') == true  % convert longitude to neg number
            currY = currY * -1;
        end
        if currX > -350 % there seems to be some bad longitude data
            % save vertex in traj
            currTraj = [currTraj; currX currY]; 
        end
    end
    waitbar(i/dataSize, h);
end
% save last traj
trajData(trajCount,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));

% convert Greenwich (lat lon) coordinates to equal-area coordinate
% points x and y
for i=1:size(trajData,1)
    currTraj = cell2mat(trajData(i,1));
    currTraj = grn2eqa(currTraj(:,2),currTraj(:,1));
    trajData(i,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
end

close(h);
timeElapsed = toc;
